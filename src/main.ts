// 必须最先加载：在其他模块读环境变量之前解析项目根 .env
import './load-env';
import { resolve } from 'path';
import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { IoAdapter } from '@nestjs/platform-socket.io';
import { AppModule } from './app.module';
import { AppConfigService } from '@/config/app-config.service';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  const appConfig = app.get(AppConfigService);
  app.useWebSocketAdapter(new IoAdapter(app));
  app.useStaticAssets(resolve(process.cwd(), appConfig.localUploadsDirName), {
    prefix: appConfig.localUploadsRoutePrefix,
  });
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
