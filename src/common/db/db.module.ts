// DbModule.module.ts
import { Module, Global } from '@nestjs/common';
import { DbService } from './db.service';

@Global() // 变成全局模块后，不用每个模块都导入
@Module({
  providers: [DbService],
  exports: [DbService],
})
export class DbModule {}
