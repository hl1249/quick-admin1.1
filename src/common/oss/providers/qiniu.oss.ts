import { Injectable } from '@nestjs/common';
import { AppConfigService } from '@/config/app-config.service';
import { IOssProvider, OssRegionOption, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, ensureRequired, joinUrl } from '@/common/oss/oss.utils';

type QiniuBucketListOptions = {
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

  constructor(private readonly appConfig: AppConfigService) {}

  private get cfg() {
    return this.appConfig.ossConfig.qiniu;
  }
  private mac: any = null;
  private uploader: any = null;
  private bucketManager: any = null;

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

  private ensureClient() {
    if (this.qiniu && this.mac && this.uploader && this.bucketManager) return;
    ensureRequired('QINIU_OSS_ACCESS_KEY', this.cfg.accessKey);
    ensureRequired('QINIU_OSS_SECRET_KEY', this.cfg.secretKey);
    ensureRequired('QINIU_OSS_BUCKET', this.cfg.bucket);
    ensureRequired('QINIU_OSS_DOMAIN', this.cfg.domain);

    this.qiniu = require('qiniu');
    this.mac = new this.qiniu.auth.digest.Mac(this.cfg.accessKey, this.cfg.secretKey);

    const config = new this.qiniu.conf.Config();
    config.zone = resolveQiniuZone(this.qiniu, this.cfg.region);
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
      bucketNames = Array.isArray(result?.data) ? result.data : [];
    } catch (error) {
      const err = error as { message?: string; resp?: { statusCode?: number } };
      if (err?.resp?.statusCode === 401 || err?.resp?.statusCode === 403) {
        throw new Error('无权获取七牛云存储空间列表，请检查密钥权限');
      }
      throw new Error(err?.message || '获取七牛云存储空间列表失败');
    }

    const buckets = await Promise.all(
      bucketNames.map(async (name) => {
        let region = this.cfg.region;
        let domain = `https://${name}.${region}.qiniucdn.com`;
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

        try {
          const domainResult = await bucketManager.listBucketDomains(name);
          const domains = Array.isArray(domainResult?.data)
            ? domainResult.data
            : Array.isArray(domainResult?.data?.domains)
              ? domainResult.data.domains
              : [];
          const firstDomain = domains[0];
          if (firstDomain) {
            domain = String(firstDomain).startsWith('http') ? String(firstDomain) : `https://${firstDomain}`;
          }
        } catch {}

        return {
          name,
          region,
          domain,
          private: privateMode,
          protected: protectedMode,
        };
      })
    );

    return { buckets };
  }

  async upload(buffer: Buffer, options?: OssUploadOptions): Promise<OssUploadResult> {
    this.ensureClient();
    const key = buildObjectKey(options?.folder ?? '', options?.filename);
    const putPolicy = new this.qiniu.rs.PutPolicy({ scope: `${this.cfg.bucket}:${key}` });
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
      bucket: this.cfg.bucket,
      url: joinUrl(this.cfg.domain, key),
    };
  }

  async delete(key: string): Promise<void> {
    this.ensureClient();
    await new Promise<void>((resolve, reject) => {
      this.bucketManager.delete(this.cfg.bucket, key, (err: Error | null) => {
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
