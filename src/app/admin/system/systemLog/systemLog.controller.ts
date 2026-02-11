import { Controller, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';

@Controller()
export class SystemLogController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.add({
      dbName: "qa-logs",
      dataJson:data
    })
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.getTableData({
      dbName: "qa-logs",
      data
    })
  }

  @Post('/delete')
  delete(@Body() whereJson): Promise<Document | null> {
    return this.dbService.del({
      dbName: "qa-logs",
      whereJson
    })
  }
}