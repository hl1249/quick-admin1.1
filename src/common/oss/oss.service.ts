import { Injectable } from '@nestjs/common';
import { OssProvider } from '@/config/oss.config';
import { OssFactory } from '@/common/oss/oss.factory';
import { OssUploadOptions, OssUploadResult } from '@/common/oss/oss.interface';

@Injectable()
export class OssService {
  constructor(private readonly ossFactory: OssFactory) {}

  async upload(
    buffer: Buffer,
    options?: OssUploadOptions & { provider?: OssProvider }
  ): Promise<OssUploadResult> {
    const provider = this.ossFactory.getProvider(options?.provider);
    return provider.upload(buffer, options);
  }

  async delete(key: string, provider?: OssProvider): Promise<void> {
    const p = this.ossFactory.getProvider(provider);
    await p.delete(key);
  }
}
