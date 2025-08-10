import { Module } from '@nestjs/common';
import { JwtModule as JwtModuleNest } from '@nestjs/jwt';
import { JwtService } from './jwt.service';

import { JWT_SECRET, JWT_EXPIRES_IN } from '@/config';
@Module({
  imports: [
    JwtModuleNest.register({
      secret: JWT_SECRET, // 密钥
      signOptions: { expiresIn: JWT_EXPIRES_IN }, // token过期时间
    }),
    ],
    providers: [JwtService],
    exports: [JwtService],
})

export class JwtModule {}