import { Controller, Post,Body } from '@nestjs/common';
import { Document, UpdateResult } from 'mongodb';
import { DbService } from '@/common/utils/db.service';
import { authService } from '@/app/admin/auth/auth.service';

@Controller()
export class SystemRoleController {
  constructor(
    private readonly dbService: DbService,
    private readonly authService: authService,
  ) {
  }

  @Post('/getAllMenu')
  getAllMenu(): Promise<Document | null>{
     return this.dbService.select({
      dbName:"qa-menus",
      getMain: true
     })
  }


  @Post('/getAllPermissions')
  getAllPermissions(): Promise<Document | null>{
     return this.dbService.select({
      dbName:"qa-permissions",
      getMain: true,
      pageSize:999
     })
  }

  @Post('/getList')
  getList(@Body() data: any): Promise<Document | null> {
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
  add( @Body() data: any): Promise<Document | null> {

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
  async delete(@Body() data: any): Promise<Document | null> {
    let { _id } = data;

    const result = await this.dbService.del({
      dbName: 'qa-roles',
      whereJson: {
        _id,
      },
    });

    // 删除权限后，递增版本号使所有用户权限缓存失效
    await this.authService.updateAuthVersion();

    return result;
  }

  @Post('/update')
  async update(@Body() data: any): Promise<Document | null> {
    let { _id, role_id, role_name, comment, enable = true } = data;

    const result: UpdateResult = await this.dbService.updateById({
      dbName: 'qa-roles',
      id: _id,
      dataJson: {
        role_id,
        role_name,
        comment,
        enable,
      },
    });

    // 删除权限后，递增版本号使所有用户权限缓存失效
    await this.authService.updateAuthVersion();
    return result;
  }

  @Post('/updateBase')
  async updateBase(@Body() data: any): Promise<Document | null> {
    let {
      _id,
			enable = true,
		} = data

    const result = await this.dbService.updateById({
      dbName: "qa-roles",
      id:_id,
      dataJson:{
        enable
      }
    })

    await this.authService.updateAuthVersion();
    return result;

  }

  @Post('/bindMenu')
  async bindMenu(@Body() data: any): Promise<Document | null> {
    let {
      _id,
			menu
		} = data

    const result = await this.dbService.updateById({
      dbName: 'qa-roles',
      id: _id,
      dataJson: {
        menu,
      },
    });

    await this.authService.updateAuthVersion();
    return result;
  }

  @Post('/bindPermissions')
  async bindPermissions(@Body() data: any): Promise<Document | null> {
    let {
      _id,
			permission
		} = data

    const result = await this.dbService.updateById({
      dbName: "qa-roles",
      id:_id,
      dataJson:{
        permission
      }
    })

    await this.authService.updateAuthVersion();
    return result;
  }
}