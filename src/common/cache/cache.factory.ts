import { Injectable, OnModuleDestroy } from '@nestjs/common';
import { AppConfigService } from '@/config/app-config.service';
import type { ICacheStore } from './cache.store';
import { MemoryCacheStore } from './stores/memory-cache.store';
import { RedisCacheStore } from './stores/redis-cache.store';

@Injectable()
export class CacheFactory implements OnModuleDestroy {
  private readonly store: ICacheStore;
  public readonly defaultTTL: number;
  public readonly cacheType: 'redis' | 'memory';

  constructor(private readonly appConfig: AppConfigService) {
    this.defaultTTL = this.appConfig.cacheTtl * 1000;
    this.cacheType = this.appConfig.cacheType;
    this.store = this.createStore();
  }

  private createStore(): ICacheStore {
    if (this.cacheType === 'redis') {
      return new RedisCacheStore(this.appConfig);
    }

    return new MemoryCacheStore();
  }

  getStore(): ICacheStore {
    return this.store;
  }

  async onModuleDestroy() {
    await this.store.destroy();
  }
}
