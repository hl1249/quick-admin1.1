import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { join } from 'node:path';
import configuration from '@/config/configuration';
import { AppConfigModule } from '@/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { APP_PIPE, APP_GUARD, APP_INTERCEPTOR, APP_FILTER } from '@nestjs/core';

// TOKEN守卫、响应拦截器、异常过滤器、全局验证管道、后台接口鉴权
import { AuthGuard } from '@/common/auth/auth.guard';
import { ResponseInterceptor } from '@/common/response/response.interceptors';
import { ExceptionsFilter } from '@/common/exception/exception.filters';
import { ValidationPipe } from '@/common/validation/validation.pipe';
import { PermissionGuard } from '@/common/auth/permission.guard';

// 异步加载控制器
import { DynamicModule } from '@/app/dynamic.module';

import { Public } from '@/public.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      load: [configuration],
      envFilePath: [
        join(__dirname, '..', '.env'),
        join(__dirname, '..', '.env.local'),
      ],
    }),
    AppConfigModule,
    Public,
    DynamicModule.register(),
  ],
  controllers: [AppController],
  providers: [AppService,
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    }, {
      provide: APP_INTERCEPTOR,
      useClass: ResponseInterceptor,
    }, {
      provide: APP_FILTER,
      useClass: ExceptionsFilter,
    },{
      provide: APP_PIPE,
      useClass: ValidationPipe,
    },{
      provide: APP_GUARD,
      useClass: PermissionGuard,
    }
  ],
})
export class AppModule {}
