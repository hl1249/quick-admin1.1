import { Injectable, BadRequestException, Req, Request, Post, Ip } from '@nestjs/common';
import { DbService } from '@/common/utils/db.service';
import { Document } from 'mongodb'
import { UserDto } from './auth.dto';
import { PASSWORD_SECRET, TOKEN_MAX_LIMIT, ADMIN_ROLE_ID } from '@/config';
import { JwtService } from '@/common/jwt/jwt.service';
import { arrayToTree,filterObject } from '@/common/utils/utils'
import { CacheService } from '@/common/cach/cache.service'
import { _, $ } from '@/common/utils/fieldQueryTemp';
import * as bcrypt from 'bcryptjs';
@Injectable()
export class authService {
    constructor(
        private readonly dbService: DbService,
        private readonly jwtService: JwtService,
        private readonly cache: CacheService
    ) {
    }

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
        
        const userId = userInfo._id.toHexString();

        await this.buildCacheUserPermission(userInfo);
        return {
            token,
            expired: await this.jwtService.getExpired(await this.jwtService.generateToken(userInfo._id.toHexString())),
            userInfo: filterObject(userInfo, ['password', 'token'], false)
        }
    }

    async getMenu(req): Promise<any>{
        const { userInfo} = req
        const userId = userInfo._id.toHexString();
        const cachedPermissions = (await this.cache.get<{allowedMenus: string[]}>(`auth:permission:${userId}`))!;

        console.log('allowedMenus',cachedPermissions.allowedMenus)
        let whereJson = {}
        if(!userInfo.role.includes(ADMIN_ROLE_ID)){
            whereJson = {
                menu_id:_.in(cachedPermissions.allowedMenus)
            }
        }

        const res = await this.dbService.selects({
            dbName:'qa-menus',
            whereJson,
            getMain:true,
            pageSize:200,
            sortArr:[
                {
                    name:"sort",
                    type:"asc"
                }
            ]
        })

        let treeProps = {
            id:"name",
            parent_id:"parent_id", 
            children:"children"
        };
        
        return{
            res,
            menus:arrayToTree(res as Document[],treeProps)
        }
    }

    // 构建用户权限缓存信息
    async buildCacheUserPermission(userInfo: any): Promise<any> {

        const permissionsUrlList = await this.dbService.selects({
            dbName: "qa-roles",
            getMain: true,
            whereJson: {
                role_id: _.in(userInfo.role)
            },
            foreignDB: [{
                dbName: "qa-permissions",
                localKey: "permission",
                localKeyType: "array",
                foreignKey: "permission_id",
                as: "user_permission",
                fieldJson: {
                    url: true,
                    _id: false,
                    match_mode: true, //匹配模式 0 完整路径  1 通配符 2 正则
                }
            }]
        })

        const userId = userInfo._id.toHexString();
        await this.cache.set(`auth:permission:${userId}`, {
            allowedMenus: [...new Set(permissionsUrlList.flatMap(item => item.menu))], 
            permissionConfigs: permissionsUrlList.flatMap(item => 
                item.user_permission.map((it: any) => ({
                    url: it.url,
                    match_mode: it.match_mode !== undefined ? it.match_mode : 1 // 默认通配符模式
                }))
            ),
            role_ids: permissionsUrlList.map(item => item.role_id)
        })
    }

    // 修改角色权限后，删除用户权限缓存
    async clearCacheUserPermissionByRole(): Promise<any> {
        await this.cache.deleteByPrefix(`auth:permission:`)
    }
}