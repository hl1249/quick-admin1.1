import { Controller, Get, } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { TOKEN_MAX_LIMIT, PASSWORD_SECRET } from '@/config';

@Controller()
export class SystemUserController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Get('/getList')
  getList(): Promise<Document | null> {   
    return this.dbService.getTableData({
      dbName: "qa-users",
    })
  }
}