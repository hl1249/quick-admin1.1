import {
  Controller,
  Post,
  Body,
} from '@nestjs/common';
import { Document, InsertOneResult } from 'mongodb';
import { DbService } from '@/common/utils/db.service';
import { arrayToTree } from '@/common/utils/utils'
import { Promise } from 'mongoose';
import { AddMenuDto, UpdateMenuDto } from './dto/systemMenu.dto';
import { AuthService } from '@/app/admin/auth/auth.service';

@Controller()
export class SystemMenuController {
  constructor(
    private readonly dbService: DbService,
    private readonly authService: AuthService,
  ) {}

  @Post('/getList')
  async getList(): Promise<Document | null> {
    const res = await this.dbService.selects({
      dbName: 'qa-menus',
      pageSize: 9999,
    });

    let treeProps = {
      id: 'menu_id',
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
  add(@Body() data: AddMenuDto): Promise<InsertOneResult | any> {
    let {
      menu_id,
      title,
      parent_id,
      component,
      path,
      enable = true,
      comment,
      icon,
      sort,
    } = data;

    return this.dbService.add({
      dbName: 'qa-menus',
      dataJson: {
        menu_id,
        title,
        parent_id,
        component,
        path,
        enable,
        comment,
        icon,
        sort,
      },
    });
  }

  @Post('/delete')
  async delete(@Body() data: any): Promise<Document | null> {
    let { _id } = data;

    const result = await this.dbService.del({
      dbName: 'qa-menus',
      whereJson: {
        _id,
      },
    });

    await this.authService.updateAuthVersion();
    return result;
  }

  @Post('/update')
  async update(@Body() data: UpdateMenuDto): Promise<Document | null> {
    let { _id, menu_id, title, enable = true, comment, parent_id, component, sort, icon } = data;

    const result = await this.dbService.updateById({
      dbName: 'qa-menus',
      id: _id,
      dataJson: {
        menu_id,
        title,
        component,
        sort,
        icon,
        enable,
        comment,
        parent_id,
      },
    });

    await this.authService.updateAuthVersion();
    return result;
  }

  @Post('/updateBase')
  async updateBase(@Body() data: any): Promise<Document | null> {
    let { _id, enable = true } = data;

    const result = await this.dbService.updateById({
      dbName: 'qa-menus',
      id: _id,
      dataJson: {
        enable,
      },
    });

    await this.authService.updateAuthVersion();
    return result;
  }
}