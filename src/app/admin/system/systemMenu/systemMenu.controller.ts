import {
  Controller,
  Post,
  Body,
  Req,
  BadRequestException,
} from '@nestjs/common';
import { Document, InsertManyResult, InsertOneResult } from 'mongodb';
import { DbService } from '@/common/utils/db.service';
import { TOKEN_MAX_LIMIT, PASSWORD_SECRET } from '@/config';
import { arrayToTree } from '@/common/utils/utils'
import { Promise } from 'mongoose';

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
  add(
    @Req() req,
    @Body() data,
  ): Promise<InsertOneResult | any> {
    let {
      menu_id,
      title,
      parent_id,
      component,
      path,
      enable = true,
      comment,
    } = data;

    if (!menu_id) {
      // 抛出异常，让全局异常过滤器处理
      throw new BadRequestException('请填写菜单ID');
    }

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
  update(@Body() data): Promise<Document | null> {
    let { _id, menu_id, title, path, enable = true, comment } = data;

    return this.dbService.updateById({
      dbName: 'qa-menus',
      id: _id,
      dataJson: {
        menu_id,
        title,
        path,
        enable,
        comment,
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