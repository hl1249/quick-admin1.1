import { Controller, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/utils/db.service';

@Controller()
export class SystemCategoriesController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {
    const { type, name, url } = data
    return this.dbService.add({
      dbName: "qa-files-categories",
      dataJson:{
        type,
        name,
        url,
      }
    })
  }

  @Post('/delete')
  delete(@Body() data): Promise<Document | null> {
    const { _id } = data
    return this.dbService.deleteById({
      dbName: "qa-files-categories",
      id:_id
    })
  }

  @Post('/update')
  update(@Body() data): Promise<Document | null> {
    const { _id, type, name } = data
    return this.dbService.updateById({
      id:_id,
      dbName: "qa-files-categories",
      dataJson:{
        type,
        name,
      }
    })
  }

  @Post('/getList')
  getList( @Body() data): Promise<Document | null> {
    const { type } = data
    return this.dbService.select({
      dbName: "qa-files-categories",
      whereJson:{
        type
      }
    })
  }
}