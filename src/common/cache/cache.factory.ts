import { Injectable, OnModuleDestroy, Logger } from '@nestjs/common';
import Redis from 'ioredis';
import { CACHE_TYPE, CACHE_TTL, REDIS_HOST, REDIS_PORT, REDIS_PASSWORD } from '@/config';

export interface MemoryCacheItem {
  value: any;
  expireAt: number;
}

@Injectable()
export class CacheFactory implements OnModuleDestroy {
  private readonly logger = new Logger(CacheFactory.name);
  private redisClient: Redis | null = null;
  private memoryCache: Map<string, MemoryCacheItem> | null = null;
  public readonly defaultTTL: number;
  public readonly cacheType: string;

  constructor() {
    this.defaultTTL = CACHE_TTL * 1000;
    this.cacheType = CACHE_TYPE;
    this.initCache();
  }

  private initCache() {
    if (CACHE_TYPE === 'redis') {
      this.redisClient = new Redis({
        host: REDIS_HOST,
        port: REDIS_PORT,
        password: REDIS_PASSWORD || undefined,
        retryStrategy: (times) => {
          return Math.min(times * 50, 2000);
        },
      });

      this.redisClient.on('error', (error) => {
        this.logger.error('Redis 连接失败: ' + error.message);
      });

      this.redisClient.on('connect', () => {
        this.logger.log('Redis 连接成功');
      });
    } else {
      this.memoryCache = new Map();
      this.logger.log('使用内存缓存');
    }
  }

  /**
   * 获取 Redis 客户端
   */
  getRedisClient(): Redis | null {
    return this.redisClient;
  }

  /**
   * 获取内存缓存实例
   */
  getMemoryCache(): Map<string, MemoryCacheItem> | null {
    return this.memoryCache;
  }

  async onModuleDestroy() {
    if (this.redisClient) {
      await this.redisClient.quit();
    }
    if (this.memoryCache) {
      this.memoryCache.clear();
    }
  }
}
