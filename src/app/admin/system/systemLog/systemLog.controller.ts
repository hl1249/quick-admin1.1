import { Controller, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/db/db.service';

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

  @Post('/delete')
  delete(@Body() data): Promise<Document | null> {
    return this.dbService.deleteById({
      dbName: "qa-logs",
      id: data._id
    })
  }

  @Post('/update')
  update(@Body() data): Promise<Document | null> {
    const { _id, statusCode } = data
    return this.dbService.updateById({
      id: _id,
      dbName: "qa-logs",
      dataJson: { 
        statusCode
      }
    })
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.getTableData({
      dbName: "qa-logs",
      data
    })
  }
}