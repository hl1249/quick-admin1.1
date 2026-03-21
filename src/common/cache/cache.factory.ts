import { Injectable, OnModuleDestroy, Logger } from '@nestjs/common';
import Redis from 'ioredis';
import { AppConfigService } from '@/config';

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

  constructor(private readonly appConfig: AppConfigService) {
    this.defaultTTL = this.appConfig.cacheTtl * 1000;
    this.cacheType = this.appConfig.cacheType;
    this.initCache();
  }

  private initCache() {
    if (this.appConfig.cacheType === 'redis') {
      this.redisClient = new Redis({
        host: this.appConfig.redisHost,
        port: this.appConfig.redisPort,
        password: this.appConfig.redisPassword || undefined,
        db: this.appConfig.redisDb,
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
