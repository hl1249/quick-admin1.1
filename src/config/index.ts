// 从环境变量读取配置，需配合 ConfigModule.forRoot() 加载 .env
// 敏感项使用占位默认值，生产环境必须通过环境变量覆盖

const env = (key: string, fallback: string = '') =>
  process.env[key] ?? fallback;

const envNum = (key: string, fallback: number) => {
  const v = process.env[key];
  return v !== undefined && v !== '' ? Number(v) : fallback;
};

const envBool = (key: string, fallback: boolean) => {
  const v = process.env[key];
  if (v === undefined || v === '') return fallback;
  return v === '1' || v.toLowerCase() === 'true';
};

// 服务运行端口
export const PORT = envNum('PORT', 3000);

// debug 模式（生产环境应为 false）
export const DEBUG = envBool('DEBUG', process.env.NODE_ENV !== 'production');

// 数据库连接地址
export const DB_URL = env('DB_URL', 'mongodb://127.0.0.1');

// 数据库端口
export const DB_PORT = envNum('DB_PORT', 27017);

// 数据库名称
export const DB_NAME = env('DB_NAME', 'quickAdmin');

// 数据库用户名
export const DB_USER = env('DB_USER', '');

// 数据库密码（拼写修正：原 DB_PASSWOR）
export const DB_PASSWORD = env('DB_PASSWORD', '');

// 数据库认证源（MongoDB authSource，用于鉴权）
export const DB_AUTH_SOURCE = env('DB_AUTH_SOURCE', 'admin');

// TOKEN 请求头验证字段
export const AUTHORIZATION = env('AUTHORIZATION', 'authorization');

// JWT 加密密钥
export const JWT_SECRET = env('JWT_SECRET', 'your_jwt_secret_key');

// JWT 过期时间
export const JWT_EXPIRES_IN = env('JWT_EXPIRES_IN', '7d');

// token 最大登录数量
export const TOKEN_MAX_LIMIT = envNum('TOKEN_MAX_LIMIT', 3);

// 密码加密盐/密钥
export const PASSWORD_SECRET = env('PASSWORD_SECRET', 'passwordSecret-demo');

// 日志表名称
export const LOG_DB_NAME = env('LOG_DB_NAME', 'qa-logs');

// 需要接口鉴权模块 如果走后台模块会做接口路由鉴权
export const PERMISSION_URLS = (env('PERMISSION_URLS', '/app/admin/'))
  .split(',')
  .map((s) => s.trim())
  .filter(Boolean);

// 系统管理员 role_id 标识 对应 qa-roles 表中的 role_id 字段 无视接口鉴权
export const ADMIN_ROLE_ID = env('ADMIN_ROLE_ID', 'admin');

// 缓存类型
export const CACHE_TYPE: 'redis' | 'memory' =
  env('CACHE_TYPE', 'redis') === 'redis' ? 'redis' : ('memory' as const);

// 缓存时间 单位/秒
export const CACHE_TTL = envNum('CACHE_TTL', 604800); // 7天

// 缓存命名空间
export const CACHE_PREFIX = env('CACHE_PREFIX', 'quickAdmin');

// redis 端口
export const REDIS_PORT = envNum('REDIS_PORT', 6379);

// redis 地址
export const REDIS_HOST = env('REDIS_HOST', '127.0.0.1');

// redis 密码
export const REDIS_PASSWORD = env('REDIS_PASSWORD', '');
