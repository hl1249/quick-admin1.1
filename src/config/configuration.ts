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
  // 应用运行时配置：端口、前缀、环境标识等
  app: {
    port: 3000,
    globalPrefix: 'api',
    debug: true,
  },

  // 鉴权相关配置：
  // - permissionUrls / adminRoleId / authorizationHeader / tokenMaxLimit 为项目约定，统一写死在代码里
  // - jwtSecret / jwtExpiresIn / passwordSecret 允许通过环境变量覆盖
  auth: {
    // 这些前缀命中的接口才进入后台权限校验
    permissionUrls: ['/app/admin'],
    // 拥有该角色标识的用户默认视为超级管理员
    adminRoleId: 'admin',
    // token 请求头名称
    authorizationHeader: 'authorization',
    // 同一账号允许同时在线的 token 数量上限
    tokenMaxLimit: 3,
    jwtSecret: process.env.JWT_SECRET ?? '',
    jwtExpiresIn: process.env.JWT_EXPIRES_IN ?? '7d',
    passwordSecret: process.env.PASSWORD_SECRET ?? 'passwordSecret-demo',
  },

  // MongoDB 连接配置
  database: {
    url: process.env.DB_URL ?? 'mongodb://127.0.0.1',
    port: toInt(process.env.DB_PORT, 27017),
    name: process.env.DB_NAME ?? 'quickAdmin',
    user: process.env.DB_USER ?? '',
    password: process.env.DB_PASSWORD ?? '',
    authSource: process.env.DB_AUTH_SOURCE ?? 'admin',
  },

  // Redis 连接配置
  redis: {
    host: process.env.REDIS_HOST ?? '127.0.0.1',
    port: toInt(process.env.REDIS_PORT, 6379),
    password: process.env.REDIS_PASSWORD ?? '',
    db: toInt(process.env.REDIS_DB, 0),
  },

  // 缓存策略：支持 memory / redis，两者公共配置在这里集中定义
  cache: {
    type:
      (process.env.CACHE_TYPE ?? 'redis').trim().toLowerCase() === 'memory'
        ? 'memory'
        : 'redis',
    ttl: toInt(process.env.CACHE_TTL, 604800),
    prefix: 'quickAdmin',
  },

  // 日志数据表配置
  log: {
    dbName: 'qa-logs',
  },

  // 本地文件存储配置
  file: {
    localUploadsDirName: 'uploads',
    localUploadsRoutePrefix: '/uploads',
  },

  // 跨域配置：留空时在上层会被解释为允许任意源 '*' || ['http://localhost:3000','http://localhost:3001']
  cors: {
    origin: "*",
  },
});
