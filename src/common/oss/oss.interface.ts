import { OssProvider } from '@/config/oss.config';

export interface OssUploadOptions {
  folder?: string;
  filename?: string;
  contentType?: string;
}

export interface OssUploadResult {
  provider: OssProvider;
  key: string;
  url: string;
  bucket?: string;
}

export interface IOssProvider {
  upload(buffer: Buffer, options?: OssUploadOptions): Promise<OssUploadResult>;
  delete(key: string): Promise<void>;
}
