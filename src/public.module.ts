import { Module, OnModuleInit, OnModuleDestroy, Logger  } from '@nestjs/common';
import { JwtModule } from '@/common/jwt/jwt.module';
import { DbModule } from '@/common/utils/db.module';
// 数据库配置
import { MongooseModule, InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';
import { DB_NAME, DB_USER, DB_PASSWOR, DB_PORT, DB_URL, DEBUG} from './config';
// 日志服务
import {LogModule } from '@/common/logger/logger.module';

// 缓存
import { CacheModule } from '@/common/cach/cache.module'
// 动态路由
@Module({
  imports: [
    JwtModule,
    DbModule,
    LogModule,
    MongooseModule.forRoot(`${DB_URL}:${DB_PORT}/${DB_NAME}`, {
      user: DB_USER,
      pass: DB_PASSWOR,
      authSource: 'admin',
    }), // 默认数据库实例
    CacheModule,
  ],
  exports: [JwtModule, LogModule, CacheModule],
})
export class Public implements OnModuleInit, OnModuleDestroy {
  logger: Logger;
  constructor(@InjectConnection() private readonly connection: Connection) {
    this.logger = new Logger('PublicModule');
    if (DEBUG) this.logger.debug('公共注入模块初始化');
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
