import { Global, Module } from '@nestjs/common';
import { OssFactory } from '@/common/oss/oss.factory';
import { OssService } from '@/common/oss/oss.service';
import { LocalOssProvider } from '@/common/oss/providers/local.oss';
import { TencentOssProvider } from '@/common/oss/providers/tencent.oss';
import { AliyunOssProvider } from '@/common/oss/providers/aliyun.oss';
import { QiniuOssProvider } from '@/common/oss/providers/qiniu.oss';

@Global()
@Module({
  providers: [
    LocalOssProvider,
    TencentOssProvider,
    AliyunOssProvider,
    QiniuOssProvider,
    OssFactory,
    OssService,
  ],
  exports: [OssService, LocalOssProvider, TencentOssProvider, AliyunOssProvider, QiniuOssProvider],
})
export class OssModule {}
