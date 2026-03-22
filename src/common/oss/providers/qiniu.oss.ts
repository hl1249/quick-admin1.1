import { Injectable } from '@nestjs/common';
import { AppConfigService } from '@/config/app-config.service';
import { IOssProvider, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, ensureRequired, joinUrl } from '@/common/oss/oss.utils';

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
}
