import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { Public } from '@/public.module';
@Module({
  imports: [Public],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
