import { Injectable, OnModuleDestroy } from '@nestjs/common';
import Keyv from 'keyv';
import KeyvRedis from '@keyv/redis';
import { CACHE_TYPE, CACHE_TTL, REDIS_HOST, REDIS_PORT, REDIS_PASSWORD } from '@/config';
@Injectable()
export class CacheFactory implements OnModuleDestroy {
  private cacheInstance: Keyv;

  constructor() {
    this.initCache();
  }

  private initCache() {
    if (CACHE_TYPE === 'redis') {
      this.cacheInstance = new Keyv({
        store: new KeyvRedis(`redis://${REDIS_PASSWORD}:@${REDIS_HOST}:${REDIS_PORT}`),
        ttl: CACHE_TTL * 1000,
      });
      
    } else {
      // 内存缓存配置
      this.cacheInstance = new Keyv({ 
        ttl:CACHE_TTL * 1000,
      });

    }

    // 处理错误
    this.cacheInstance.on('error', (error) => {
      console.error('Redis 连接失败:', error.message);
    });
  }

  getCache(): Keyv {
    return this.cacheInstance;
  }

  async onModuleDestroy() {
    if (this.cacheInstance) {
      await this.cacheInstance.disconnect?.();
    }
  }
}