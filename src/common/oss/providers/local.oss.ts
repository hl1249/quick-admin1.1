import { promises as fs } from 'fs';
import { dirname, resolve } from 'path';
import { Injectable } from '@nestjs/common';
import { OSS_CONFIG } from '@/config/oss.config';
import { IOssProvider, OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';
import { buildObjectKey, joinUrl } from '@/common/oss/oss.utils';

@Injectable()
export class LocalOssProvider implements IOssProvider {
  private readonly rootDir = resolve(process.cwd(), OSS_CONFIG.local.rootDir || 'uploads');
  private readonly publicBaseUrl = OSS_CONFIG.local.publicBaseUrl || '';

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
