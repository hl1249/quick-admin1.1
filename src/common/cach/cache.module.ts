import { Module, Global } from '@nestjs/common';
import { CacheService } from './cache.service';
import { CacheFactory } from './cache.factory';

@Global() // 设置为全局模块，可以在任何地方使用
@Module({
  providers: [CacheFactory, CacheService],
  exports: [CacheService],
})
export class CacheModule {}