import { Injectable } from '@nestjs/common';
import { AppConfigService } from '@/config';
import { IOssProvider, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, ensureRequired, joinUrl } from '@/common/oss/oss.utils';

@Injectable()
export class TencentOssProvider implements IOssProvider {
  private client: any = null;

  constructor(private readonly appConfig: AppConfigService) {}

  private get cfg() {
    return this.appConfig.ossConfig.tencent;
  }

  private ensureClient() {
    if (this.client) return;
    ensureRequired('SecretId', this.cfg.SecretId);
    ensureRequired('SecretKey', this.cfg.SecretKey);
    ensureRequired('TENCENT_OSS_BUCKET', this.cfg.Bucket);
    ensureRequired('TENCENT_OSS_REGION', this.cfg.Region);

    // 运行时按需加载，避免未安装依赖时报编译错误
    const COS = require('cos-nodejs-sdk-v5');
    this.client = new COS({
      SecretId: this.cfg.SecretId,
      SecretKey: this.cfg.SecretKey,
    });
  }

  async upload(buffer: Buffer, options?: OssUploadOptions): Promise<OssUploadResult> {
    this.ensureClient();
    const key = buildObjectKey(options?.folder ?? '', options?.filename);

    await new Promise<void>((resolve, reject) => {
      this.client.putObject(
        {
          Bucket: this.cfg.Bucket,
          Region: this.cfg.Region,
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

    const defaultUrl = `https://${this.cfg.Bucket}.cos.${this.cfg.Region}.myqcloud.com/${key}`;
    return {
      provider: 'tencent',
      key,
      bucket: this.cfg.Bucket,
      url: this.cfg.Domain ? joinUrl(this.cfg.Domain, key) : defaultUrl,
    };
  }

  async delete(key: string): Promise<void> {
    this.ensureClient();
    await new Promise<void>((resolve, reject) => {
      this.client.deleteObject(
        {
          Bucket: this.cfg.Bucket,
          Region: this.cfg.Region,
          Key: key,
        },
        (err: Error | null) => {
          if (err) reject(err);
          else resolve();
        }
      );
    });
  }
}
