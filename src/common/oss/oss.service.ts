import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
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
    try {
      const provider = await this.ossFactory.getProvider(options?.provider);
      return await provider.upload(buffer, options);
    } catch (error) {
      if (error instanceof HttpException) {
        throw error;
      }
      const msg = error instanceof Error ? error.message : String(error);
      throw new HttpException({ message: msg }, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async delete(key: string, provider?: OssProvider): Promise<void> {
    const p = await this.ossFactory.getProvider(provider);
    await p.delete(key);
  }
}
