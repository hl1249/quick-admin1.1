import { Controller, Req, Post, Body, SetMetadata } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/db/db.service';

@Controller()
export class AppidController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @SetMetadata('skipAuth', true)
  @Post('/getAppInfo')
  getAppInfo(@Req() req, @Body() data): Promise<Document | null> {
    const { appid, secret, appname } = data

    return this.dbService.findByWhereJson({
      dbName: "qa-appids",
      whereJson: {
        appid: appid
      }
    })
  }
}