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
                    _id: false
                }
            }]
        })

        if (permissionsUrlList && Array.isArray(permissionsUrlList)) {

            if (permissionsUrlList.some(item => item.role === ADMIN_ROLE_ID)) { // 超级管理员不进行权限验证
                return true
            }

            // 获取用户所有权限url
            const allowedUrls = [...new Set(permissionsUrlList.flatMap(item => item.user_permission.flatMap((it: any) => it.url)))]
            if (!this.matchesPatterns(url, allowedUrls)) {
                throw new ForbiddenException('没有权限访问该接口');
            }
        }

        return true
    }

    private matchesPatterns(url: string, patterns: string[]): boolean {
        return patterns.some(pattern => {
            // 去掉尾部的 '*'，作为前缀
            const prefix = pattern.endsWith('*') ? pattern.slice(0, -1) : pattern;
            return url.startsWith(prefix);
        });
    }
}