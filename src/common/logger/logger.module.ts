import { Module } from '@nestjs/common';
import { AsyncStorageService } from './asyncStorage.service';
import { LogInterceptor } from './logger.interceptor';

@Module({
  providers: [AsyncStorageService, LogInterceptor],
  exports: [AsyncStorageService],
})
export class LogModule {}
