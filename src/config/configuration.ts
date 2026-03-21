const toInt = (v: string | undefined, fallback: number): number => {
  const n = Number.parseInt(v ?? '', 10);
  return Number.isNaN(n) ? fallback : n;
};

/**
 * 集中配置：
 * - 环境相关：只读取 .env 中的环境变量
 * - 业务固定项：统一写在这里，避免散落到 .env
 */
export default () => ({
  app: {
    port: toInt(process.env.PORT, 3000),
    globalPrefix: 'api',
    nodeEnv: process.env.NODE_ENV ?? 'development',
    debug: process.env.DEBUG === 'true',
  },
  auth: {
    permissionUrls: ['/app/admin'],
    adminRoleId: 'admin',
    authorizationHeader: 'authorization',
    tokenMaxLimit: 3,
    jwtSecret: process.env.JWT_SECRET,
    jwtExpiresIn: process.env.JWT_EXPIRES_IN,
    passwordSecret: process.env.PASSWORD_SECRET,
  },
  database: {
    url: process.env.DB_URL ?? 'mongodb://127.0.0.1',
    port: toInt(process.env.DB_PORT, 27017),
    name: process.env.DB_NAME ?? 'quickAdmin',
    user: process.env.DB_USER ?? '',
    password: process.env.DB_PASSWORD ?? '',
    authSource: process.env.DB_AUTH_SOURCE ?? 'admin',
  },
  redis: {
    host: process.env.REDIS_HOST ?? '127.0.0.1',
    port: toInt(process.env.REDIS_PORT, 6379),
    password: process.env.REDIS_PASSWORD ?? '',
    db: toInt(process.env.REDIS_DB, 0),
  },
  cache: {
    type:
      (process.env.CACHE_TYPE ?? 'redis').trim().toLowerCase() === 'memory'
        ? 'memory'
        : 'redis',
    ttl: toInt(process.env.CACHE_TTL, 604800),
    prefix: 'quickAdmin',
  },
  log: {
    dbName: process.env.LOG_DB_NAME ?? 'qa-logs',
    level: process.env.LOG_LEVEL ?? 'debug',
  },
  cors: {
    origin: process.env.CORS_ORIGIN ?? '',
  },
});
