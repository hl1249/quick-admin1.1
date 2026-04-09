import { Injectable, Logger } from '@nestjs/common';
import Redis from 'ioredis';
import { CacheFactory } from './cache.factory';
import { AppConfigService } from '@/config/app-config.service';
import type { ICacheStore } from './cache.store';

export interface ICacheService {
  get<T>(key: string): Promise<T | undefined>;
  set<T>(key: string, value: T, ttl?: number): Promise<void>;
  delete(key: string): Promise<void>;
  clear(): Promise<void>;
  has(key: string): Promise<boolean>;
}

@Injectable()
export class CacheService implements ICacheService {
  private readonly logger = new Logger(CacheService.name);
  private readonly store: ICacheStore;
  private readonly defaultTTL: number;
  private readonly cachePrefix: string;

  constructor(
    private readonly cacheFactory: CacheFactory,
    private readonly appConfig: AppConfigService,
  ) {
    this.store = cacheFactory.getStore();
    this.defaultTTL = cacheFactory.defaultTTL;
    this.cachePrefix = this.appConfig.cachePrefix;
  }

  private withPrefix(key: string) {
    return `${this.cachePrefix}:${key}`;
  }

  async get<T>(key: string): Promise<T | undefined> {
    try {
      return await this.store.get<T>(this.withPrefix(key));
    } catch (error) {
      this.logger.error(`Error getting cache key ${key}:`, error);
      return undefined;
    }
  }

  async set<T>(key: string, value: T, ttl?: number): Promise<void> {
    try {
      const actualTTL = ttl !== undefined ? ttl : this.defaultTTL;
      await this.store.set(this.withPrefix(key), value, actualTTL);
    } catch (error) {
      this.logger.error(`Error setting cache key ${key}:`, error);
    }
  }

  async delete(key: string): Promise<void> {
    try {
      await this.store.delete(this.withPrefix(key));
    } catch (error) {
      this.logger.error(`Error deleting cache key ${key}:`, error);
    }
  }

  // 根据前缀删除缓存
  async deleteByPrefix(prefix: string): Promise<void> {
    try {
      await this.store.deleteByPrefix(this.withPrefix(prefix));
    } catch (error) {
      this.logger.error(`Error deleting cache by prefix ${prefix}:`, error);
    }
  }

  async clear(): Promise<void> {
    try {
      await this.store.clear();
    } catch (error) {
      this.logger.error('Error clearing cache:', error);
    }
  }

  async has(key: string): Promise<boolean> {
    try {
      return await this.store.has(this.withPrefix(key));
    } catch (error) {
      this.logger.error(`Error checking cache key ${key}:`, error);
      return false;
    }
  }

  async getOrSet<T>(
    key: string,
    factory: () => Promise<T>,
    ttl?: number,
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
    return this.store.type;
  }

  /**
   * 递增数值
   * @param key 键名
   * @param increment 递增步长，默认为 1
   * @returns 递增后的值
   */
  async incr(key: string, increment: number = 1): Promise<number> {
    try {
      return await this.store.incr(this.withPrefix(key), increment);
    } catch (error) {
      this.logger.error(`Error incrementing cache key ${key}:`, error);
      return 0;
    }
  }

  /**
   * 获取原生 Redis 客户端（用于高级操作）
   */
  getRedisClient(): Redis | null {
    return this.store.getRedisClient();
  }
}
