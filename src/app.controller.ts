import { Controller, Get } from '@nestjs/common';
import { UtilsService } from '@/common/utils/utils.service';
import { InsertOneResult, DeleteResult, UpdateResult, ObjectId, Document, InsertManyResult } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { JwtService } from '@/common/jwt/jwt.service';
import { _ } from '@/common/utils/fieldQueryTemp';

@Controller()
export class AppController {
  constructor(
    private readonly utilsService: UtilsService,
    private readonly dbService: DbService,
    private readonly jwtService: JwtService,
  ) {
  }

  @Get()
  async getHello(): Promise<DeleteResult> {
    console.time('getHello 执行时间');

    const result = await this.dbService.del({
      dbName: 'qa-users',
      whereJson: {
        // _id: _.eq("689aa18298b313b3d0d02717"),
        age: _.gt(18),
        // age:_.and(_.gte(0), _.lte(10))
      },
    });
    console.timeEnd('getHello 执行时间');
    return result;
  }

  @Get('/adds')
  test(): Promise<InsertManyResult> {
    return this.dbService.adds({
      dbName: 'qa-users',
      dataJson: [
        { name: '批量添加1', age: 20 },
        { name: '批量添加2', age: 21 },
        { name: '批量添加3', age: 22 },
        { name: '批量添加4', age: 23 },
        { name: '批量添加5', age: 24 },
      ],
    });

  }

  @Get('/findByWhereJson')
  select(): Promise<Document[]> {
    return this.dbService.findByWhereJson({
      dbName: 'qa-users',
      whereJson: {
        // _id:"689af6612b0d15a48606da2c",
        age: _.and([_.lt(30), _.gte(20)]),
      },
    });

  }

  @Get('/update')
  update(): Promise<UpdateResult> {
    return this.dbService.update({
      dbName: 'qa-users',
      whereJson: {
         _id:"689af6612b0d15a48606da2c",
      },
      dataJson:{
        name: '加速度',
        age: 32,
        fuck: _.remove(),
      }
    });

  }

  @Get('/jwt')
  async testJwt(): Promise<string> {
    const token = this.jwtService.generateToken({
      userId: '12345',
      username: 'testuser',
      role: 'admin',
    });
    return token;
  }
}
