import { Injectable, CanActivate, ExecutionContext, ForbiddenException, Logger } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AppConfigService } from '@/config/app-config.service';
import { DbService } from '@/common/db/db.service';
import { CacheService } from '@/common/cache/cache.service'
import { AuthService } from '@/app/admin/auth/auth.service';
// admin端权限守卫 对接口进行权限验证
@Injectable()
export class PermissionGuard implements CanActivate {
    private readonly logger = new Logger(PermissionGuard.name);

    constructor(
        private readonly reflector: Reflector,
        private readonly dbService: DbService,
        private readonly cache: CacheService,
        private readonly authService: AuthService,
        private readonly appConfig: AppConfigService,
    ) { }

    async canActivate(
        context: ExecutionContext,
    ): Promise<boolean> {
      const request = context.switchToHttp().getRequest();
      // 与 main 中 setGlobalPrefix(GLOBAL_PREFIX) 对齐；业务权限路径多为 /app/admin/... 无全局前缀
      const url = this.normalizePathForPermission(request.url);
      // 只对 PERMISSION_URLS配置的路由开头的接口进行权限验证
      if (
        !this.appConfig.permissionUrls.some((item) =>
          url.startsWith(this.normalizePathForPermission(item)),
        )
      ) {
        return true;
      }
      // throw new ForbiddenException('没有权限访问该接口');

      const handler = context.getHandler();
      const controller = context.getClass();

      // 是否对接口进行鉴权 如果不需要 对函数或者控制器 @SetMetadata("skipPermission", true) 标记
      const isPublicMethod = this.reflector.get<boolean>(
        'skipPermission',
        handler,
      );
      const isPublicController = this.reflector.get<boolean>(
        'skipPermission',
        controller,
      );

      // 如果装饰带有skipAuth 那么可以忽略token认证
      if (isPublicMethod || isPublicController) {
        return true; // 忽略认证
      }

      const userInfo = request.userInfo;
      if (!userInfo) throw new ForbiddenException('没有权限访问该接口');
      const userId = userInfo._id.toHexString();

      // 获取全局权限版本号
      const currentAuthVersion =
        (await this.cache.get<number>('authVersion')) ?? 1;

      // 先从缓存获取用户角色对应的权限列表
      let cachedPermissions = await this.cache.get<{
        allowedMenus: string[];
        role_ids: string[];
        permissionConfigs: Array<{ url: string[]; match_mode: number }>;
        authVersion: number;
      }>(`auth:${userId}`);


      // 检查缓存是否存在或版本是否过期
      const needRebuild = cachedPermissions && cachedPermissions.authVersion !== currentAuthVersion;
      console.log("有没有进权限验证")
      if (!cachedPermissions || needRebuild) {
        // 1. 回填缓存
        await this.authService.buildCacheUserPermission(userInfo);

        // 2. 重新读取
        cachedPermissions = await this.cache.get(`auth:${userId}`);

        // 3. 仍然没有，说明系统异常
        if (!cachedPermissions) {
          throw new ForbiddenException('权限信息初始化失败，请重新登录');
        }
      }

      const { role_ids, permissionConfigs } = cachedPermissions;

      if (role_ids.some((item) => item === this.appConfig.adminRoleId)) {
        // 如果该用户有一个role 包含系统管理员标识那么不进行验证
        return true;
      }

      // 扁平化所有权限URL，同时保留匹配模式信息
      const allPermissions = permissionConfigs.flatMap((config) =>
        config.url.map((url) => ({
          pattern: url,
          match_mode: config.match_mode,
        })),
      );

      console.log('allPermissionsallPermissions',allPermissions)

      if (!this.matchesPatternsWithMode(url, allPermissions)) {
        throw new ForbiddenException('没有权限访问该接口');
      }

      return true;
    }

    /** 去掉查询串，并去掉与 GLOBAL_PREFIX 对应的路径前缀，便于与 PERMISSION_URLS、菜单权限里的路径一致 */
    private normalizePathForPermission(raw: string): string {
      let path = (raw.split('?')[0] ?? '').trim();
      const p = this.appConfig.globalPrefix;
      if (!p) {
        return path;
      }
      const lead = `/${p}`;
      if (path.startsWith(`${lead}/`)) {
        path = path.slice(lead.length);
      } else if (path === lead) {
        path = '/';
      }
      return path;
    }

    // 修改后的匹配方法，支持三种匹配模式
    private matchesPatternsWithMode(url: string, permissions: Array<{pattern: string, match_mode: number}>): boolean {
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
                this.logger.warn(`权限匹配模式错误: pattern=${pattern}, match_mode=${match_mode}`, error);
                return false;
            }
        });
    }


}