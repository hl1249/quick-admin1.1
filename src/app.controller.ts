import { Controller, Get } from '@nestjs/common';
import { UtilsService } from '@/common/utils/utils.service';
import { InsertOneResult, DeleteResult, UpdateResult, ObjectId, Document, InsertManyResult } from 'mongodb'
import { DbService } from '@/common/utils/db.service';

@Controller()
export class AppController {
  constructor(
    private readonly utilsService: UtilsService,
    private readonly dbService: DbService,
  ) { }

  @Get()
  async getHello(): Promise<InsertOneResult> {
    console.time('getHello 执行时间');
     throw new Error('故意制造运行时错误');
    const result = await this.dbService.add({
      dbName: 'qa-users',
      dataJson: {
        name: '测试用户',
        age: 30,
        createdAt: new Date(),
      },
    });
    console.timeEnd('getHello 执行时间');
    return result;
  }

  @Get('/test')
  test(): any {
    return this.utilsService.someUtil();
  }
}
