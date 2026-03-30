import { Injectable } from '@nestjs/common';
import { IOssProvider, OssRegionOption, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, ensureRequired, joinUrl } from '@/common/oss/oss.utils';
import { DbService } from '@/common/utils/db.service';

type QiniuBucketListOptions = {
  accessKey: string;
  secretKey: string;
};

type QiniuCreateBucketOptions = {
  bucket: string;
  region: string;
  accessKey: string;
  secretKey: string;
  acl?: string;
};

type QiniuBucketDomainOptions = {
  bucket: string;
  accessKey: string;
  secretKey: string;
};

const resolveQiniuZone = (qiniu: any, region: string) => {
  const zoneMap: Record<string, any> = {
    z0: qiniu.zone.Zone_z0,
    z1: qiniu.zone.Zone_z1,
    z2: qiniu.zone.Zone_z2,
    na0: qiniu.zone.Zone_na0,
    as0: qiniu.zone.Zone_as0,
  };
  return zoneMap[region] || undefined;
};

@Injectable()
export class QiniuOssProvider implements IOssProvider {
  private qiniu: any = null;
  private mac: any = null;
  private uploader: any = null;
  private bucketManager: any = null;
  private activeSpace: {
    accessKey: string;
    secretKey: string;
    name: string;
    region: string;
    domain?: string;
  } | null = null;

  constructor(private readonly dbService: DbService) {}

  private createBucketManager(accessKey: string, secretKey: string) {
    const qiniu = require('qiniu');
    const mac = new qiniu.auth.digest.Mac(accessKey, secretKey);
    const config = new qiniu.conf.Config();
    return {
      qiniu,
      mac,
      config,
      bucketManager: new qiniu.rs.BucketManager(mac, config),
    };
  }

  private async getActiveQiniuSpace() {
    const space = await this.dbService.findByWhereJson({
      dbName: 'qa-storage-space',
      whereJson: {
        provider: 'qiniu',
        enable: true,
      }
    });

    if (!space) {
      throw new Error('未找到已启用的七牛云存储空间配置');
    }

    ensureRequired('qa-storage-space.accessKey', space.accessKey || '');
    ensureRequired('qa-storage-space.secretKey', space.secretKey || '');
    ensureRequired('qa-storage-space.name', space.name || '');
    ensureRequired('qa-storage-space.region', space.region || '');
    ensureRequired('qa-storage-space.domain', space.domain || '');

    return {
      accessKey: space.accessKey as string,
      secretKey: space.secretKey as string,
      name: space.name as string,
      region: space.region as string,
      domain: space.domain as string,
    };
  }

  private async ensureClient() {
    const space = await this.getActiveQiniuSpace();
    const shouldReuseClient =
      this.qiniu &&
      this.mac &&
      this.uploader &&
      this.bucketManager &&
      this.activeSpace?.accessKey === space.accessKey &&
      this.activeSpace?.secretKey === space.secretKey &&
      this.activeSpace?.name === space.name &&
      this.activeSpace?.region === space.region &&
      this.activeSpace?.domain === space.domain;

    this.activeSpace = space;
    if (shouldReuseClient) return;

    this.qiniu = require('qiniu');
    this.mac = new this.qiniu.auth.digest.Mac(space.accessKey, space.secretKey);

    const config = new this.qiniu.conf.Config();
    config.zone = resolveQiniuZone(this.qiniu, space.region);
    this.uploader = new this.qiniu.form_up.FormUploader(config);
    this.bucketManager = new this.qiniu.rs.BucketManager(this.mac, config);
  }

  async getBucketList(options: QiniuBucketListOptions): Promise<{
    buckets: Array<{
      name: string;
      region: string;
      domain: string;
      private?: number;
      protected?: number;
    }>;
  }> {
    ensureRequired('QINIU_OSS_ACCESS_KEY', options.accessKey);
    ensureRequired('QINIU_OSS_SECRET_KEY', options.secretKey);

    const { bucketManager } = this.createBucketManager(options.accessKey, options.secretKey);
    let bucketNames: string[] = [];
    try {
      const result = await bucketManager.listBucket();
      const rawBucketNames = Array.isArray(result)
        ? result
        : Array.isArray(result?.data)
          ? result.data
          : Array.isArray(result?.resp?.data)
            ? result.resp.data
            : [];
      bucketNames = rawBucketNames
        .filter((item): item is string => typeof item === 'string' && item.trim() !== '')
        .map((item) => item.trim());
    } catch (error) {
      const err = error as { message?: string; resp?: { statusCode?: number } };
      if (err?.resp?.statusCode === 401 || err?.resp?.statusCode === 403) {
        throw new Error('无权获取七牛云存储空间列表，请检查密钥权限');
      }
      throw new Error(err?.message || '获取七牛云存储空间列表失败');
    }

    const buckets = await Promise.all(
      bucketNames.map(async (name) => {
        let region = '';
        let privateMode: number | undefined;
        let protectedMode: number | undefined;

        try {
          const infoResult = await bucketManager.getBucketInfo(name);
          const info = infoResult?.data ?? {};
          region =
            info.region ||
            info.regionId ||
            info.zone ||
            info.zone_id ||
            info.hosts?.region ||
            region;
          privateMode = typeof info.private === 'number' ? info.private : undefined;
          protectedMode = typeof info.protected === 'number' ? info.protected : undefined;
        } catch {}

        return {
          name,
          region,
          domain: '',
          private: privateMode,
          protected: protectedMode,
        };
      })
    );

    return { buckets };
  }

  async createBucket(options: QiniuCreateBucketOptions): Promise<{ bucket: string }> {
    ensureRequired('QINIU_OSS_ACCESS_KEY', options.accessKey);
    ensureRequired('QINIU_OSS_SECRET_KEY', options.secretKey);
    ensureRequired('QINIU_OSS_BUCKET', options.bucket);
    ensureRequired('QINIU_OSS_REGION', options.region);

    const { bucketManager } = this.createBucketManager(options.accessKey, options.secretKey);

    try {
      await bucketManager.createBucket(options.bucket, { regionId: options.region });

      if (options.acl) {
        const privateMode = options.acl === 'private' ? 1 : 0;
        await bucketManager.putBucketAccessMode(options.bucket, { private: privateMode });
      }

      return { bucket: options.bucket };
    } catch (error) {
      const err = error as { message?: string; resp?: { statusCode?: number; data?: { error?: string } } };
      const statusCode = err?.resp?.statusCode;
      const errorMessage = err?.resp?.data?.error || err?.message || '';

      if (statusCode === 614 || /bucket.*exists/i.test(errorMessage)) {
        throw new Error(`七牛云存储空间已存在: ${options.bucket}`);
      }
      if (statusCode === 401 || statusCode === 403) {
        throw new Error(`无权创建七牛云存储空间: ${options.bucket}，请检查密钥权限`);
      }
      throw new Error(errorMessage || `七牛云存储空间创建失败: ${options.bucket}`);
    }
  }

  async getBucketDomainList(options: QiniuBucketDomainOptions): Promise<string[]> {
    ensureRequired('QINIU_OSS_ACCESS_KEY', options.accessKey);
    ensureRequired('QINIU_OSS_SECRET_KEY', options.secretKey);
    ensureRequired('QINIU_OSS_BUCKET', options.bucket);

    const { bucketManager } = this.createBucketManager(options.accessKey, options.secretKey);

    try {
      const result = await bucketManager.listBucketDomains(options.bucket);
      const rawData = result?.data;
      const rawDomains = Array.isArray(rawData)
        ? rawData
        : Array.isArray(rawData?.domains)
          ? rawData.domains
          : Array.isArray(rawData?.data)
            ? rawData.data
            : [];

      return rawDomains
        .map((item: any) => {
          if (typeof item === 'string') {
            return item.trim().toLowerCase();
          }

          return (
            item?.domain?.trim?.().toLowerCase?.() ||
            item?.name?.trim?.().toLowerCase?.() ||
            item?.sourceDomain?.trim?.().toLowerCase?.() ||
            ''
          );
        })
        .filter((item: string): item is string => Boolean(item));
    } catch (error) {
      const err = error as { message?: string; resp?: { statusCode?: number; data?: { error?: string } } };
      const statusCode = err?.resp?.statusCode;
      const errorMessage = err?.resp?.data?.error || err?.message || '';

      if (statusCode === 401 || statusCode === 403) {
        throw new Error('无权查询七牛云自定义域名，请检查密钥权限');
      }
      throw new Error(errorMessage || '查询七牛云自定义域名失败');
    }
  }

  async ensureBucketDomain(options: QiniuBucketDomainOptions & { domain: string }): Promise<void> {
    ensureRequired('QINIU_OSS_DOMAIN', options.domain);

    const currentDomains = await this.getBucketDomainList(options);
    const normalizedDomain = options.domain.trim().toLowerCase();

    if (currentDomains.includes(normalizedDomain)) {
      return;
    }

    throw new Error(`七牛云存储空间未绑定自定义域名: ${normalizedDomain}，请先在七牛云控制台完成域名绑定后再重试`);
  }

  async upload(buffer: Buffer, options?: OssUploadOptions): Promise<OssUploadResult> {
    await this.ensureClient();
    const space = this.activeSpace as NonNullable<typeof this.activeSpace>;
    const key = buildObjectKey(options?.folder ?? '', options?.filename);
    const putPolicy = new this.qiniu.rs.PutPolicy({ scope: `${space.name}:${key}` });
    const uploadToken = putPolicy.uploadToken(this.mac);
    const putExtra = new this.qiniu.form_up.PutExtra();
    if (options?.contentType) {
      putExtra.mimeType = options.contentType;
    }

    await new Promise<void>((resolve, reject) => {
      this.uploader.put(
        uploadToken,
        key,
        buffer,
        putExtra,
        (err: Error | null, body: { key?: string }, info: { statusCode?: number }) => {
          if (err) return reject(err);
          if (!info || info.statusCode !== 200) {
            return reject(new Error(`七牛上传失败，状态码: ${info?.statusCode ?? 'unknown'}`));
          }
          if (!body?.key) {
            return reject(new Error('七牛上传失败，未返回 key'));
          }
          resolve();
        }
      );
    });

    return {
      provider: 'qiniu',
      key,
      bucket: space.name,
      url: joinUrl(space.domain || '', key),
    };
  }

  async delete(key: string): Promise<void> {
    await this.ensureClient();
    const space = this.activeSpace as NonNullable<typeof this.activeSpace>;
    await new Promise<void>((resolve, reject) => {
      this.bucketManager.delete(space.name, key, (err: Error | null) => {
        if (err) reject(err);
        else resolve();
      });
    });
  }

  getRegions(): OssRegionOption[] {
    return [
      { value: 'z0', label: '华东-浙江' },
      { value: 'z1', label: '华北-河北' },
      { value: 'z2', label: '华南-广东' },
      { value: 'na0', label: '北美-洛杉矶' },
      { value: 'as0', label: '亚太-新加坡' },
    ];
  }
}
