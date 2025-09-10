import { Controller, Get, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { TOKEN_MAX_LIMIT, PASSWORD_SECRET } from '@/config';

@Controller()
export class SystemUserController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {

    console.log("请求body",data)
    return this.dbService.getTableData({
      dbName: "qa-users",
      data
    })
  }

  @Post('/delete')
  delete(@Body() whereJson): Promise<Document | null> {
    console.log("删除参数",whereJson)
    return this.dbService.del({
      dbName: "qa-users",
      whereJson
    })
  }
}