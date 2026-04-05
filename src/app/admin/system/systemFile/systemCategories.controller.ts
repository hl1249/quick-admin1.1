import { Controller, Req, Post, Body, BadRequestException } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/db/db.service';

@Controller()
export class SystemCategoriesController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/add')
  async add(@Req() req, @Body() data): Promise<Document | null> {
    const { type, name, url } = data

    const categories = await this.dbService.findByWhereJson({
      dbName: "qa-files-categories",
      whereJson:{
        type,
        name,
      }
    })

    if(categories){
      throw new BadRequestException('分类已存在')
    }

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