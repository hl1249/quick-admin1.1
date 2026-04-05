import { Injectable } from '@nestjs/common';
import { IOssProvider, OssRegionOption, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, ensureRequired, joinUrl } from '@/common/oss/oss.utils';
import { DbService } from '@/common/db/db.service';

type TencentBucketValidationOptions = {
  bucket: string;
  region: string;
  secretId: string;
  secretKey: string;
  appId?: string;
  acl?: string;
};

type TencentBucketListOptions = {
  secretId: string;
  secretKey: string;
};

type TencentBucketDomainOptions = {
  bucket: string;
  region: string;
  secretId: string;
  secretKey: string;
};

type TencentBucketDomainRule = {
  Status?: string;
  Name?: string;
  Type?: string;
  ForcedReplacement?: string;
};

type TencentServiceBucket = {
  Name?: string;
  Location?: string;
  CreationDate?: string;
  BucketType?: string;
  OFSType?: string;
  AZType?: string;
};

@Injectable()
export class TencentOssProvider implements IOssProvider {
  private client: any = null;
  private activeSpace: {
    accessKey: string;
    secretKey: string;
    name: string;
    region: string;
    domain?: string;
  } | null = null;

  constructor(private readonly dbService: DbService) {}

  private createClient(secretId: string, secretKey: string) {
    const COS = require('cos-nodejs-sdk-v5');
    return new COS({
      SecretId: secretId,
      SecretKey: secretKey,
    });
  }

  private normalizeBucketName(bucket: string, appId?: string) {
    const bucketName = bucket.trim();
    const cleanAppId = appId?.trim();

    ensureRequired('TENCENT_OSS_BUCKET', bucketName);
    if (bucketName.includes('-') || !cleanAppId) {
      return bucketName;
    }

    return `${bucketName}-${cleanAppId}`;
  }

  private async getActiveTencentSpace() {
    const space = await this.dbService.findByWhereJson({
      dbName: 'qa-storage-space',
      whereJson: {
        provider: 'tencent',
        enable: true,
      }
    });

    if (!space) {
      throw new Error('未找到已启用的腾讯云存储空间配置');
    }

    ensureRequired('qa-storage-space.accessKey', space.accessKey || '');
    ensureRequired('qa-storage-space.secretKey', space.secretKey || '');
    ensureRequired('qa-storage-space.name', space.name || '');
    ensureRequired('qa-storage-space.region', space.region || '');

    return {
      accessKey: space.accessKey as string,
      secretKey: space.secretKey as string,
      name: space.name as string,
      region: space.region as string,
      domain: space.domain,
    };
  }

  private async ensureClient() {
    const space = await this.getActiveTencentSpace();
    const shouldReuseClient =
      this.client &&
      this.activeSpace?.accessKey === space.accessKey &&
      this.activeSpace?.secretKey === space.secretKey;

    this.activeSpace = space;
    if (shouldReuseClient) return;

    // 运行时按需加载，避免未安装依赖时报编译错误
    this.client = this.createClient(space.accessKey, space.secretKey);
  }

  async createBucket(options: TencentBucketValidationOptions): Promise<{ bucket: string }> {
    ensureRequired('SecretId', options.secretId);
    ensureRequired('SecretKey', options.secretKey);
    ensureRequired('TENCENT_OSS_REGION', options.region);

    const bucket = this.normalizeBucketName(options.bucket, options.appId);
    const client = this.createClient(options.secretId, options.secretKey);

    try {
      await new Promise<void>((resolve, reject) => {
        client.putBucket(
          {
            Bucket: bucket,
            Region: options.region,
            ACL: options.acl,
          },
          (err: { statusCode?: number; code?: string; message?: string } | null) => {
            if (err) reject(err);
            else resolve();
          }
        );
      });
    } catch (error) {
      const err = error as { statusCode?: number; code?: string; message?: string };
      if (err?.code === 'BucketAlreadyOwnedByYou') {
        return { bucket };
      }
      if (err?.statusCode === 409 || err?.code === 'BucketAlreadyExists') {
        throw new Error(`腾讯云存储桶已存在且不属于当前账号: ${bucket}`);
      }
      if (err?.statusCode === 403 || err?.code === 'AccessDenied') {
        throw new Error(`无权创建腾讯云存储桶: ${bucket}，请检查密钥权限`);
      }
      if (err?.statusCode === 301 || err?.code === 'PermanentRedirect') {
        throw new Error(`腾讯云存储桶地域不正确: ${bucket}，请检查 region 配置`);
      }
      throw new Error(err?.message || `腾讯云存储桶创建失败: ${bucket}`);
    }

    return { bucket };
  }

  async getBucketList(options: TencentBucketListOptions): Promise<{
    owner?: { id?: string; displayName?: string };
    buckets: Array<{
      name: string;
      region: string;
      domain: string;
      creationDate?: string;
      bucketType?: string;
      ofsType?: string;
      azType?: string;
    }>;
  }> {
    ensureRequired('SecretId', options.secretId);
    ensureRequired('SecretKey', options.secretKey);

    const client = this.createClient(options.secretId, options.secretKey);

    let serviceData: {
      Buckets?: TencentServiceBucket[];
      Owner?: { ID?: string; DisplayName?: string };
      statusCode?: number;
    } | null = null;

    try {
      serviceData = await new Promise((resolve, reject) => {
        client.getService(
          (
            err: { statusCode?: number; code?: string; message?: string } | null,
            data: {
              Buckets?: TencentServiceBucket[];
              Owner?: { ID?: string; DisplayName?: string };
              statusCode?: number;
            }
          ) => {
            if (err) reject(err);
            else resolve(data);
          }
        );
      });
    } catch (error) {
      const err = error as { statusCode?: number; code?: string; message?: string };
      if (err?.statusCode === 403 || err?.code === 'AccessDenied') {
        throw new Error('无权获取腾讯云存储桶列表，请检查密钥权限');
      }
      throw new Error(err?.message || '获取腾讯云存储桶列表失败');
    }

    const buckets = (serviceData?.Buckets ?? [])
      .filter((item) => item?.Name && item?.Location)
      .map((item) => ({
        name: item.Name as string,
        region: item.Location as string,
        domain: `https://${item.Name}.cos.${item.Location}.myqcloud.com`,
        creationDate: item.CreationDate,
        bucketType: item.BucketType,
        ofsType: item.OFSType,
        azType: item.AZType,
      }));

    return {
      owner: serviceData?.Owner
        ? {
            id: serviceData.Owner.ID,
            displayName: serviceData.Owner.DisplayName,
          }
        : undefined,
      buckets,
    };
  }

  async getBucketDomainRules(options: TencentBucketDomainOptions): Promise<TencentBucketDomainRule[]> {
    ensureRequired('SecretId', options.secretId);
    ensureRequired('SecretKey', options.secretKey);
    ensureRequired('TENCENT_OSS_BUCKET', options.bucket);
    ensureRequired('TENCENT_OSS_REGION', options.region);

    const client = this.createClient(options.secretId, options.secretKey);

    try {
      const result = await new Promise<{ DomainRule?: TencentBucketDomainRule[] }>((resolve, reject) => {
        client.getBucketDomain(
          {
            Bucket: options.bucket,
            Region: options.region,
          },
          (
            err: { statusCode?: number; code?: string; message?: string } | null,
            data: { DomainRule?: TencentBucketDomainRule[] }
          ) => {
            if (err) reject(err);
            else resolve(data);
          }
        );
      });

      return Array.isArray(result?.DomainRule) ? result.DomainRule : [];
    } catch (error) {
      const err = error as { statusCode?: number; code?: string; message?: string };
      if (err?.statusCode === 403 || err?.code === 'AccessDenied') {
        throw new Error('无权查询腾讯云自定义域名，请检查密钥权限');
      }
      throw new Error(err?.message || '查询腾讯云自定义域名失败');
    }
  }

  async getBucketDomainList(options: TencentBucketDomainOptions): Promise<string[]> {
    const rules = await this.getBucketDomainRules(options);
    return rules
      .map((item) => item.Name?.trim().toLowerCase())
      .filter((item): item is string => Boolean(item));
  }

  async ensureBucketDomain(options: TencentBucketDomainOptions & {
    domain: string;
    type?: 'REST' | 'WEBSITE';
  }): Promise<void> {
    ensureRequired('TENCENT_OSS_DOMAIN', options.domain);

    const client = this.createClient(options.secretId, options.secretKey);
    const currentRules = await this.getBucketDomainRules(options);
    const normalizedDomain = options.domain.trim().toLowerCase();
    const hasDomain = currentRules.some((item) => item.Name?.trim().toLowerCase() === normalizedDomain);

    if (hasDomain) {
      return;
    }

    const nextRules: TencentBucketDomainRule[] = [
      ...currentRules.map((item) => ({
        Status: item.Status || 'ENABLED',
        Name: item.Name,
        Type: item.Type || 'REST',
        ...(item.ForcedReplacement ? { ForcedReplacement: item.ForcedReplacement } : {}),
      })),
      {
        Status: 'ENABLED',
        Name: options.domain,
        Type: options.type || 'REST',
      },
    ];

    try {
      await new Promise<void>((resolve, reject) => {
        client.putBucketDomain(
          {
            Bucket: options.bucket,
            Region: options.region,
            DomainRule: nextRules,
          },
          (err: { statusCode?: number; code?: string; message?: string } | null) => {
            if (err) reject(err);
            else resolve();
          }
        );
      });
    } catch (error) {
      const err = error as { statusCode?: number; code?: string; message?: string };
      if (err?.statusCode === 403 || err?.code === 'AccessDenied') {
        throw new Error('无权绑定腾讯云自定义域名，请检查密钥权限');
      }
      if (err?.statusCode === 409) {
        throw new Error('腾讯云自定义域名配置冲突，请检查域名是否已存在或需要强制覆盖');
      }
      if (err?.statusCode === 451) {
        throw new Error('当前中国境内域名未备案，腾讯云不允许绑定');
      }
      throw new Error(err?.message || '绑定腾讯云自定义域名失败');
    }
  }

  async upload(buffer: Buffer, options?: OssUploadOptions): Promise<OssUploadResult> {
    await this.ensureClient();
    const space = this.activeSpace as NonNullable<typeof this.activeSpace>;
    const key = buildObjectKey(options?.folder ?? '', options?.filename);

    await new Promise<void>((resolve, reject) => {
      this.client.putObject(
        {
          Bucket: space.name,
          Region: space.region,
          Key: key,
          Body: buffer,
          ContentType: options?.contentType,
        },
        (err: Error | null) => {
          if (err) reject(err);
          else resolve();
        }
      );
    });

    const defaultUrl = `https://${space.name}.cos.${space.region}.myqcloud.com/${key}`;
    return {
      provider: 'tencent',
      key,
      bucket: space.name,
      url: space.domain ? joinUrl(space.domain, key) : defaultUrl,
    };
  }

  async delete(key: string): Promise<void> {
    await this.ensureClient();
    const space = this.activeSpace as NonNullable<typeof this.activeSpace>;
    await new Promise<void>((resolve, reject) => {
      this.client.deleteObject(
        {
          Bucket: space.name,
          Region: space.region,
          Key: key,
        },
        (err: Error | null) => {
          if (err) reject(err);
          else resolve();
        }
      );
    });
  }
  
  getRegions(): OssRegionOption[] {
    return [
      { value: 'ap-chengdu', label: '成都' },
      { value: 'ap-shanghai', label: '上海' },
      { value: 'ap-guangzhou', label: '广州' },
      { value: 'ap-nanjing', label: '南京' },
      { value: 'ap-beijing', label: '北京' },
      { value: 'ap-chongqing', label: '重庆' },
      { value: 'ap-shenzhen-fsi', label: '深圳金融' },
      { value: 'ap-shanghai-fsi', label: '上海金融' },
      { value: 'ap-beijing-fsi', label: '北京金融' },
      { value: 'ap-hongkong', label: '中国香港' },
      { value: 'ap-singapore', label: '新加坡' },
      { value: 'ap-mumbai', label: '孟买' },
      { value: 'ap-jakarta', label: '雅加达' },
      { value: 'ap-seoul', label: '首尔' },
      { value: 'ap-bangkok', label: '曼谷' },
      { value: 'ap-tokyo', label: '东京' },
      { value: 'na-siliconvalley', label: '硅谷（美西）' },
      { value: 'na-ashburn', label: '弗吉尼亚（美东）' },
      { value: 'na-toronto', label: '多伦多' },
      { value: 'sa-saopaulo', label: '圣保罗' },
      { value: 'eu-frankfurt', label: '法兰克福' },
      { value: 'eu-moscow', label: '莫斯科' },
    ];
  }
}
