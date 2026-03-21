import { promises as fs } from 'fs';
import { dirname, resolve } from 'path';
import { Injectable } from '@nestjs/common';
import { AppConfigService } from '@/config';
import { IOssProvider, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, joinUrl } from '@/common/oss/oss.utils';

@Injectable()
export class LocalOssProvider implements IOssProvider {
  private readonly rootDir: string;
  private readonly publicBaseUrl: string;

  constructor(private readonly appConfig: AppConfigService) {
    const local = this.appConfig.ossConfig.local;
    this.rootDir = resolve(process.cwd(), local.rootDir || 'uploads');
    this.publicBaseUrl = local.publicBaseUrl || '';
  }

  async upload(buffer: Buffer, options?: OssUploadOptions): Promise<OssUploadResult> {
    const key = buildObjectKey(options?.folder ?? '', options?.filename);
    const filePath = resolve(this.rootDir, key);
    await fs.mkdir(dirname(filePath), { recursive: true });
    await fs.writeFile(filePath, buffer);

    return {
      provider: 'local',
      key,
      url: this.publicBaseUrl ? joinUrl(this.publicBaseUrl, key) : filePath,
    };
  }

  async delete(key: string): Promise<void> {
    const filePath = resolve(this.rootDir, key);
    await fs.unlink(filePath).catch(() => undefined);
  }
}
