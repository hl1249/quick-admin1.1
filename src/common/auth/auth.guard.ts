import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Observable } from 'rxjs';
import { AUTHORIZATION } from '@/config';
import { JwtService } from '@/common/jwt/jwt.service';

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(
        private readonly jwtService: JwtService,
    ) { }

    canActivate(
        context: ExecutionContext,
    ): boolean | Promise<boolean> | Observable<boolean> {
        const request = context.switchToHttp().getRequest();
        console.log('AuthGuard: Checking authentication for request:', request.url);
        console.log('Headers:', request.headers[AUTHORIZATION]);
        console.log('解密:', this.jwtService.verifyToken(request.headers[AUTHORIZATION]));
        return true
    }
}