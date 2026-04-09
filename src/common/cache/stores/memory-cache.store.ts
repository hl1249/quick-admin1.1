import { Logger } from '@nestjs/common';
import type Redis from 'ioredis';
import type { ICacheStore, MemoryCacheItem } from '../cache.store';

export class MemoryCacheStore implements ICacheStore {
  readonly type = 'memory' as const;

  private readonly logger = new Logger(MemoryCacheStore.name);
  private readonly cache = new Map<string, MemoryCacheItem>();

  constructor() {
    this.logger.log('使用内存缓存');
  }

  async get<T>(key: string): Promise<T | undefined> {
    const cached = this.getValidItem(key);
    return cached?.value as T | undefined;
  }

  async set<T>(key: string, value: T, ttl: number): Promise<void> {
    const expireAt = ttl > 0 ? Date.now() + ttl : Infinity;
    this.cache.set(key, { value, expireAt });
  }

  async delete(key: string): Promise<void> {
    this.cache.delete(key);
  }

  async deleteByPrefix(prefix: string): Promise<void> {
    for (const key of this.cache.keys()) {
      if (key.startsWith(prefix)) {
        this.cache.delete(key);
      }
    }
  }

  async clear(): Promise<void> {
    this.cache.clear();
  }

  async has(key: string): Promise<boolean> {
    return this.getValidItem(key) !== undefined;
  }

  async incr(key: string, increment: number): Promise<number> {
    const cached = this.getValidItem(key);
    const currentValue = typeof cached?.value === 'number' ? cached.value : 0;
    const expireAt = cached?.expireAt ?? Infinity;
    const newValue = currentValue + increment;

    this.cache.set(key, { value: newValue, expireAt });
    return newValue;
  }

  getRedisClient(): Redis | null {
    return null;
  }

  async destroy(): Promise<void> {
    this.cache.clear();
  }

  private getValidItem(key: string): MemoryCacheItem | undefined {
    const cached = this.cache.get(key);
    if (!cached) return undefined;

    if (cached.expireAt < Date.now()) {
      this.cache.delete(key);
      return undefined;
    }

    return cached;
  }
}
