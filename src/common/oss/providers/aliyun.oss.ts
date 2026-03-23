import { Injectable } from '@nestjs/common';
import { IOssProvider, OssRegionOption, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, ensureRequired, joinUrl } from '@/common/oss/oss.utils';
import { DbService } from '@/common/utils/db.service';

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
  private activeSpace: {
    accessKey: string;
    secretKey: string;
    name: string;
    region: string;
    domain?: string;
    endpoint?: string;
  } | null = null;

  constructor(private readonly dbService: DbService) {}

  private createClient(
    accessKeyId: string,
    accessKeySecret: string,
    region?: string,
    bucket?: string,
    endpoint?: string
  ) {
    const OSS = require('ali-oss');
    return new OSS({
      accessKeyId,
      accessKeySecret,
      region: region || 'oss-cn-hangzhou',
      bucket,
      endpoint: endpoint || undefined,
      authorizationV4: true,
    });
  }

  private async getActiveAliyunSpace() {
    const space = await this.dbService.findByWhereJson({
      dbName: 'qa-storage-space',
      whereJson: {
        provider: 'aliyun',
        enable: true,
      }
    });

    if (!space) {
      throw new Error('未找到已启用的阿里云存储空间配置');
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
      domain: space.domain as string | undefined,
      endpoint: space.endpoint as string | undefined,
    };
  }

  private async ensureClient() {
    const space = await this.getActiveAliyunSpace();
    const shouldReuseClient =
      this.client &&
      this.activeSpace?.accessKey === space.accessKey &&
      this.activeSpace?.secretKey === space.secretKey &&
      this.activeSpace?.name === space.name &&
      this.activeSpace?.region === space.region &&
      this.activeSpace?.endpoint === space.endpoint;

    this.activeSpace = space;
    if (shouldReuseClient) return;

    this.client = this.createClient(
      space.accessKey,
      space.secretKey,
      space.region,
      space.name,
      space.endpoint
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
    await this.ensureClient();
    const space = this.activeSpace as NonNullable<typeof this.activeSpace>;
    const key = buildObjectKey(options?.folder ?? '', options?.filename);
    await this.client.put(key, buffer, {
      headers: options?.contentType ? { 'Content-Type': options.contentType } : undefined,
    });

    const endpoint = space.endpoint || `oss-${space.region}.aliyuncs.com`;
    const pureEndpoint = endpoint.replace(/^https?:\/\//, '');
    const defaultUrl = `https://${space.name}.${pureEndpoint}/${key}`;
    return {
      provider: 'aliyun',
      key,
      bucket: space.name,
      url: space.domain ? joinUrl(space.domain, key) : defaultUrl,
    };
  }

  async delete(key: string): Promise<void> {
    await this.ensureClient();
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
