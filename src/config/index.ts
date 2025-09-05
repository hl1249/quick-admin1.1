
// 服务运行端口
export const PORT = 3000;

// debug 模式
export const DEBUG = true;

// 数据库连接地址
export const DB_URL = 'mongodb://127.0.0.1:27017'; 

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

// 需要接口鉴权路由开头 会判断用户是否有调用后台接口权限
export const PERMISSION_URLS = [
    '/app/admin/'
]

// 超级管理员role_id标识 对应 qa-roles 表中的 role_id 字段
export const ADMIN_ROLE_ID = 'admin';