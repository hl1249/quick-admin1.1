import { OssProvider } from '@/config/oss.config';

export interface OssUploadOptions {
  folder?: string;
  filename?: string;
  contentType?: string;
  /** 本地存储：入库用的完整基准（协议+host+目录），如 https://api.example.com/uploads */
  localPublicBaseUrl?: string;
}

export interface OssUploadResult {
  provider: OssProvider;
  key: string;
  url: string;
  bucket?: string;
}

export interface OssRegionOption {
  value: string;
  label: string;
}

export interface IOssProvider {
  upload(buffer: Buffer, options?: OssUploadOptions): Promise<OssUploadResult>;
  delete(key: string): Promise<void>;
  getRegions?(): OssRegionOption[];
}
