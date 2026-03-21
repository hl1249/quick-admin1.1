import { Module } from '@nestjs/common';
import { JwtModule as JwtModuleNest } from '@nestjs/jwt';
import { JwtService } from './jwt.service';

import { AppConfigService } from '@/config';
@Module({
  imports: [
    JwtModuleNest.registerAsync({
      inject: [AppConfigService],
      useFactory: (appConfig: AppConfigService) => ({
        secret: appConfig.jwtSecret,
        signOptions: { expiresIn: appConfig.jwtExpiresIn },
      }),
    }),
  ],
  providers: [JwtService],
  exports: [JwtService],
})
export class JwtModule {}
