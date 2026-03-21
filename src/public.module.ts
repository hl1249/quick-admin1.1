import { Module, OnModuleInit, OnModuleDestroy, Logger } from '@nestjs/common';
import { JwtModule } from '@/common/jwt/jwt.module';
import { DbModule } from '@/common/utils/db.module';
// 数据库配置
import { MongooseModule, InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';
import { AppConfigService } from '@/config';
// 日志服务
import { LogModule } from '@/common/logger/logger.module';

// 缓存
import { CacheModule } from '@/common/cache/cache.module';
import { OssModule } from '@/common/oss/oss.module';
import { UploadModule } from '@/common/upload/upload.module';
// 动态路由
@Module({
  imports: [
    JwtModule,
    DbModule,
    LogModule,
    MongooseModule.forRootAsync({
      inject: [AppConfigService],
      useFactory: (appConfig: AppConfigService) => ({
        uri: appConfig.mongoUri,
        user: appConfig.dbUser || undefined,
        pass: appConfig.dbPassword || undefined,
        authSource: appConfig.dbAuthSource || undefined,
      }),
    }), // 默认数据库实例
    CacheModule,
    OssModule,
    UploadModule,
  ],
  exports: [JwtModule, LogModule, CacheModule, OssModule, UploadModule],
})
export class Public implements OnModuleInit, OnModuleDestroy {
  logger: Logger;
  constructor(
    @InjectConnection() private readonly connection: Connection,
    private readonly appConfig: AppConfigService,
  ) {
    this.logger = new Logger('PublicModule');
    if (this.appConfig.debug) this.logger.debug('公共注入模块初始化');
  }

  onModuleInit() {
    if (this.connection.readyState === 1) {
      this.logger.debug('MongoDB 已连接 (readyState=1)');
    } else {
      this.connection.on('connected', () => {
        this.logger.debug('MongoDB 连接成功');
      });
    }

    this.connection.on('error', (err) => {
      this.logger.error('MongoDB 连接错误:', err);
    });

    this.connection.on('disconnected', () => {
      this.logger.error('MongoDB 断开连接');
    });
  }

  async onModuleDestroy() {
    await this.connection.close();
    this.logger.debug('MongoDB 连接已关闭');
  }
}
