import { Controller, Get, Req, Post, Body } from '@nestjs/common';
import { Document, UpdateResult } from 'mongodb'
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

    return this.dbService.getTableData({
      dbName: "qa-users",
      data
    })
  }

  @Post('/update')
  async update(@Body() data): Promise<Document | null> {
    let { _id, nickname, avatar, rate, enable = true } = data;

    const result: UpdateResult = await this.dbService.updateById({
      dbName: 'qa-users',
      id: _id,
      dataJson: {
        nickname, avatar, rate,
        enable,
      },
    });

    return result;
  }
  @Post('/add')
  add(@Body() data): Promise<Document | null> {
    return this.dbService.add({
      dbName: "qa-users",
      dataJson: data
    })
  }

  @Post('/delete')
  delete(@Body() whereJson): Promise<Document | null> {
    return this.dbService.del({
      dbName: "qa-users",
      whereJson
    })
  }
}