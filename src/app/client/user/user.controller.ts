import { Controller, Get, Post, Body, Req, SetMetadata, BadRequestException, Ip } from '@nestjs/common';
import { Document } from 'mongodb'
import { UserDto } from './user.dto';
import { DbService } from '@/common/utils/db.service';
import { JwtService } from '@/common/jwt/jwt.service';
import { filterObject } from '@/common/utils/utils'
import { AppConfigService } from '@/config';
import * as bcrypt from 'bcryptjs';
@Controller()
export class UserController {
    constructor(
        private readonly dbService: DbService,
        private readonly jwtService: JwtService,
        private readonly appConfig: AppConfigService,
    ) {
    }

    @SetMetadata('skipAuth', true) // 设置该路由不需要验证
    @Post('/login')
    async login(
        @Body() userDto: UserDto,
        @Ip() ipAddress: string,
        @Req() req
    ): Promise<Document | null> {
        const { username, password } = userDto;
        const userInfo = await this.dbService.findByWhereJson({
            dbName: "qa-users",
            whereJson: {
                username,
            }
        })
        if (!userInfo) {
            throw new BadRequestException('账号或密码错误');
        }

        const isMatch = await bcrypt.compare(password + this.appConfig.passwordSecret, userInfo.password); // 使用密钥解密密码

        if (!isMatch) {
            throw new BadRequestException('账号或密码错误');
        }

        const token = await this.jwtService.generateToken(userInfo._id.toHexString())


        const passTokens = [
            ...this.jwtService.verifyTokens(userInfo.token || []), // 过滤掉过期 token
            token, // 添加新 token
        ].slice(-this.appConfig.tokenMaxLimit); // 保留最后 N 个 token

        await this.dbService.update({
            dbName: "qa-users",
            whereJson: {
                _id: userInfo._id
            },
            dataJson: {
                last_login_date: Date.now(),
                last_login_ip: ipAddress?.startsWith('::ffff:') ? ipAddress.substring(7) : '未知IP', // 保存最后登录ip
                token: passTokens, // 保存token到数组
            }
        })

        return {
            token,
            expired: await this.jwtService.getExpired(await this.jwtService.generateToken(userInfo._id.toHexString())),
            userInfo: filterObject(userInfo, ['password', 'token'], false)
        }

    }
}