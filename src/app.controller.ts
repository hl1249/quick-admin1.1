import { Controller, Get } from '@nestjs/common';
import { UtilsService } from '@/common/utils/utils.service';
import { InsertOneResult, DeleteResult, UpdateResult, ObjectId, Document, InsertManyResult } from 'mongodb'
import { SelectResult } from '@/common/utils/db.types';
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
        { name: '批量添加1', age: 20, arr: [1, 2, 3], fuck: 25 },
        { name: '批量添加2', age: 25, arr: [4, 5, 6] },
        { name: '批量添加3', age: 30, arr: [7, 8, 9] },
        { name: '批量添加4', age: 35, arr: [10, 11, 12] },
        { name: '批量添加5', age: 40, arr: [13, 14, 15] },
      ],
    });

  }

  @Get('/del')
  del(): Promise<DeleteResult> {
    return this.dbService.del({
      dbName: 'qa-users',
      whereJson: {
        age: _.exists(true)
      }
    });

  }

  @Get('/findById')
  findById(): Promise<Document | null> {
    return this.dbService.findById({
      dbName: 'qa-users',
      id: '689beb65a0556c8100617520',
      fieldJson: {
        // age:true,
        // _id:false
      },
    });

  }

  @Get('/findByWhereJson')
  findByWhereJson(): Promise<Document | null> {
    return this.dbService.findByWhereJson({
      dbName: 'qa-users',
      whereJson: {
        // _id:"689af6612b0d15a48606da2c",
        // age: _.and([_.lt(30), _.gte(20)]),
        // "arr.0": 1,
        // "arr.1": 2,
        // "arr.2": 3,
        // age:_.expr({
        //   $eq: [
        //     '$age',
        //     '$fuck'
        //   ]
        // })
      },
      fieldJson: {
        // age:true,
        // _id:false
      },
      // sortArr: [
      //   { "name":"age", "type":"asc" },
      //   // { "name":"age", "type":"desc" }
      // ]
    });

  }

  @Get('/selects')
  selects(): Promise<Document[]> {
    return this.dbService.selects({
      dbName: 'qa-users',
      getCount: true, // 是否需要同时查询满足条件的记录总数量，默认false
      getMain: false, // 是否只返回rows数据，默认false
      pageIndex: 1, // 当前第几页
      pageSize: 2, // 每页条数
      hasMore: false, // 严格判断是否还有更多数据，默认false
      whereJson: { // 条件
        age: _.gte(0)  // 金额大于0
      },
      fieldJson: { // 代表只显示_id和money字段
        _id: true,
        money: true,
      },
      sortArr: [ // 按_id降序 asc 升序 desc 降序 
        { name: "_id", type: "desc" }
      ],
    });

  }

  @Get('/select')
  select(): Promise<Document[] | SelectResult> {
    return this.dbService.select({
      dbName: 'qa-users',
      getCount: true, // 是否需要同时查询满足条件的记录总数量，默认false
      getMain: false, // 是否只返回rows数据，默认false
      pageIndex: 3, // 当前第几页
      pageSize: 2, // 每页条数
      hasMore: false, // 严格判断是否还有更多数据，默认false
      // whereJson: { // 条件
      //   age: _.gte(0)  // 金额大于0
      // },
      // // 代表只显示_id和money字段
      // fieldJson: {
      //   _id: true,
      //   money: true, 
      // },
      // // 按_id降序 asc 升序 desc 降序 
      // sortArr: [
      //   { name: "_id", type: "desc" }
      // ],
    });

  }

  @Get('/count')
  count(): Promise<number> {
    return this.dbService.count({
      dbName: "qa-roles",// 表名
      foreignDB:[
         {
          dbName: "qa-roles",
          localKey: "user_id",
          foreignKey: "_id",
          as: "wuhu",
        }
      ]
    });
  }

  @Get('/update')
  update(): Promise<UpdateResult> {
    return this.dbService.update({
      dbName: 'qa-users',
      whereJson: {
        age: _.gte(30),
      },
      dataJson: {
        _add_time: 0
      }
    });

  }

  @Get('/updateById')
  updateById(): Promise<UpdateResult> {
    return this.dbService.updateById({
      dbName: 'qa-users',
      id: "689beb65a0556c810061751f",
      dataJson: {
        age: 10086
      }
    });

  }

  @Get('/updateAndReturn')
  updateAndReturn(): Promise<Document | null> {
    return this.dbService.updateAndReturn({
      dbName: 'qa-users',
      whereJson: {
        age: 10086,
      },
      dataJson: {
        fuck: _.remove()
      }
    });
  }

  @Get('/setById')
  setById(): Promise<UpdateResult> {
    return this.dbService.setById({
      dbName: 'qa-users',
      id: "123456123456123456123456",
      dataJson: {
        fuck: '我曹牛吗'
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
