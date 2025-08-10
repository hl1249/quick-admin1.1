import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { PORT } from '@/config';

import { ResponseInterceptor } from '@/common/response/respones.interceptors';
import { ExceptionsFilter } from '@/common/exception/exception.filters';
async function bootstrap() {
    const app = await NestFactory.create(AppModule);
    app.useGlobalInterceptors(new ResponseInterceptor());
    app.useGlobalFilters(new ExceptionsFilter());
    // await app.listen(process.env.PORT ?? 3000);
    await app.listen(PORT ?? 3000);
 

}
bootstrap();
