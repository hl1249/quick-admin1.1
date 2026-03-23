import { Injectable } from '@nestjs/common';
import { AppConfigService } from '@/config/app-config.service';
import { IOssProvider, OssRegionOption, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, ensureRequired, joinUrl } from '@/common/oss/oss.utils';

type AliyunBucketListOptions = {
  accessKeyId: string;
  accessKeySecret: string;
  region?: string;
};

type AliyunCreateBucketOptions = {
  bucket: string;
  region: string;
  accessKeyId: string;
  accessKeySecret: string;
  acl?: string;
};

@Injectable()
export class AliyunOssProvider implements IOssProvider {
  private client: any = null;

  constructor(private readonly appConfig: AppConfigService) {}

  private get cfg() {
    return this.appConfig.ossConfig.aliyun;
  }

  private createClient(accessKeyId: string, accessKeySecret: string, region?: string, bucket?: string) {
    const OSS = require('ali-oss');
    return new OSS({
      accessKeyId,
      accessKeySecret,
      region: region || 'oss-cn-hangzhou',
      bucket,
      endpoint: this.cfg.endpoint || undefined,
      authorizationV4: true,
    });
  }

  private ensureClient() {
    if (this.client) return;
    ensureRequired('ALIYUN_OSS_ACCESS_KEY_ID', this.cfg.accessKeyId);
    ensureRequired('ALIYUN_OSS_ACCESS_KEY_SECRET', this.cfg.accessKeySecret);
    ensureRequired('ALIYUN_OSS_BUCKET', this.cfg.bucket);
    ensureRequired('ALIYUN_OSS_REGION', this.cfg.region);

    this.client = this.createClient(
      this.cfg.accessKeyId,
      this.cfg.accessKeySecret,
      this.cfg.region,
      this.cfg.bucket
    );
  }

  async getBucketList(options: AliyunBucketListOptions): Promise<{
    owner?: { id?: string; displayName?: string };
    buckets: Array<{
      name: string;
      region: string;
      domain: string;
      creationDate?: string;
      storageClass?: string;
    }>;
  }> {
    ensureRequired('ALIYUN_OSS_ACCESS_KEY_ID', options.accessKeyId);
    ensureRequired('ALIYUN_OSS_ACCESS_KEY_SECRET', options.accessKeySecret);

    const client = this.createClient(options.accessKeyId, options.accessKeySecret, options.region);

    try {
      const result = await client.listBuckets({ 'max-keys': 1000 });
      return {
        owner: result?.owner,
        buckets: (result?.buckets ?? []).map((item: {
          name: string;
          region: string;
          creationDate?: string;
          storageClass?: string;
        }) => ({
          name: item.name,
          region: item.region,
          domain: `https://${item.name}.${item.region}.aliyuncs.com`,
          creationDate: item.creationDate,
          storageClass: item.storageClass,
        })),
      };
    } catch (error) {
      const err = error as { message?: string; code?: string; status?: number };
      if (err?.status === 403 || err?.code === 'AccessDenied') {
        throw new Error('无权获取阿里云存储桶列表，请检查密钥权限');
      }
      throw new Error(err?.message || '获取阿里云存储桶列表失败');
    }
  }

  async createBucket(options: AliyunCreateBucketOptions): Promise<{ bucket: string }> {
    ensureRequired('ALIYUN_OSS_ACCESS_KEY_ID', options.accessKeyId);
    ensureRequired('ALIYUN_OSS_ACCESS_KEY_SECRET', options.accessKeySecret);
    ensureRequired('ALIYUN_OSS_BUCKET', options.bucket);
    ensureRequired('ALIYUN_OSS_REGION', options.region);

    const client = this.createClient(options.accessKeyId, options.accessKeySecret, options.region);

    try {
      await client.putBucket(options.bucket, options.acl ? { acl: options.acl } : undefined);
      return { bucket: options.bucket };
    } catch (error) {
      const err = error as { message?: string; code?: string; status?: number };
      if (err?.status === 409 || err?.code === 'BucketAlreadyExists') {
        throw new Error(`阿里云存储桶已存在: ${options.bucket}`);
      }
      if (err?.status === 403 || err?.code === 'AccessDenied') {
        throw new Error(`无权创建阿里云存储桶: ${options.bucket}，请检查密钥权限`);
      }
      throw new Error(err?.message || `阿里云存储桶创建失败: ${options.bucket}`);
    }
  }

  async upload(buffer: Buffer, options?: OssUploadOptions): Promise<OssUploadResult> {
    this.ensureClient();
    const key = buildObjectKey(options?.folder ?? '', options?.filename);
    await this.client.put(key, buffer, {
      headers: options?.contentType ? { 'Content-Type': options.contentType } : undefined,
    });

    const endpoint = this.cfg.endpoint || `oss-${this.cfg.region}.aliyuncs.com`;
    const pureEndpoint = endpoint.replace(/^https?:\/\//, '');
    const defaultUrl = `https://${this.cfg.bucket}.${pureEndpoint}/${key}`;
    return {
      provider: 'aliyun',
      key,
      bucket: this.cfg.bucket,
      url: this.cfg.domain ? joinUrl(this.cfg.domain, key) : defaultUrl,
    };
  }

  async delete(key: string): Promise<void> {
    this.ensureClient();
    await this.client.delete(key);
  }

  getRegions(): OssRegionOption[] {
    return [
      { value: 'oss-cn-hangzhou', label: '华东 1 杭州' },
      { value: 'oss-cn-shanghai', label: '华东 2 上海' },
      { value: 'oss-cn-nanjing', label: '华东 5 南京' },
      { value: 'oss-cn-fuzhou', label: '华南 1 福州' },
      { value: 'oss-cn-qingdao', label: '华北 1 青岛' },
      { value: 'oss-cn-beijing', label: '华北 2 北京' },
      { value: 'oss-cn-zhangjiakou', label: '华北 3 张家口' },
      { value: 'oss-cn-huhehaote', label: '华北 5 呼和浩特' },
      { value: 'oss-cn-wulanchabu', label: '华北 6 乌兰察布' },
      { value: 'oss-cn-shenzhen', label: '华南 2 深圳' },
      { value: 'oss-cn-heyuan', label: '华南 3 河源' },
      { value: 'oss-cn-guangzhou', label: '华南 3 广州' },
      { value: 'oss-cn-chengdu', label: '西南 1 成都' },
      { value: 'oss-cn-hongkong', label: '中国香港' },
      { value: 'oss-ap-southeast-1', label: '新加坡' },
      { value: 'oss-ap-southeast-2', label: '悉尼' },
      { value: 'oss-ap-southeast-3', label: '吉隆坡' },
      { value: 'oss-ap-southeast-5', label: '雅加达' },
      { value: 'oss-ap-northeast-1', label: '东京' },
      { value: 'oss-us-west-1', label: '硅谷' },
      { value: 'oss-us-east-1', label: '弗吉尼亚' },
      { value: 'oss-eu-central-1', label: '法兰克福' },
      { value: 'oss-eu-west-1', label: '伦敦' },
      { value: 'oss-me-east-1', label: '迪拜' },
    ];
  }
}
