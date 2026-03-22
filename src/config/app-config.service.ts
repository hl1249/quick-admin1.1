import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createOssConfig, type OssConfig } from './oss.config';

@Injectable()
export class AppConfigService {
  constructor(private readonly config: ConfigService) {}

  get port(): number {
    return this.config.getOrThrow<number>('app.port');
  }

  get globalPrefix(): string {
    return this.config.getOrThrow<string>('app.globalPrefix').trim();
  }

  get debug(): boolean {
    return this.config.getOrThrow<boolean>('app.debug');
  }

  get dbUrl(): string {
    return this.config.getOrThrow<string>('database.url');
  }

  get dbPort(): number {
    return this.config.getOrThrow<number>('database.port');
  }

  get dbName(): string {
    return this.config.getOrThrow<string>('database.name');
  }

  get dbUser(): string {
    return this.config.getOrThrow<string>('database.user');
  }

  get dbPassword(): string {
    return this.config.getOrThrow<string>('database.password');
  }

  get dbAuthSource(): string {
    return this.config.getOrThrow<string>('database.authSource');
  }

  get authorizationHeader(): string {
    return this.config.getOrThrow<string>('auth.authorizationHeader');
  }

  get jwtSecret(): string {
    return this.config.getOrThrow<string>('auth.jwtSecret');
  }

  get jwtExpiresIn(): string {
    return this.config.getOrThrow<string>('auth.jwtExpiresIn');
  }

  get tokenMaxLimit(): number {
    return this.config.getOrThrow<number>('auth.tokenMaxLimit');
  }

  get passwordSecret(): string {
    return this.config.getOrThrow<string>('auth.passwordSecret');
  }

  get logDbName(): string {
    return this.config.getOrThrow<string>('log.dbName');
  }

  get logLevel(): string {
    return this.config.getOrThrow<string>('log.level');
  }

  get permissionUrls(): string[] {
    return this.config
      .getOrThrow<string[]>('auth.permissionUrls')
      .map((item) => item.trim())
      .filter(Boolean)
      .map((item) => {
        if (item === '/') {
          return item;
        }

        const normalized = item.startsWith('/') ? item : `/${item}`;
        return normalized.endsWith('/') ? normalized.slice(0, -1) : normalized;
      });
  }

  get adminRoleId(): string {
    return this.config.getOrThrow<string>('auth.adminRoleId');
  }

  get cacheType(): 'redis' | 'memory' {
    const t = this.config.getOrThrow<string>('cache.type');
    return t === 'memory' ? 'memory' : 'redis';
  }

  get cacheTtl(): number {
    return this.config.getOrThrow<number>('cache.ttl');
  }

  get cachePrefix(): string {
    return this.config.getOrThrow<string>('cache.prefix');
  }

  get redisPort(): number {
    return this.config.getOrThrow<number>('redis.port');
  }

  get redisHost(): string {
    return this.config.getOrThrow<string>('redis.host');
  }

  get redisPassword(): string {
    return this.config.getOrThrow<string>('redis.password');
  }

  get redisDb(): number {
    return this.config.getOrThrow<number>('redis.db');
  }

  /** CORS：未配置或为空时为 true（允许任意源，与原先一致） */
  get corsOrigin(): string[] | true {
    const raw = this.config.getOrThrow<string>('cors.origin');
    if (raw.trim() === '') {
      return true;
    }
    const list = raw
      .split(',')
      .map((s) => s.trim())
      .filter(Boolean);
    return list.length > 0 ? list : true;
  }

  get mongoUri(): string {
    return `${this.dbUrl}:${this.dbPort}/${this.dbName}`;
  }

  get ossConfig(): OssConfig {
    return createOssConfig(this.config);
  }
}
