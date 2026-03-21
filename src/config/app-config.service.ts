import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createOssConfig, type OssConfig } from './oss.config';

@Injectable()
export class AppConfigService {
  constructor(private readonly config: ConfigService) {}

  private raw(key: string): string | undefined {
    const v = this.config.get<string>(key);
    return v !== undefined && v !== '' ? v : undefined;
  }

  get port(): number {
    const v = this.raw('PORT');
    return v !== undefined ? Number(v) : 3000;
  }

  get nodeEnv(): string {
    return this.config.get<string>('NODE_ENV', 'development');
  }

  get debug(): boolean {
    const v = this.raw('DEBUG');
    if (v === undefined) {
      return this.nodeEnv !== 'production';
    }
    return v === '1' || v.toLowerCase() === 'true';
  }

  get dbUrl(): string {
    return this.config.get<string>('DB_URL', 'mongodb://127.0.0.1');
  }

  get dbPort(): number {
    const v = this.raw('DB_PORT');
    return v !== undefined ? Number(v) : 27017;
  }

  get dbName(): string {
    return this.config.get<string>('DB_NAME', 'quickAdmin');
  }

  get dbUser(): string {
    return this.config.get<string>('DB_USER', '');
  }

  get dbPassword(): string {
    return this.config.get<string>('DB_PASSWORD', '');
  }

  get dbAuthSource(): string {
    return this.config.get<string>('DB_AUTH_SOURCE', 'admin');
  }

  get authorizationHeader(): string {
    return this.config.get<string>('AUTHORIZATION', 'authorization');
  }

  get jwtSecret(): string {
    return this.config.get<string>('JWT_SECRET', 'your_jwt_secret_key');
  }

  get jwtExpiresIn(): string {
    return this.config.get<string>('JWT_EXPIRES_IN', '7d');
  }

  get tokenMaxLimit(): number {
    const v = this.raw('TOKEN_MAX_LIMIT');
    return v !== undefined ? Number(v) : 3;
  }

  get passwordSecret(): string {
    return this.config.get<string>('PASSWORD_SECRET', 'passwordSecret-demo');
  }

  get logDbName(): string {
    return this.config.get<string>('LOG_DB_NAME', 'qa-logs');
  }

  get permissionUrls(): string[] {
    const raw = this.config.get<string>('PERMISSION_URLS', '/app/admin/');
    return raw
      .split(',')
      .map((s) => s.trim())
      .filter(Boolean);
  }

  get adminRoleId(): string {
    return this.config.get<string>('ADMIN_ROLE_ID', 'admin');
  }

  get cacheType(): 'redis' | 'memory' {
    return this.config.get<string>('CACHE_TYPE', 'redis') === 'redis'
      ? 'redis'
      : 'memory';
  }

  get cacheTtl(): number {
    const v = this.raw('CACHE_TTL');
    return v !== undefined ? Number(v) : 604800;
  }

  get cachePrefix(): string {
    return this.config.get<string>('CACHE_PREFIX', 'quickAdmin');
  }

  get redisPort(): number {
    const v = this.raw('REDIS_PORT');
    return v !== undefined ? Number(v) : 6379;
  }

  get redisHost(): string {
    return this.config.get<string>('REDIS_HOST', '127.0.0.1');
  }

  get redisPassword(): string {
    return this.config.get<string>('REDIS_PASSWORD', '');
  }

  /** CORS：未配置或为空时为 true（允许任意源，与原先一致） */
  get corsOrigin(): string[] | true {
    const raw = this.raw('CORS_ORIGIN');
    if (raw === undefined) {
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
