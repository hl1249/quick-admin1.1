import { Injectable } from '@nestjs/common';
import { OSS_CONFIG, OssProvider } from '@/config/oss.config';
import { IOssProvider } from '@/common/oss/oss.interface';
import { LocalOssProvider } from '@/common/oss/providers/local.oss';
import { TencentOssProvider } from '@/common/oss/providers/tencent.oss';
import { AliyunOssProvider } from '@/common/oss/providers/aliyun.oss';
import { QiniuOssProvider } from '@/common/oss/providers/qiniu.oss';

@Injectable()
export class OssFactory {
  constructor(
    private readonly localProvider: LocalOssProvider,
    private readonly tencentProvider: TencentOssProvider,
    private readonly aliyunProvider: AliyunOssProvider,
    private readonly qiniuProvider: QiniuOssProvider
  ) {}

  getProvider(provider?: OssProvider): IOssProvider {
    const currentProvider = provider ?? OSS_CONFIG.provider;
    switch (currentProvider) {
      case 'local':
        return this.localProvider;
      case 'tencent':
        return this.tencentProvider;
      case 'aliyun':
        return this.aliyunProvider;
      case 'qiniu':
        return this.qiniuProvider;
      default:
        return this.localProvider;
    }
  }
}
