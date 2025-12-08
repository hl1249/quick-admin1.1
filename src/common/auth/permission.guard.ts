import { Injectable, CanActivate, ExecutionContext, ForbiddenException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { PERMISSION_URLS, ADMIN_ROLE_ID } from '@/config';
import { DbService } from '@/common/utils/db.service';
import { _, $ } from '@/common/utils/fieldQueryTemp';
// admin端权限守卫 对接口进行权限验证
@Injectable()
export class PermissionGuard implements CanActivate {
    constructor(
        private readonly reflector: Reflector,
        private readonly dbService: DbService,
    ) { }

    async canActivate(
        context: ExecutionContext,
    ): Promise<boolean> {
        const request = context.switchToHttp().getRequest();
        const url = request.url;

        // 只对 PERMISSION_URLS配置的路由开头的接口进行权限验证
        if (!PERMISSION_URLS.some(item => url.startsWith(item))) return true;
        // throw new ForbiddenException('没有权限访问该接口');

        const handler = context.getHandler();
        const controller = context.getClass();

        // 是否对接口进行鉴权 如果不需要 对函数或者控制器 @SetMetadata("skipPermission", true) 标记
        const isPublicMethod = this.reflector.get<boolean>('skipPermission', handler);
        const isPublicController = this.reflector.get<boolean>('skipPermission', controller);

        // 如果装饰带有skipAuth 那么可以忽略token认证
        if (isPublicMethod || isPublicController) {
            return true; // 忽略认证
        }

        const userInfo = request.userInfo
        if(!userInfo) throw new ForbiddenException('没有权限访问该接口');

        const role = userInfo?.role;

        const permissionsUrlList = await this.dbService.selects({
            dbName: "qa-roles",
            getMain: true,
            whereJson: {
                role_id: _.in(role)
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

        console.log('url',url)
        console.log('permissionsUrlList',permissionsUrlList[0]['user_permission'])
        if (permissionsUrlList && Array.isArray(permissionsUrlList)) {

            const allowedMenus = [...new Set(permissionsUrlList.flatMap(item => item.menu))]
            request['allowedMenus'] = allowedMenus
            if (permissionsUrlList.some(item => item.role_id === ADMIN_ROLE_ID)) { // 如果该用户有一个role 包含系统管理员标识那么不进行验证
                return true
            }

            // 获取用户所有权限url
            // const allowedUrls = [...new Set(permissionsUrlList.flatMap(item => item.user_permission.flatMap((it: any) => it.url)))]
            // console.log('allowedUrls',allowedUrls)
            // if (!this.matchesPatterns(url, allowedUrls)) {
            //     throw new ForbiddenException('没有权限访问该接口');
            // }

            // 获取用户所有权限配置（包含url和match_mode）
            const permissionConfigs = permissionsUrlList.flatMap(item => 
                item.user_permission.map((it: any) => ({
                    url: it.url,
                    match_mode: it.match_mode !== undefined ? it.match_mode : 1 // 默认通配符模式
                }))
            )
            
            // 扁平化所有权限URL，同时保留匹配模式信息
            const allPermissions = permissionConfigs.flatMap(config => 
                config.url.map(url => ({
                    pattern: url,
                    match_mode: config.match_mode
                }))
            )
            
            console.log('allPermissions', allPermissions)
            
            if (!this.matchesPatternsWithMode(url, allPermissions)) {
                throw new ForbiddenException('没有权限访问该接口');
            }
        }

        return true
    }

    // 修改后的匹配方法，支持三种匹配模式
    private matchesPatternsWithMode(url: string, permissions: Array<{pattern: string, match_mode: number}>): boolean {
        console.log("权限验证",url,permissions)
        return permissions.some(permission => {
            const { pattern, match_mode } = permission;
            
            // 如果模式为空，直接返回false
            if (!pattern || pattern.trim() === '') {
                return false;
            }
            
            try {
                switch (match_mode) {
                    case 0: // 完整路径匹配
                        return url === pattern;
                        
                    case 1: // 通配符匹配（默认）
                        // 将 * 转换成正则通配符
                        const regexPattern = '^' + pattern.replace(/\*/g, '.*') + '$';
                        const regex = new RegExp(regexPattern);
                        return regex.test(url);
                        
                    case 2: // 正则表达式匹配
                        const regexFromPattern = new RegExp(pattern);
                        return regexFromPattern.test(url);
                        
                    default: // 默认使用通配符匹配
                        const defaultRegexPattern = '^' + pattern.replace(/\*/g, '.*') + '$';
                        const defaultRegex = new RegExp(defaultRegexPattern);
                        return defaultRegex.test(url);
                }
            } catch (error) {
                // 如果正则表达式有误，记录错误并返回false
                console.error(`匹配模式错误: pattern=${pattern}, match_mode=${match_mode}, error=${error}`);
                return false;
            }
        });
    }
}