// 必须最先加载：在其他模块读环境变量之前解析项目根 .env
import './load-env';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { AppConfigService } from '@/config/app-config.service';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const appConfig = app.get(AppConfigService);
  if (appConfig.globalPrefix) {
    app.setGlobalPrefix(appConfig.globalPrefix);
  }
  app.enableCors({
    origin: appConfig.corsOrigin,
    credentials: true,
  });
  await app.listen(appConfig.port);
}
bootstrap();
