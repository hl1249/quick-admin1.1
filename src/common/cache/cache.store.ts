import Redis from 'ioredis';

export interface MemoryCacheItem {
  value: unknown;
  expireAt: number;
}

export interface ICacheStore {
  readonly type: 'redis' | 'memory';

  get<T>(key: string): Promise<T | undefined>;
  set<T>(key: string, value: T, ttl: number): Promise<void>;
  delete(key: string): Promise<void>;
  deleteByPrefix(prefix: string): Promise<void>;
  clear(): Promise<void>;
  has(key: string): Promise<boolean>;
  incr(key: string, increment: number): Promise<number>;
  getRedisClient(): Redis | null;
  destroy(): Promise<void>;
}
