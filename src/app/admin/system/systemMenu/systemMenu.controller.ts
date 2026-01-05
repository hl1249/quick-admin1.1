import {
  Controller,
  Post,
  Body,
  Req,
  BadRequestException,
} from '@nestjs/common';
import { Document, InsertOneResult } from 'mongodb';
import { DbService } from '@/common/utils/db.service';
import { arrayToTree } from '@/common/utils/utils'
import { Promise } from 'mongoose';
import { AddMenuDto, UpdateMenuDto } from './dto/systemMenu.dto';

@Controller()
export class SystemMenuController {
  constructor(private readonly dbService: DbService) {}

  @Post('/getList')
  async getList(@Req() req, @Body() data): Promise<Document | null> {
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
  add(@Req() req, @Body() data: AddMenuDto): Promise<InsertOneResult | any> {
    let {
      menu_id,
      title,
      parent_id,
      component,
      path,
      enable = true,
      comment,
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
      },
    });
  }

  @Post('/delete')
  delete(@Body() data): Promise<Document | null> {
    let { _id } = data;

    return this.dbService.del({
      dbName: 'qa-menus',
      whereJson: {
        _id,
      },
    });
  }

  @Post('/update')
  update(@Body() data: UpdateMenuDto): Promise<Document | null> {
    let { _id, menu_id, title, path, enable = true, comment, parent_id } = data;

    return this.dbService.updateById({
      dbName: 'qa-menus',
      id: _id,
      dataJson: {
        menu_id,
        title,
        path,
        enable,
        comment,
        parent_id,
      },
    });
  }

  @Post('/updateBase')
  updateBase(@Body() data): Promise<Document | null> {
    let { _id, enable = true } = data;

    return this.dbService.updateById({
      dbName: 'qa-menus',
      id: _id,
      dataJson: {
        enable,
      },
    });
  }
}