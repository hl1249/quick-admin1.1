import { Injectable } from '@nestjs/common';
import { AppConfigService } from '@/config/app-config.service';
import type { OssProvider } from '@/config/oss.config';
import { IOssProvider } from '@/common/oss/oss.interface';
import { LocalOssProvider } from '@/common/oss/providers/local.oss';
import { TencentOssProvider } from '@/common/oss/providers/tencent.oss';
import { AliyunOssProvider } from '@/common/oss/providers/aliyun.oss';
import { QiniuOssProvider } from '@/common/oss/providers/qiniu.oss';
import { DbService } from '@/common/utils/db.service';

interface StorageSpace {
  _id: string;
  name: string;
  region: string;
  status: number;
  domain: string;
  provider: OssProvider;
  _add_time?: number;
  _add_time_str?: string;
  _update_time?: number;
  _update_time_str?: string;
}

interface AppConfigDoc {
  _id: string;
  oss_provider: OssProvider;
  space?: StorageSpace | null;
}

@Injectable()
export class OssFactory {
  constructor(
    private readonly localProvider: LocalOssProvider,
    private readonly tencentProvider: TencentOssProvider,
    private readonly aliyunProvider: AliyunOssProvider,
    private readonly qiniuProvider: QiniuOssProvider,
    private readonly appConfig: AppConfigService,
    private readonly dbService: DbService,
  ) {}

  async getProvider(provider?: OssProvider): Promise<IOssProvider> {
    const appConfigRows = await this.dbService.selects({
      dbName: 'qa-app-config',
      whereJson: {
        _id: '69bcbb2e0c34b64800565ec6',
      },
      getMain: true,
      pageSize: 1,
      foreignDB: [
        {
          limit: 1,
          dbName: 'qa-storage-space',
          localKey: 'oss_provider',
          foreignKey: 'provider',
          as: 'space',
          whereJson: {
            status: 1,
          },
        },
      ],
    });
    const appConfig = (appConfigRows?.[0] ?? null) as AppConfigDoc | null;
    
    if (!appConfig?.space) {
      throw new Error('请检查存储配置');
    }

    const currentProvider = provider ?? appConfig.oss_provider ?? this.appConfig.ossConfig.provider;

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
