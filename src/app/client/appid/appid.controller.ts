import { Body, Controller, Post, SetMetadata } from '@nestjs/common';
import { Document } from 'mongodb';
import { DbService } from '@/common/db/db.service';

interface GetAppInfoDto {
  appid?: string;
}

@Controller()
export class AppidController {
  constructor(private readonly dbService: DbService) {}

  @SetMetadata('skipAuth', true)
  @Post('/getAppInfo')
  getAppInfo(@Body() data: GetAppInfoDto): Promise<Document | null> {
    const { appid } = data;

    return this.dbService.findByWhereJson({
      dbName: 'qa-appids',
      whereJson: {
        appid,
      },
    });
  }
}
