import {
  BadRequestException,
  Controller,
  Post,
  Body,
} from '@nestjs/common';
import { Document, InsertOneResult } from 'mongodb';
import { DbService } from '@/common/db/db.service';
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
      sortArr: [
        {
          name: 'sort',
          type: 'asc',
        },
      ],
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
  async add(@Body() data: AddMenuDto): Promise<InsertOneResult | any> {
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

    const hasParent =
    parent_id !== undefined && parent_id !== null && parent_id !== '';
    if (hasParent && menu_id === parent_id) {
      throw new BadRequestException('父级不能与本菜单的 menu_id 相同');
    }

    const hasPermission = await this.dbService.findByWhereJson({
      dbName: 'qa-menus',
      whereJson: {
        menu_id,
      },
    });
  
    if (hasPermission) {
      throw new BadRequestException('菜单已存在');
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
        icon,
        sort,
      },
    });
  }

  @Post('/delete')
  async delete(@Body() data: any): Promise<Document | null> {
    let { _id } = data;

    const currentMenu = await this.dbService.findByWhereJson({
      dbName: 'qa-menus',
      whereJson: { _id },
    });
    
    if (!currentMenu) {
      throw new BadRequestException('菜单不存在');
    }
    
    const childMenu = await this.dbService.findByWhereJson({
      dbName: 'qa-menus',
      whereJson: { parent_id: currentMenu.menu_id },
    });
    
    if (childMenu) {
      throw new BadRequestException('请先删除子菜单');
    }

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

    const hasParent =
      parent_id !== undefined && parent_id !== null && parent_id !== '';
    if (hasParent && menu_id === parent_id) {
      throw new BadRequestException('父级不能与本菜单的 menu_id 相同');
    }

    const hasMenu = await this.dbService.findByWhereJson({
      dbName: 'qa-menus',
      whereJson: {
        menu_id,
      },
    });
    if (hasMenu) {
      throw new BadRequestException('菜单已存在');
    }

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

  @Post('/getCascader')
  async getCascader(@Body() data: any): Promise<Document | null> {
		let { node = {} } = data;
    let whereJson = {
			enable: true
		};
		if (node.root) {
			whereJson["parent_id"] = null;
		} else {
			whereJson["parent_id"] = node.value;
		}
    const res = await this.dbService.selects({
      dbName: 'qa-menus',
      whereJson,
			pageIndex: 1,
			pageSize: 500,
      foreignDB: [
				{
					dbName: "qa-menus",
					localKey:"menu_id",
					foreignKey: "parent_id",
					as: "hasChildren",
					limit: 1,
				}
			]
    });
    let rows = res.rows;
		for (let i in rows) {
			let item = rows[i];
			rows[i].label = `${item.title ?? item.name ?? item.menu_id}（${item.menu_id}）`;
			const hasChildren =
				item.hasChildren &&
				typeof item.hasChildren === 'object' &&
				Object.keys(item.hasChildren).length > 0;
			rows[i].leaf = !hasChildren;
		}
		res.rows = rows;
    return res;
  }
}