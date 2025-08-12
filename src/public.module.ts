import { Module, OnModuleInit, OnModuleDestroy,Logger } from '@nestjs/common';
import { JwtModule } from '@/common/jwt/jwt.module';
import { UtilsModule } from '@/common/utils/utils.module';

// 公共的守卫、响应拦截器、异常过滤器
import { AuthGuard } from '@/common/auth/auth.guard';
import { ResponseInterceptor } from '@/common/response/respones.interceptors';
import { ExceptionsFilter } from '@/common/exception/exception.filters';
// 数据库配置
import { MongooseModule, InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';
import { DB_NAME, DB_URL, DEBUG} from './config';

@Module({
  providers: [AuthGuard,ResponseInterceptor,ExceptionsFilter],
  imports: [JwtModule, UtilsModule,
    MongooseModule.forRoot(`${DB_URL}/${DB_NAME}`), // 默认数据库实例
  ],
  exports: [JwtModule],
})
export class Public implements OnModuleInit, OnModuleDestroy {
  logger: Logger;
  constructor(@InjectConnection() private readonly connection: Connection) {
    this.logger = new Logger('PublicModule');
    if(DEBUG) this.logger.debug('公共注入模块初始化');
    
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
