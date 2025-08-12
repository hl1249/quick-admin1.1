import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { PORT } from '@/config';

import { ResponseInterceptor } from '@/common/response/respones.interceptors';
import { ExceptionsFilter } from '@/common/exception/exception.filters';
import { AuthGuard } from '@/common/auth/auth.guard';
async function bootstrap() {
    const app = await NestFactory.create(AppModule);
    // 响应拦截
    const responseInterceptor = app.get(ResponseInterceptor);
    app.useGlobalInterceptors(responseInterceptor);

    // 异常过滤器
    const exceptionsFilter = app.get(ExceptionsFilter);
    app.useGlobalFilters(exceptionsFilter);

    // 守卫由于要使用jwtService，所以需要先在public公共模块provide注入
    const authGuard = app.get(AuthGuard);
    app.useGlobalGuards(authGuard);
    await app.listen(PORT ?? 3000);
}
bootstrap();
