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

  /** 上传 Multer 解析后的文件 */
  async uploadFile(
    file: UploadFileLike,
    options?: UploadRequestOptions,
  ): Promise<OssUploadResult> {
    return this.ossService.upload(file.buffer, {
      filename: file.originalname,
      contentType: file.mimetype,
      folder: options?.folder,
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
      folder: options?.folder,
      provider: options?.provider,
    });
  }

  async delete(key: string, provider?: OssProvider): Promise<void> {
    return this.ossService.delete(key, provider);
  }
}
