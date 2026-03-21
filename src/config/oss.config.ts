import { ConfigService } from '@nestjs/config';

export type OssProvider = 'local' | 'tencent' | 'aliyun' | 'qiniu';

const env = (config: ConfigService, key: string, fallback = ''): string =>
  config.get<string>(key) ?? fallback;

const parseProvider = (value: string): OssProvider => {
  const v = value.toLowerCase();
  if (v === 'local' || v === 'tencent' || v === 'aliyun' || v === 'qiniu') {
    return v;
  }
  return 'local';
};

export type OssConfig = {
  provider: OssProvider;
  local: { rootDir: string; publicBaseUrl: string };
  tencent: {
    SecretId: string;
    SecretKey: string;
    Bucket: string;
    Region: string;
    Domain: string;
  };
  aliyun: {
    accessKeyId: string;
    accessKeySecret: string;
    bucket: string;
    region: string;
    endpoint: string;
    domain: string;
  };
  qiniu: {
    accessKey: string;
    secretKey: string;
    bucket: string;
    region: string;
    domain: string;
  };
};

export function createOssConfig(config: ConfigService): OssConfig {
  return {
    provider: parseProvider(env(config, 'OSS_PROVIDER', 'tencent')),
    local: {
      rootDir: env(config, 'LOCAL_OSS_ROOT_DIR', 'uploads'),
      publicBaseUrl: env(config, 'LOCAL_OSS_PUBLIC_BASE_URL', ''),
    },
    tencent: {
      SecretId: env(config, 'SecretId', env(config, 'TENCENT_OSS_SECRET_ID')),
      SecretKey: env(config, 'SecretKey', env(config, 'TENCENT_OSS_SECRET_KEY')),
      Bucket: env(config, 'TENCENT_OSS_BUCKET'),
      Region: env(config, 'TENCENT_OSS_REGION'),
      Domain: env(config, 'TENCENT_OSS_DOMAIN'),
    },
    aliyun: {
      accessKeyId: env(config, 'ALIYUN_OSS_ACCESS_KEY_ID'),
      accessKeySecret: env(config, 'ALIYUN_OSS_ACCESS_KEY_SECRET'),
      bucket: env(config, 'ALIYUN_OSS_BUCKET'),
      region: env(config, 'ALIYUN_OSS_REGION'),
      endpoint: env(config, 'ALIYUN_OSS_ENDPOINT'),
      domain: env(config, 'ALIYUN_OSS_DOMAIN'),
    },
    qiniu: {
      accessKey: env(config, 'QINIU_OSS_ACCESS_KEY'),
      secretKey: env(config, 'QINIU_OSS_SECRET_KEY'),
      bucket: env(config, 'QINIU_OSS_BUCKET'),
      region: env(config, 'QINIU_OSS_REGION'),
      domain: env(config, 'QINIU_OSS_DOMAIN'),
    },
  };
}
