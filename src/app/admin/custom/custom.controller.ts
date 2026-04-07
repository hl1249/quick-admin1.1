import { Controller, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/db/db.service';

@Controller()
export class CustomController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {
    const { username, password, age, sex, garoupIds } = data

    return this.dbService.add({
      dbName: "custom",
      dataJson: {
        username,
        password,
        age,
        sex,
        garoupIds,
      }
    })
  }

  @Post('/delete')
  delete(@Body() whereJson): Promise<Document | null> {
    return this.dbService.del({
      dbName: "custom",
      whereJson
    })
  }

  @Post('/update')
  update(@Req() req, @Body() data): Promise<Document | null> {
    const { _id, username, password, age, sex, garoupIds } = data

    return this.dbService.updateById({
      id: _id,
      dbName: "custom",
      dataJson: {
        username,
        password,
        age,
        sex,
        garoupIds,
      }
    })
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.getTableData({
      dbName: "custom",
      data
    })
  }
}