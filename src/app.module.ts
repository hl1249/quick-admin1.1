import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { DynamicModule } from '@/app/dynamic.module';

import { Public } from '@/public.module';
@Module({
  imports: [Public,
    DynamicModule.register()
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
