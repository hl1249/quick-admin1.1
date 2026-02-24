// 必须在任何读取 @/config 的 import 之前加载 .env，否则 CACHE_TYPE 等会使用默认值
import 'dotenv/config';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { PORT } from '@/config';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix('api');
  app.enableCors({
    origin: process.env.CORS_ORIGIN?.split(',').map((s) => s.trim()) ?? true,
    credentials: true,
  });
  await app.listen(PORT ?? 3000);
}
bootstrap();
