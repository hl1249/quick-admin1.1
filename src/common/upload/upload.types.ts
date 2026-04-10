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
  /** 由 UploadService 根据请求与配置生成，供本地 OSS 拼接入库 URL */
  localPublicBaseUrl?: string;
}
