import type { OssProvider } from '@/config/oss.config';

/** Multer / 内存文件结构 */
export interface UploadFileLike {
  buffer: Buffer;
  originalname: string;
  mimetype: string;
}

export interface UploadRequestOptions {
  folder?: string;
  /** 不传则使用 qa-app-config.oss_provider */
  provider?: OssProvider;
}
