import { Controller, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/db/db.service';

@Controller()
export class SystemPayConfigController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {
    const { type, mchId, key, pfx, version } = data

    return this.dbService.add({
      dbName: "qa-pay-config",
      dataJson: {
        type,
        mchId,
        key,
        pfx,
        version,
      }
    })
  }

  @Post('/delete')
  delete(@Body() whereJson): Promise<Document | null> {
    return this.dbService.del({
      dbName: "qa-pay-config",
      whereJson
    })
  }

  @Post('/update')
  update(@Req() req, @Body() data): Promise<Document | null> {
    const { _id, type, mchId, key, pfx, version } = data

    return this.dbService.updateById({
      id: _id,
      dbName: "qa-pay-config",
      dataJson: {
        type,
        mchId,
        key,
        pfx,
        version,
      }
    })
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.getTableData({
      dbName: "qa-pay-config",
      data
    })
  }
}