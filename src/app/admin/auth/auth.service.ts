import { Injectable, BadRequestException, Req, Request, Post, Ip } from '@nestjs/common';
import { DbService } from '@/common/utils/db.service';
import { Document } from 'mongodb'
import { UserDto } from './auth.dto';
import { PASSWORD_SECRET, TOKEN_MAX_LIMIT, ADMIN_ROLE_ID } from '@/config';
import { JwtService } from '@/common/jwt/jwt.service';
import { UtilsService } from '@/common/utils/utils.service';
import { _, $ } from '@/common/utils/fieldQueryTemp';
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
    async login(
        userDto: UserDto,
        @Ip() ipAddress: string
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

        const isMatch = await bcrypt.compare(password + PASSWORD_SECRET, userInfo.password); // 使用密钥解密密码

        if (!isMatch) {
            throw new BadRequestException('账号或密码错误');
        }

        const token = await this.jwtService.generateToken(userInfo._id.toHexString())


        const passTokens = [
        ...this.jwtService.verifyTokens(userInfo.token || []), // 过滤掉过期 token
        token, // 添加新 token
        ].slice(-TOKEN_MAX_LIMIT); // 保留最后 TOKEN_MAX_LIMIT 个

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
            userInfo: this.utilsService.filterObject(userInfo, ['password', 'token'], false)
        }
    }

    async getMenu(req): Promise<any>{
        const { userInfo, allowedMenus} = req
        let whereJson = {}
        if(!userInfo.role.includes(ADMIN_ROLE_ID)){
            whereJson = {
                menu_id:_.in(allowedMenus)
            }
        }

        const res = await this.dbService.selects({
            dbName:'qa-menus',
            whereJson,
            getMain:true,
            pageSize:200
        })

        let treeProps = {
        id:"name",
        parent_id:"parent_id", 
        children:"children"
        };

        console.log('数组转树',JSON.stringify(this.utilsService.arrayToTree(res as Document[],treeProps),null,2))
        return{
            res,
            menus:this.utilsService.arrayToTree(res as Document[],treeProps)
        }
        console.log('user',userInfo)
        console.log('allowedMenus',allowedMenus)
    }
}