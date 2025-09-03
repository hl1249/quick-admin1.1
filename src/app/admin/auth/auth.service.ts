import { Injectable, BadRequestException, SetMetadata, Request, Post } from '@nestjs/common';
import { DbService } from '@/common/utils/db.service';
import { Document } from 'mongodb'
import { UserDto } from './auth.dto';
import { PASSWORD_SECRET } from '@/config';
import { JwtService } from '@/common/jwt/jwt.service';
import { UtilsService } from '@/common/utils/utils.service';
import * as bcrypt from 'bcryptjs';
@Injectable()
export class authService {
    constructor(
        private readonly dbService: DbService,
        private readonly jwtService: JwtService,
        private readonly utilsService: UtilsService,
    ) {
    }

    @Post()
    async login(userDto: UserDto): Promise<Document | null > {
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

        const isMatch = await bcrypt.compare(password + PASSWORD_SECRET, userInfo.password); // 使用密钥解密密码

        if (!isMatch) {
            // return this.util.errors("")
            throw new BadRequestException('账号或密码错误');
        }
        return {
            token: await this.jwtService.generateToken(userInfo._id.toHexString()),
            expired: await this.jwtService.getExpired(await this.jwtService.generateToken(userInfo._id.toHexString())),
            userInfo: this.utilsService.filterObject(userInfo, ['password'], false)
        }
    }
}