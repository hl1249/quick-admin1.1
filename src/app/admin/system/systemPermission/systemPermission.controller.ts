import { Controller, Post,Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { arrayToTree } from '@/common/utils/utils'
import { AuthService } from '@/app/admin/auth/auth.service';

@Controller()
export class SystemPermissionController {
  constructor(
    private readonly dbService: DbService,
    private readonly authService: AuthService,
  ) {}

  @Post('/getAllMenu')
  getAllMenu(): Promise<Document | null> {
    return this.dbService.select({
      dbName: 'qa-menus',
      getMain: true,
    });
  }

  @Post('/getAllPermissions')
  getAllPermissions(): Promise<Document | null> {
    return this.dbService.select({
      dbName: 'qa-permissions',
      getMain: true,
      pageSize: 999,
    });
  }

  @Post('/getList')
  async getList(): Promise<Document | null> {
    // return this.dbService.getTableData({
    //   dbName: "qa-permissions",
    //   data,
    // })

    const res = await this.dbService.selects({
      dbName: 'qa-permissions',
      pageSize: 9999,
    });

    let treeProps = {
      id: 'permission_id',
      parent_id: 'parent_id',
      children: 'children',
    };

    return {
      ...res,
      rows: arrayToTree(res.rows as Document[], treeProps),
      list: res.rows as Document[],
    };
  }

  @Post('/add')
  add(@Body() data: any): Promise<Document | null> {
    let {
      permission_id,
      permission_name,
      parent_id,
      url,
      match_mode,
      enable = true,
      comment,
    } = data;

    return this.dbService.add({
      dbName: 'qa-permissions',
      dataJson: {
        permission_id,
        permission_name,
        parent_id,
        url,
        match_mode,
        enable,
        comment,
      },
    });
  }

  @Post('/delete')
  async delete(@Body() data: any): Promise<Document | null> {
    let { _id } = data;

    const result = await this.dbService.del({
      dbName: 'qa-permissions',
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
    let {
      _id,
      permission_id,
      permission_name,
      url,
      match_mode,
      enable = true,
      comment,
    } = data;

    const result = await this.dbService.updateById({
      dbName: 'qa-permissions',
      id: _id,
      dataJson: {
        permission_id,
        permission_name,
        url,
        match_mode,
        enable,
        comment,
      },
    });

    // 更新权限后，递增版本号使所有用户权限缓存失效
    await this.authService.updateAuthVersion();

    return result;
  }

  @Post('/updateBase')
  async updateBase(@Body() data: any): Promise<Document | null> {
    let { _id, enable = true } = data;

    const result = await this.dbService.updateById({
      dbName: 'qa-permissions',
      id: _id,
      dataJson: {
        enable,
      },
    });

    // 更新权限启用状态后，递增版本号使所有用户权限缓存失效
    await this.authService.updateAuthVersion();

    return result;
  }
}