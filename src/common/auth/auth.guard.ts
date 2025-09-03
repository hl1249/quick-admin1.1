import { Injectable, CanActivate, ExecutionContext, UnauthorizedException  } from '@nestjs/common';
import { Observable } from 'rxjs';
import { AUTHORIZATION } from '@/config';
import { JwtService } from '@/common/jwt/jwt.service';
import { Reflector } from '@nestjs/core';
import { DbService } from '@/common/utils/db.service';

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(
        private readonly reflector: Reflector,
        private readonly jwtService: JwtService,
        private readonly dbService: DbService,
    ) { }

    async canActivate(
        context: ExecutionContext,
    ): Promise<boolean>  {
        const request = context.switchToHttp().getRequest();
        const token = request.headers[AUTHORIZATION];

        const handler = context.getHandler();
        const controller = context.getClass();

        // 获取方法的元数据，优先级高于控制器的元数据
        const isPublicMethod = this.reflector.get<boolean>('isNoAuth', handler);
        const isPublicController = this.reflector.get<boolean>('isNoAuth', controller);

        // console.log('isNoAuth',context.getClass())
        // 如果装饰带有isNoAuth 那么可以忽略token认证
        if (isPublicMethod || isPublicController) {
            return true; // 忽略认证
        }

        try{
            const userInfo = await this.dbService.findById({
                dbName: "qa-users",
                id: this.jwtService.verifyToken(token)?.userId
            })

            if(!userInfo)  throw new UnauthorizedException('身份认证已过期'!);
            request['userInfo'] = userInfo;

            return true
        }catch(e){
            throw new UnauthorizedException('身份认证已过期'!);
        }
        
    }
}