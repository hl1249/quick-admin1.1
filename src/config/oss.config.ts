export type OssProvider = 'local' | 'tencent' | 'aliyun' | 'qiniu';

const env = (key: string, fallback = '') => process.env[key] ?? fallback;

const parseProvider = (value: string): OssProvider => {
  const v = value.toLowerCase();
  if (v === 'local' || v === 'tencent' || v === 'aliyun' || v === 'qiniu') {
    return v;
  }
  return 'local';
};

export const OSS_CONFIG = {
  // 当前启用的存储平台
  provider: parseProvider(env('OSS_PROVIDER', 'local')),

  // 本地存储配置
  local: {
    rootDir: env('LOCAL_OSS_ROOT_DIR', 'uploads'),
    publicBaseUrl: env('LOCAL_OSS_PUBLIC_BASE_URL', ''),
  },

  // 腾讯云 COS（永久密钥）
  tencent: {
    SecretId: env('SecretId', env('TENCENT_OSS_SECRET_ID')),
    SecretKey: env('SecretKey', env('TENCENT_OSS_SECRET_KEY')),
    Bucket: env('TENCENT_OSS_BUCKET'),
    Region: env('TENCENT_OSS_REGION'),
    Domain: env('TENCENT_OSS_DOMAIN'),
  },

  // 阿里云 OSS
  aliyun: {
    accessKeyId: env('ALIYUN_OSS_ACCESS_KEY_ID'),
    accessKeySecret: env('ALIYUN_OSS_ACCESS_KEY_SECRET'),
    bucket: env('ALIYUN_OSS_BUCKET'),
    region: env('ALIYUN_OSS_REGION'),
    endpoint: env('ALIYUN_OSS_ENDPOINT'),
    domain: env('ALIYUN_OSS_DOMAIN'),
  },

  // 七牛云 Kodo
  qiniu: {
    accessKey: env('QINIU_OSS_ACCESS_KEY'),
    secretKey: env('QINIU_OSS_SECRET_KEY'),
    bucket: env('QINIU_OSS_BUCKET'),
    region: env('QINIU_OSS_REGION'),
    domain: env('QINIU_OSS_DOMAIN'),
  },
};
