import { Injectable } from '@nestjs/common';
import { OssService } from '@/common/oss/oss.service';
import type { OssUploadResult } from '@/common/oss/oss.interface';
import type { OssProvider } from '@/config/oss.config';
import type { UploadFileLike, UploadRequestOptions } from './upload.types';

/**
 * 上传域：封装底层存储（当前为 OssService），业务层优先依赖本类。
 */
@Injectable()
export class UploadService {
  constructor(private readonly ossService: OssService) {}

  private getUploadFolder() {
    const now = new Date();
    const year = String(now.getFullYear());
    const month = String(now.getMonth() + 1).padStart(2, '0');

    return `/attach/${year}/${month}`;
  }

  /** 上传 Multer 解析后的文件 */
  async uploadFile(
    file: UploadFileLike,
    options?: UploadRequestOptions,
  ): Promise<OssUploadResult> {
    return this.ossService.upload(file.buffer, {
      filename: file.originalname,
      contentType: file.mimetype,
      folder: this.getUploadFolder(),
      provider: options?.provider,
    });
  }

  /** 仅 Buffer 上传 */
  async uploadBuffer(
    buffer: Buffer,
    meta: { filename: string; contentType?: string },
    options?: UploadRequestOptions,
  ): Promise<OssUploadResult> {
    return this.ossService.upload(buffer, {
      filename: meta.filename,
      contentType: meta.contentType,
      folder: this.getUploadFolder(),
      provider: options?.provider,
    });
  }

  async delete(key: string, provider?: OssProvider): Promise<void> {
    return this.ossService.delete(key, provider);
  }
}
