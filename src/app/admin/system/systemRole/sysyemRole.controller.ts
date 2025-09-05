import { Controller, Get, } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { UtilsService } from '@/common/utils/utils.service';
import { TOKEN_MAX_LIMIT, PASSWORD_SECRET } from '@/config';

@Controller()
export class SystemRoleController {
  constructor(
    private readonly dbService: DbService,
    private readonly utilsService: UtilsService,
  ) {
  }

  @Get('/getList')
  getList(): Promise<Document | null> {   
    return this.dbService.getTableData({
      dbName: "qa-roles",
      data:{
        formData:{
          role_id:''
        },
        columns:[
          { title: '角色ID', key: 'role_id', width: 150, mode: "%%" },
        ]
      }
    })
  }
}