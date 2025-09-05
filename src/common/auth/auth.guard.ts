import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { AUTHORIZATION } from '@/config';
import { JwtService } from '@/common/jwt/jwt.service';
import { Reflector } from '@nestjs/core';
import { DbService } from '@/common/utils/db.service';
import { _ } from '@/common/utils/fieldQueryTemp';
import { UtilsService } from '@/common/utils/utils.service';

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(
        private readonly reflector: Reflector,
        private readonly jwtService: JwtService,
        private readonly dbService: DbService,
        private readonly utilsService: UtilsService,
    ) { }

    async canActivate(
        context: ExecutionContext,
    ): Promise<boolean> {
        const request = context.switchToHttp().getRequest();
        const token = request.headers[AUTHORIZATION];

        const handler = context.getHandler();
        const controller = context.getClass();

        // 获取方法的元数据，优先级高于控制器的元数据
        const isPublicMethod = this.reflector.get<boolean>('skipAuth', handler);
        const isPublicController = this.reflector.get<boolean>('skipAuth', controller);

        // 如果装饰带有skipAuth 那么可以忽略token认证
        if (isPublicMethod || isPublicController) {
            return true; // 忽略认证
        }

        try {
            const userInfo = await this.dbService.findById({
                dbName: "qa-users",
                id: this.jwtService.verifyToken(token)?.userId
            })

            if (token && !userInfo?.token?.includes(token)) throw new UnauthorizedException('身份认证已过期'!);

            if (!userInfo) throw new UnauthorizedException('身份认证已过期'!);
            
            request['userInfo'] = this.utilsService.filterObject(userInfo, ['password', 'token'], false);

            return true
        } catch (e) {
            throw new UnauthorizedException('身份认证已过期'!);
        }

    }
}