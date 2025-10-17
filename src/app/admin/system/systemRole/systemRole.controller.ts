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
            foreignKey:"permission_id",
            as:'permissionsList'
          }
        ]
      })
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {

    let {
			role_id,
			role_name,
			comment,
			enable = true,
		} = data;

    return this.dbService.add({
      dbName: "qa-roles",
      dataJson:{
        role_id,
        role_name,
        comment,
        enable 
      }
    })
  }

  @Post('/delete')
  delete(@Body() data): Promise<Document | null> {
    let {
      _id
		} = data

    return this.dbService.del({
      dbName: "qa-roles",
      whereJson:{
        _id
      }
    })
  }

  @Post('/update')
  update(@Body() data): Promise<Document | null> {
    let {
      _id,
			role_id,
			role_name,
			comment,
			enable = true,
		} = data

    return this.dbService.updateById({
      dbName: "qa-roles",
      id:_id,
      dataJson:{
        role_id,
        role_name,
        comment,
        enable
      }
    })
  }

  @Post('/updateBase')
  updateBase(@Body() data): Promise<Document | null> {
    let {
      _id,
			enable = true,
		} = data

    return this.dbService.updateById({
      dbName: "qa-roles",
      id:_id,
      dataJson:{
        enable
      }
    })
  }
}