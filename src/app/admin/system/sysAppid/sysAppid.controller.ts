import { Controller, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/db/db.service';

@Controller()
export class SysAppidController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {
    const { appid, secret, appname, pay_config } = data;

    return this.dbService.add({
      dbName: 'qa-appids',
      dataJson: {
        appid,
        secret,
        appname,
        pay_config,
      },
    });
  }

  @Post('/delete')
  delete(@Body() whereJson): Promise<Document | null> {
    return this.dbService.del({
      dbName: "qa-appids",
      whereJson
    })
  }

  @Post('/update')
  update(@Req() req, @Body() data): Promise<Document | null> {
    const { _id, appid, secret, appname, pay_config } = data;

    return this.dbService.updateById({
      id: _id,
      dbName: 'qa-appids',
      dataJson: {
        appid,
        secret,
        appname,
        pay_config,
      },
    });
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.getTableData({
      dbName: "qa-appids",
      data
    })
  }
}