
// 服务运行端口
export const PORT = 3001;

// debug 模式
export const DEBUG = true;

// 数据库连接地址
export const DB_URL = 'mongodb://127.0.0.1'; 

// 数据库端口
export const DB_PORT = 27017

 // 数据库名称
export const DB_NAME = 'quickAdmin';

// TOKEN请求头验证字段
export const AUTHORIZATION = 'authorization'

// JWT 加密密钥
export const JWT_SECRET = 'your_jwt_secret_key';

// JWT 过期时间
export const JWT_EXPIRES_IN = '7d';

// toeken 最大登录数量
export const TOKEN_MAX_LIMIT = 3;

// 密码加密密钥
export const PASSWORD_SECRET = "passwordSecret-demo";

// 日志表名称
export const LOG_DB_NAME = 'qa-logs';

// 需要接口鉴权模块 如果走后台模块会做接口路由鉴权
export const PERMISSION_URLS = [
    '/app/admin/'
]

// 系统管理员role_id标识 对应 qa-roles 表中的 role_id 字段 无视接口鉴权
export const ADMIN_ROLE_ID = 'admin';

// 缓存类型
export const CACHE_TYPE: 'redis' | 'memory' = 'memory';

// 缓存时间 单位/秒
export const CACHE_TTL = 604800; // 7天

// 缓存命名空间
export const CACHE_PREFIX = 'quickadmin';

// redis端口
export const REDIS_PORT = 6379;

// redis地址
export const REDIS_HOST = '127.0.0.1';

// redis密码
export const REDIS_PASSWORD = '';

