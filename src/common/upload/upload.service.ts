import { Injectable } from '@nestjs/common';
import { basename } from 'path';
import { OssService } from '@/common/oss/oss.service';
import { DbService } from '@/common/db/db.service';
import { getFileType, getImageSize } from './file.utils';
import type { OssUploadResult } from '@/common/oss/oss.interface';
import type { OssProvider } from '@/config/oss.config';
import type { UploadFileLike, UploadRequestOptions } from './upload.types';

/**
 * 上传域：封装底层存储（当前为 OssService），业务层优先依赖本类。
 */
@Injectable()
export class UploadService {
  constructor(
    private readonly ossService: OssService,
    private readonly dbService: DbService,
  ) {}

  normalizeCategoryId(category_id: any): string | null {
    return (category_id == null || category_id === '' || category_id === 'null') ? null : category_id;
  }

  async saveFileRecord(
    file: { buffer: Buffer; originalname: string; mimetype: string; size?: number },
    userId: string,
    category_id?: any,
    folder?: string,
    needSave = true,
  ) {
    const result = await this.uploadFile(file, { folder });

    if (!needSave) {
      return { message: '上传成功', ...result };
    }

    const fileType = getFileType(file.mimetype);
    const { width, height } = getImageSize(file.buffer, file.mimetype);
    const objectName = basename(result.key);

    const record = {
      user_id: userId,
      sort: 0,
      status: 0,
      type: fileType,
      url: result.url,
      display_name: objectName,
      original_name: file.originalname,
      size: file.size ?? file.buffer.length,
      file_id: result.url,
      provider: result.provider,
      width,
      height,
      category_id: this.normalizeCategoryId(category_id),
    };

    const saveResult = await this.dbService.add({
      dbName: 'qa-files',
      dataJson: record,
    });

    return {
      message: '上传成功',
      ...result,
      record_id: saveResult.insertedId,
      record,
    };
  }

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
