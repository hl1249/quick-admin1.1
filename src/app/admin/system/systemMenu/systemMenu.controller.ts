import { Controller, Post,Body, Req } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { TOKEN_MAX_LIMIT, PASSWORD_SECRET } from '@/config';
import { arrayToTree } from '@/common/utils/utils'

@Controller()
export class SystemMenuController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/getList')
  async getList(@Req() req, @Body() data): Promise<Document | null> {

    const res = await this.dbService.selects({
      dbName: "qa-menus",
      pageSize:9999,
    })
      

    let treeProps = {
        id:"menu_id",
        parent_id:"parent_id", 
        children:"children"
    };
    
    return {
        ...res,
        rows:arrayToTree(res.rows as Document[],treeProps),
        list:res.rows as Document[],
    }
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {

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
      dbName: "menu_id",
      dataJson:{
        menu_id,
        title,
        parent_id,
        component,
        path,
        enable,
        comment,
      }
    })
  }

  @Post('/delete')
  delete(@Body() data): Promise<Document | null> {
    let {
      _id
		} = data

    return this.dbService.del({
      dbName: "qa-permissions",
      whereJson:{
        _id
      }
    })
  }

  @Post('/update')
  update(@Body() data): Promise<Document | null> {
    console.log("我执行力")
    let {
      _id,
			permission_id,
			permission_name,
      url,
      match_mode,
			enable = true,
			comment,
		} = data;

    return this.dbService.updateById({
      dbName: "qa-permissions",
      id:_id,
      dataJson:{
        permission_id,
        permission_name,
        url,
        match_mode,
        enable,
        comment,
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
      dbName: "qa-menus",
      id:_id,
      dataJson:{
        enable
      }
    })
  }

}