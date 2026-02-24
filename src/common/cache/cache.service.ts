import { Injectable, Logger } from '@nestjs/common';
import Redis from 'ioredis';
import { ICacheService } from './cache.interface';
import { CacheFactory, MemoryCacheItem } from './cache.factory';
import { CACHE_PREFIX } from '@/config';

@Injectable()
export class CacheService implements ICacheService {
  private readonly logger = new Logger(CacheService.name);
  private readonly redisClient: Redis | null;
  private readonly memoryCache: Map<string, MemoryCacheItem> | null;
  private readonly defaultTTL: number;

  constructor(private readonly cacheFactory: CacheFactory) {
    this.redisClient = cacheFactory.getRedisClient();
    this.memoryCache = cacheFactory.getMemoryCache();
    this.defaultTTL = cacheFactory.defaultTTL;
  }

  private withPrefix(key: string) {
    return `${CACHE_PREFIX}:${key}`;
  }

  async get<T>(key: string): Promise<T | undefined> {
    try {
      const fullKey = this.withPrefix(key);

      if (this.redisClient) {
        const data = await this.redisClient.get(fullKey);
        return data ? JSON.parse(data) : undefined;
      } else if (this.memoryCache) {
        const cached = this.memoryCache.get(fullKey);
        if (!cached) return undefined;

        if (cached.expireAt < Date.now()) {
          this.memoryCache.delete(fullKey);
          return undefined;
        }

        return cached.value;
      }

      return undefined;
    } catch (error) {
      this.logger.error(`Error getting cache key ${key}:`, error);
      return undefined;
    }
  }

  async set<T>(key: string, value: T, ttl?: number): Promise<void> {
    try {
      const fullKey = this.withPrefix(key);
      const actualTTL = ttl !== undefined ? ttl : this.defaultTTL;

      if (this.redisClient) {
        const serialized = JSON.stringify(value);
        if (actualTTL > 0) {
          await this.redisClient.set(fullKey, serialized, 'PX', actualTTL);
        } else {
          await this.redisClient.set(fullKey, serialized);
        }
      } else if (this.memoryCache) {
        const expireAt = actualTTL > 0 ? Date.now() + actualTTL : Infinity;
        this.memoryCache.set(fullKey, { value, expireAt });
      }
    } catch (error) {
      this.logger.error(`Error setting cache key ${key}:`, error);
    }
  }

  async delete(key: string): Promise<void> {
    try {
      const fullKey = this.withPrefix(key);

      if (this.redisClient) {
        await this.redisClient.del(fullKey);
      } else if (this.memoryCache) {
        this.memoryCache.delete(fullKey);
      }
    } catch (error) {
      this.logger.error(`Error deleting cache key ${key}:`, error);
    }
  }

  // 根据前缀删除缓存
  async deleteByPrefix(prefix: string): Promise<void> {
    try {
      const fullPrefix = `${CACHE_PREFIX}:${prefix}`;

      if (this.redisClient) {
        let cursor = '0';
        do {
          const [newCursor, keys] = await this.redisClient.scan(
            cursor,
            'MATCH',
            `${fullPrefix}*`,
            'COUNT',
            100
          );
          cursor = newCursor;

          if (keys.length > 0) {
            await this.redisClient.del(...keys);
          }
        } while (cursor !== '0');
      } else if (this.memoryCache) {
        for (const key of this.memoryCache.keys()) {
          if (key.startsWith(fullPrefix)) {
            this.memoryCache.delete(key);
          }
        }
      }
    } catch (error) {
      this.logger.error(`Error deleting cache by prefix ${prefix}:`, error);
    }
  }

  async clear(): Promise<void> {
    try {
      if (this.redisClient) {
        await this.redisClient.flushdb();
      } else if (this.memoryCache) {
        this.memoryCache.clear();
      }
    } catch (error) {
      this.logger.error('Error clearing cache:', error);
    }
  }

  async has(key: string): Promise<boolean> {
    try {
      const fullKey = this.withPrefix(key);

      if (this.redisClient) {
        const exists = await this.redisClient.exists(fullKey);
        return exists === 1;
      } else if (this.memoryCache) {
        const cached = this.memoryCache.get(fullKey);
        if (!cached) return false;

        if (cached.expireAt < Date.now()) {
          this.memoryCache.delete(fullKey);
          return false;
        }

        return true;
      }

      return false;
    } catch (error) {
      this.logger.error(`Error checking cache key ${key}:`, error);
      return false;
    }
  }

  async getOrSet<T>(
    key: string,
    factory: () => Promise<T>,
    ttl?: number
  ): Promise<T> {
    const cached = await this.get<T>(key);

    if (cached !== undefined) {
      return cached;
    }

    const value = await factory();
    await this.set(key, value, ttl);

    return value;
  }

  async getCacheType(): Promise<string> {
    return this.cacheFactory.cacheType;
  }

  /**
   * 递增数值
   * @param key 键名
   * @param increment 递增步长，默认为 1
   * @returns 递增后的值
   */
  async incr(key: string, increment: number = 1): Promise<number> {
    try {
      const fullKey = this.withPrefix(key);

      if (this.redisClient) {
        // Redis 原生支持 INCRBY
        if (increment === 1) {
          return await this.redisClient.incr(fullKey);
        } else {
          return await this.redisClient.incrby(fullKey, increment);
        }
      } else if (this.memoryCache) {
        // 内存缓存手动实现
        const cached = this.memoryCache.get(fullKey);
        let currentValue = 0;

        if (cached && cached.expireAt >= Date.now()) {
          // 如果存在且未过期，获取当前值
          currentValue = typeof cached.value === 'number' ? cached.value : 0;
        }

        const newValue = currentValue + increment;
        // 保持原有的 TTL
        const expireAt = cached?.expireAt ?? Infinity;
        this.memoryCache.set(fullKey, { value: newValue, expireAt });

        return newValue;
      }

      return 0;
    } catch (error) {
      this.logger.error(`Error incrementing cache key ${key}:`, error);
      return 0;
    }
  }

  /**
   * 获取原生 Redis 客户端（用于高级操作）
   */
  getRedisClient(): Redis | null {
    return this.redisClient;
  }
}
