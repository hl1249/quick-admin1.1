import { Injectable } from '@nestjs/common';
import { AppConfigService } from '@/config/app-config.service';
import { IOssProvider, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, ensureRequired, joinUrl } from '@/common/oss/oss.utils';

@Injectable()
export class AliyunOssProvider implements IOssProvider {
  private client: any = null;

  constructor(private readonly appConfig: AppConfigService) {}

  private get cfg() {
    return this.appConfig.ossConfig.aliyun;
  }

  private ensureClient() {
    if (this.client) return;
    ensureRequired('ALIYUN_OSS_ACCESS_KEY_ID', this.cfg.accessKeyId);
    ensureRequired('ALIYUN_OSS_ACCESS_KEY_SECRET', this.cfg.accessKeySecret);
    ensureRequired('ALIYUN_OSS_BUCKET', this.cfg.bucket);
    ensureRequired('ALIYUN_OSS_REGION', this.cfg.region);

    const OSS = require('ali-oss');
    this.client = new OSS({
      accessKeyId: this.cfg.accessKeyId,
      accessKeySecret: this.cfg.accessKeySecret,
      bucket: this.cfg.bucket,
      region: this.cfg.region,
      endpoint: this.cfg.endpoint || undefined,
    });
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
}
