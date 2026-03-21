// 必须在 Nest 启动前加载 .env，与 ConfigModule.forRoot 一致
import 'dotenv/config';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { AppConfigService } from '@/config';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const appConfig = app.get(AppConfigService);
  app.setGlobalPrefix('api');
  app.enableCors({
    origin: appConfig.corsOrigin,
    credentials: true,
  });
  await app.listen(appConfig.port);
}
bootstrap();
