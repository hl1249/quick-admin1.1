import { Injectable } from '@nestjs/common';
import type { OssProvider } from '@/config/oss.config';
import { IOssProvider } from '@/common/oss/oss.interface';
import { LocalOssProvider } from '@/common/oss/providers/local.oss';
import { TencentOssProvider } from '@/common/oss/providers/tencent.oss';
import { AliyunOssProvider } from '@/common/oss/providers/aliyun.oss';
import { QiniuOssProvider } from '@/common/oss/providers/qiniu.oss';
import { DbService } from '@/common/db/db.service';

interface AppConfigDoc {
  _id: string;
  oss_provider: OssProvider;
}

@Injectable()
export class OssFactory {
  constructor(
    private readonly localProvider: LocalOssProvider,
    private readonly tencentProvider: TencentOssProvider,
    private readonly aliyunProvider: AliyunOssProvider,
    private readonly qiniuProvider: QiniuOssProvider,
    private readonly dbService: DbService,
  ) {}

  async getProvider(provider?: OssProvider): Promise<IOssProvider> {
    const appConfig = await this.dbService.findByWhereJson({
      dbName: 'qa-app-config',
      whereJson: {
        _id: '69bcbb2e0c34b64800565ec6',
      },
    });

    const currentProvider = provider ?? (appConfig as AppConfigDoc | null)?.oss_provider ?? 'local';

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
