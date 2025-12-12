import { Injectable, Inject } from '@nestjs/common';
import Keyv from 'keyv';
import { ICacheService } from './cache.interface';
import { CacheFactory } from './cache.factory';

@Injectable()
export class CacheService implements ICacheService {
  private cache: Keyv;

  constructor(private readonly cacheFactory: CacheFactory) {
    this.cache = cacheFactory.getCache();
  }

  async get<T>(key: string): Promise<T | undefined> {
    try {
      console.log("我在获取"+key)
      return await this.cache.get(key);
    } catch (error) {
      console.error(`Error getting cache key ${key}:`, error);
      return undefined;
    }
  }

  async set<T>(key: string, value: T, ttl?: number): Promise<void> {
    try {
      await this.cache.set(key, value, ttl);
    } catch (error) {
      console.error(`Error setting cache key ${key}:`, error);
    }
  }

  async delete(key: string): Promise<void> {
    try {
      await this.cache.delete(key);
    } catch (error) {
      console.error(`Error deleting cache key ${key}:`, error);
    }
  }

  async clear(): Promise<void> {
    try {
      await this.cache.clear();
    } catch (error) {
      console.error('Error clearing cache:', error);
    }
  }

  async has(key: string): Promise<boolean> {
    try {
      return await this.cache.has(key);
    } catch (error) {
      console.error(`Error checking cache key ${key}:`, error);
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
    return process.env.CACHE_TYPE || 'memory';
  }
}