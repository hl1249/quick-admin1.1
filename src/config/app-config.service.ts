import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createOssConfig, type OssConfig } from './oss.config';

@Injectable()
export class AppConfigService {
  constructor(private readonly config: ConfigService) {}

  get port(): number {
    return this.config.get<number>('app.port') ?? 3000;
  }

  get globalPrefix(): string {
    return (this.config.get<string>('app.globalPrefix') ?? 'api').trim();
  }

  get nodeEnv(): string {
    return this.config.get<string>('app.nodeEnv') ?? 'development';
  }

  get debug(): boolean {
    return this.config.get<boolean>('app.debug') ?? false;
  }

  get dbUrl(): string {
    return this.config.get<string>('database.url') ?? 'mongodb://127.0.0.1';
  }

  get dbPort(): number {
    return this.config.get<number>('database.port') ?? 27017;
  }

  get dbName(): string {
    return this.config.get<string>('database.name') ?? 'quickAdmin';
  }

  get dbUser(): string {
    return this.config.get<string>('database.user') ?? '';
  }

  get dbPassword(): string {
    return this.config.get<string>('database.password') ?? '';
  }

  get dbAuthSource(): string {
    return this.config.get<string>('database.authSource') ?? 'admin';
  }

  get authorizationHeader(): string {
    return this.config.get<string>('auth.authorizationHeader') ?? 'authorization';
  }

  get jwtSecret(): string {
    return this.config.get<string>('auth.jwtSecret') ?? '';
  }

  get jwtExpiresIn(): string {
    return this.config.get<string>('auth.jwtExpiresIn') ?? '7d';
  }

  get tokenMaxLimit(): number {
    return this.config.get<number>('auth.tokenMaxLimit') ?? 3;
  }

  get passwordSecret(): string {
    return this.config.get<string>('auth.passwordSecret') ?? 'passwordSecret-demo';
  }

  get logDbName(): string {
    return this.config.get<string>('log.dbName') ?? 'qa-logs';
  }

  get logLevel(): string {
    return this.config.get<string>('log.level') ?? 'debug';
  }

  get permissionUrls(): string[] {
    return this.config.get<string[]>('auth.permissionUrls') ?? ['/app/admin/'];
  }

  get adminRoleId(): string {
    return this.config.get<string>('auth.adminRoleId') ?? 'admin';
  }

  get cacheType(): 'redis' | 'memory' {
    const t = this.config.get<string>('cache.type') ?? 'redis';
    return t === 'memory' ? 'memory' : 'redis';
  }

  get cacheTtl(): number {
    return this.config.get<number>('cache.ttl') ?? 604800;
  }

  get cachePrefix(): string {
    return this.config.get<string>('cache.prefix') ?? 'quickAdmin';
  }

  get redisPort(): number {
    return this.config.get<number>('redis.port') ?? 6379;
  }

  get redisHost(): string {
    return this.config.get<string>('redis.host') ?? '127.0.0.1';
  }

  get redisPassword(): string {
    return this.config.get<string>('redis.password') ?? '';
  }

  get redisDb(): number {
    return this.config.get<number>('redis.db') ?? 0;
  }

  /** CORS：未配置或为空时为 true（允许任意源，与原先一致） */
  get corsOrigin(): string[] | true {
    const raw = this.config.get<string>('cors.origin');
    if (raw === undefined || raw.trim() === '') {
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
