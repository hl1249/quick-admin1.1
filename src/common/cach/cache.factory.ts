import { Injectable, OnModuleDestroy } from '@nestjs/common';
import Keyv from 'keyv';
import KeyvRedis from '@keyv/redis';
import { CACHE_TYPE, CACHE_MAX, CACHE_TTL, REDIS_HOST, REDIS_PORT, REDIS_PASSWORD } from '@/config';
@Injectable()
export class CacheFactory implements OnModuleDestroy {
  private cacheInstance: Keyv;

  constructor() {
    this.initCache();
  }

  private initCache() {
    if (CACHE_TYPE === 'redis') {;
      this.cacheInstance = new Keyv({
        store: new KeyvRedis(`redis://${REDIS_PASSWORD}:@${REDIS_HOST}:${REDIS_PORT}`),
        ttl: CACHE_TTL * 1000,
      });
      
    } else {
      // 内存缓存配置
      this.cacheInstance = new Keyv({ 
        ttl:CACHE_TTL,
        // Keyv内置内存存储会自动使用LRU算法
        // 最大条目数通过max参数设置
      });

      // 手动实现内存存储的LRU限制
      this.setupMemoryCacheLimit(CACHE_MAX);
    }

    // 处理错误
    this.cacheInstance.on('error', (error) => {
      console.error('Redis 连接失败:', error.message);
    });
  }

  /**
   * 为内存缓存设置大小限制
   */
  private setupMemoryCacheLimit(max: number) {
    if (max > 0) {
      const store = this.cacheInstance['store'];
      const originalSet = store.set;
      const cacheMap = new Map();
      const keyQueue: string[] = [];

      store.set = async (key: string, value: any, ttl?: number) => {
        // 如果超过最大限制，移除最旧的
        if (cacheMap.size >= max) {
          const oldestKey = keyQueue.shift();
          if (oldestKey) {
            cacheMap.delete(oldestKey);
            await store.delete(oldestKey);
          }
        }

        cacheMap.set(key, true);
        keyQueue.push(key);
        
        return originalSet.call(store, key, value, ttl);
      };

      store.delete = async (key: string) => {
        const index = keyQueue.indexOf(key);
        if (index > -1) {
          keyQueue.splice(index, 1);
        }
        cacheMap.delete(key);
        return this.cacheInstance.delete(key);
      };

      store.clear = async () => {
        cacheMap.clear();
        keyQueue.length = 0;
        return this.cacheInstance.clear();
      };
    }
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