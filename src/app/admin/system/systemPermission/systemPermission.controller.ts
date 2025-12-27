import { Controller, Post,Body, Req } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { TOKEN_MAX_LIMIT, PASSWORD_SECRET } from '@/config';
import { arrayToTree } from '@/common/utils/utils'

@Controller()
export class SystemPermissionController {
  constructor(
    private readonly dbService: DbService,
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
  async getList(@Req() req, @Body() data): Promise<Document | null> {
      // return this.dbService.getTableData({
      //   dbName: "qa-permissions",
      //   data,
      // })

    const res = await this.dbService.selects({
      dbName: "qa-permissions",
      pageSize:9999,
    })
      

    let treeProps = {
        id:"permission_id",
        parent_id:"parent_id", 
        children:"children"
    };
    
    return {
        ...res,
        rows:arrayToTree(res.rows as Document[],treeProps)
    }
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {

    let {
			permission_id,
			permission_name,
      url,
      match_mode,
			enable = true,
			comment,
		} = data;

    return this.dbService.add({
      dbName: "qa-permissions",
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
      dbName: "qa-permissions",
      id:_id,
      dataJson:{
        enable
      }
    })
  }

}