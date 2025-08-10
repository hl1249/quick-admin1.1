// utils.module.ts
import { Module, Global } from '@nestjs/common';
import { UtilsService } from './utils.service';
import { DbService } from './db.service';

@Global() // 变成全局模块后，不用每个模块都导入
@Module({
  providers: [UtilsService,DbService],
  exports: [UtilsService,DbService],
})
export class UtilsModule {}
