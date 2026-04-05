import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { AppConfigService } from '@/config/app-config.service';
import { JwtService } from '@/common/jwt/jwt.service';
import { Reflector } from '@nestjs/core';
import { DbService } from '@/common/db/db.service';
import { filterObject } from '@/common/utils/utils'

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(
        private readonly reflector: Reflector,
        private readonly jwtService: JwtService,
        private readonly dbService: DbService,
        private readonly appConfig: AppConfigService,
    ) { }

    async canActivate(
        context: ExecutionContext,
    ): Promise<boolean> {
        const handler = context.getHandler();
        const controller = context.getClass();

        // 优先验证是否跳过认证（方法元数据优先于控制器）
        const isPublicMethod = this.reflector.get<boolean>('skipAuth', handler);
        const isPublicController = this.reflector.get<boolean>('skipAuth', controller);
        const isSkipAuth = isPublicMethod !== undefined ? isPublicMethod : isPublicController;
        if (isSkipAuth) {
            return true; // 忽略认证，不再校验 token
        }

        const request = context.switchToHttp().getRequest();
        const authHeader = this.appConfig.authorizationHeader.toLowerCase();
        const source = request.headers[authHeader];
        if (!source || typeof source !== 'string') {
            throw new UnauthorizedException('缺少身份认证信息');
        }
        // 严格按照 RFC 规范检查：Authorization: Bearer <token>
        const [scheme, token] = source.split(' ');
        if (scheme !== 'Bearer' || !token) {
            throw new UnauthorizedException('身份认证格式错误');
        }

        try {
            const userInfo = await this.dbService.findById({
                dbName: "qa-users",
                id: this.jwtService.verifyToken(token)?.userId
            })

            if (token && !userInfo?.token?.includes(token)) throw new UnauthorizedException('身份认证已过期!');

            if (!userInfo) throw new UnauthorizedException('身份认证已过期!');
            
            request['userInfo'] = filterObject(userInfo, ['password', 'token'], false);

            return true
        } catch (e) {
            throw new UnauthorizedException('身份认证已过期!');
        }

    }
}