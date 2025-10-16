import { Controller, Post,Body, Req } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { TOKEN_MAX_LIMIT, PASSWORD_SECRET } from '@/config';

@Controller()
export class SystemRoleController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
      console.log("请求body", data)
      return this.dbService.getTableData({
        dbName: "qa-roles",
        data,
        foreignDB:[
          {
            dbName:"qa-menus",
            localKey:"menu",
            localKeyType: "array",
            foreignKey:"menu_id",
            as:'menuList'
          },
          
          {
            dbName:"qa-permissions",
            localKey:"permission",
            localKeyType: "array",
            foreignKey:"parent_id",
            as:'permissionsList'
          }
        ]
      })
    }
}