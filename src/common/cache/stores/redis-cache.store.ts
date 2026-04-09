import { Logger } from '@nestjs/common';
import Redis from 'ioredis';
import { AppConfigService } from '@/config/app-config.service';
import type { ICacheStore } from '../cache.store';

export class RedisCacheStore implements ICacheStore {
  readonly type = 'redis' as const;

  private readonly logger = new Logger(RedisCacheStore.name);
  private readonly client: Redis;

  constructor(private readonly appConfig: AppConfigService) {
    this.client = new Redis({
      host: this.appConfig.redisHost,
      port: this.appConfig.redisPort,
      password: this.appConfig.redisPassword || undefined,
      db: this.appConfig.redisDb,
      retryStrategy: (times) => Math.min(times * 50, 2000),
    });

    this.client.on('error', (error) => {
      this.logger.error('Redis 连接失败: ' + error.message);
    });

    this.client.on('connect', () => {
      this.logger.log('Redis 连接成功');
    });
  }

  async get<T>(key: string): Promise<T | undefined> {
    const data = await this.client.get(key);
    return data ? (JSON.parse(data) as T) : undefined;
  }

  async set<T>(key: string, value: T, ttl: number): Promise<void> {
    const serialized = JSON.stringify(value);
    if (ttl > 0) {
      await this.client.set(key, serialized, 'PX', ttl);
      return;
    }

    await this.client.set(key, serialized);
  }

  async delete(key: string): Promise<void> {
    await this.client.del(key);
  }

  async deleteByPrefix(prefix: string): Promise<void> {
    let cursor = '0';

    do {
      const [nextCursor, keys] = await this.client.scan(
        cursor,
        'MATCH',
        `${prefix}*`,
        'COUNT',
        100,
      );
      cursor = nextCursor;

      if (keys.length > 0) {
        await this.client.del(...keys);
      }
    } while (cursor !== '0');
  }

  async clear(): Promise<void> {
    await this.client.flushdb();
  }

  async has(key: string): Promise<boolean> {
    return (await this.client.exists(key)) === 1;
  }

  async incr(key: string, increment: number): Promise<number> {
    if (increment === 1) {
      return this.client.incr(key);
    }

    return this.client.incrby(key, increment);
  }

  getRedisClient(): Redis | null {
    return this.client;
  }

  async destroy(): Promise<void> {
    await this.client.quit();
  }
}
