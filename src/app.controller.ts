import { Post, Controller, Get, SetMetadata  } from '@nestjs/common';
import { DeleteResult, UpdateResult, Document, InsertManyResult, CollectionInfo } from 'mongodb'
import { SelectResult } from '@/common/db/db.types';
import { DbService } from '@/common/db/db.service';
import { JwtService } from '@/common/jwt/jwt.service';
import { _, $ } from '@/common/db/field-query';
import { Log } from '@/common/logger/logger.decorator';
import { CacheService } from '@/common/cache/cache.service'
import { InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';
import { SetupService } from '@/app/setup/setup.service';
@Log()
@Controller()
@SetMetadata('skipAuth', true) // 设置该路由不需要验证token
export class AppController {

  constructor(
    private readonly dbService: DbService,
    private readonly jwtService: JwtService,
    private readonly cache: CacheService,
    private readonly setupService: SetupService,
    @InjectConnection() private readonly connection: Connection,
  ) {}

  @Get('/setup/status')
  @SetMetadata('skipLog', true)
  setupStatus() {
    return this.setupService.getStatus();
  }

  @Post('/setup/install')
  @SetMetadata('skipLog', true)
  installDatabase() {
    return this.setupService.installDatabase();
  }

  @Get('/dbList')
  async dbList(): Promise<Pick<CollectionInfo, 'name' | 'type'>[]> {
    return this.connection.listCollections();
  }

  @Get('/ossProvider')
  async ossProvider(): Promise<Document | null> {
    return await this.dbService.selects({
      dbName:'qa-app-config',
      whereJson:{
        _id: "69bcbb2e0c34b64800565ec6"
      },
      getMain: true,
      pageSize: 1,
      foreignDB:[{
        limit:1,
        dbName: 'qa-storage-space',
        localKey: "oss_provider",
        foreignKey: 'provider',
        as: 'space',
        whereJson: {
          enable: true
        },
      },]
    })
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
      dbName: 'qa-storage-region',
      dataJson: [
        {
          value: 'ap-chengdu',
          label: '成都',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-shanghai',
          label: '上海',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-guangzhou',
          label: '广州',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-nanjing',
          label: '南京',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-beijing',
          label: '北京',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-chongqing',
          label: '重庆',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-shenzhen-fsi',
          label: '深圳金融',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-shanghai-fsi',
          label: '上海金融',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-beijing-fsi',
          label: '北京金融',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-hongkong',
          label: '中国香港',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-singapore',
          label: '新加坡',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-mumbai',
          label: '孟买',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-jakarta',
          label: '雅加达',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-seoul',
          label: '首尔',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-bangkok',
          label: '曼谷',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'ap-tokyo',
          label: '东京',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'na-siliconvalley',
          label: '硅谷（美西）',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'na-ashburn',
          label: '弗吉尼亚（美东）',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'na-toronto',
          label: '多伦多',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'sa-saopaulo',
          label: '圣保罗',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'eu-frankfurt',
          label: '法兰克福',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
        {
          value: 'eu-moscow',
          label: '莫斯科',
          storage_id: '69bcba3b0c34b64800565ea7',
        },
      ],
    });
  }

  @Post('/del')
  del(): Promise<DeleteResult> {
    return this.dbService.del({
      dbName: 'qa-users',
      whereJson: {
        age: _.exists(true),
      },
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
        'userInfo.name': '王德发',
        // _id: "689beb65a0556c810061751f",
        // age: _.and(_.gte(10085), _.lte(10086)),
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
    });
  }

  @Get('/selects')
  async selects(): Promise<Document[] | SelectResult> {
    return await this.dbService.selects({
      dbName: 'qa-users',
      getCount: true, // 是否需要同时查询满足条件的记录总数量，默认false
      getMain: false, // 是否只返回rows数据，默认false
      pageIndex: 1, // 当前第几页
      pageSize: 10, // 每页条数
      hasMore: false, // 严格判断是否还有更多数据，默认false
      // groupJson: {
      //   _id: "$age",
      //   yuan_age: $.first('$age'),
      //   sum: $.sum($.cond({
      //     if: $.gte(['$age',20]),
      //     then: 10,
      //     else: 0
      //   }))
      // },//数据
      // whereJson: { // 条件{}
      //   role: _.eq('admin')
      // },
      addFields: {
        role_name: '$roles.role_id',
        comment: '$roles.comment',
        andSex: {
          $anyElementTrue: {
            $map: {
              input: '$roles',
              as: 'r',
              in: { $gte: ['$$r.no', 1] }, // 判断每个 sex 是否 > 0
            },
          },
        },
      },
      foreignDB: [
        {
          limit:1,
          dbName: 'qa-roles',
          // localKey: "_id",
          localKey: $.arrayElemAt(['$role', 0]),
          foreignKey: 'role_id',
          as: 'roles',
          fieldJson: {
            // sex: true,
          },
        },
        //   whereJson: {
        //     txt: _.eq('我是roles表数据1')
        //   },
        //   addFields: {
        //     roleSex: "$sex",
        //     roleAge: "$age",
        //     bigAge: {
        //       // "age":_.gt(100)
        //       '$gt': ['$age', '$roles.age']
        //     }, // 计算字段
        //   },
        //   sortArr: [
        //     { name: "age", type: "asc" }
        //   ],
        //   foreignDB: [
        //     {
        //       dbName: "qa-menus",
        //       localKey: "txt", //嵌套foreignDB 拿到上级表字段 直接写就行
        //       foreignKey: "roles_txt",
        //       as: "menus",
        //       sortArr: [
        //         { name: "age", type: "asc" }
        //       ],

        //       limit: 10 // limit>1则以数组形式返回
        //     }

        //   ],
        //   limit: 1 // limit=1则以对象形式返回 后续的$lookup中可以使用 roles.字段
        // },
        // {
        //   dbName: "qa-menus",
        //   localKey: "roles.txt", //同级别foreignDB 拿到上级表对象用上级表的as
        //   foreignKey: "roles_txt",
        //   as: "menus",
        //   sortArr: [
        //     { name: "age", type: "asc" }
        //   ],

        //   limit: 10 // limit>1则以数组形式返回
        // }
      ],

      lastWhereJson: {
        // _id: _.lte(20)
      },
      fieldJson: {
        // 代表只显示_id和money字段 会影响副表的查询
        // _id: true,
        // age: false,
        // _id: true
      },
      sortArr: [
        // 按_id降序 asc 升序 desc 降序
        { name: '_id', type: 'asc' },
      ],
    });
  }

  @Get('/getTableData')
  getTableData(): Promise<Document[] | SelectResult> {
    return this.dbService.getTableData({
      data: {
        pageIndex: 1,
        pageSize: 2,
        formData: {
          // name: '批量',
          // _add_time: [0, Date.now()] // datetimerange 对应 mode []
        },
        columns: [
          { key: 'name', title: '昵称', type: 'text', width: 160, mode: '%%' },
          {
            key: '_add_time',
            title: '添加时间',
            type: 'datetimerange',
            width: 400,
            mode: '[]',
          },
        ],
        sortRule: [{ name: 'no', type: 'desc' }],
      },
      dbName: 'qa-users',
      pageIndex: 1, // 当前第几页
      pageSize: 2, // 每页条数
    });
  }

  @Get('/select')
  select(): Promise<Document[] | SelectResult> {
    return this.dbService.select({
      dbName: 'qa-users',
      getCount: true, // 是否需要同时查询满足条件的记录总数量，默认false
      getMain: false, // 是否只返回rows数据，默认false
      pageIndex: 1, // 当前第几页
      pageSize: 2, // 每页条数
      hasMore: false, // 严格判断是否还有更多数据，默认false
      whereJson: {
        name: new RegExp('3$'),
      },
      // whereJson: _.and([
      //   {
      //     age: _.gte(50)
      //   },
      //   _.or([
      //     {
      //       _add_time: _.gte(0)
      //     },
      //     {
      //       arr: _.exists(true)
      //     }
      //   ])
      // ])
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
      dbName: 'qa-users', // 表名
      whereJson: {
        age: _.gte(30),
      },
    });
  }

  @Get('/sum')
  sum(): Promise<number> {
    return this.dbService.sum({
      dbName: 'qa-users', // 表名
      fieldName: 'age', // 求和字段
    });
  }

  @Get('/update')
  update(): Promise<UpdateResult> {
    return this.dbService.update({
      dbName: 'qa-storage-region',
      whereJson: {
        _add_time: _.gt(0)
      },
      dataJson: {
        // 'arr.0': 10086,
        // giao:"维护"
        // token:[],
        provider:'tencent'
      },
    });
  }

  @Get('/updateById')
  updateById(): Promise<UpdateResult> {
    return this.dbService.updateById({
      dbName: 'qa-users',
      id: '689beb65a0556c810061751f',
      dataJson: {
        age: 10086,
      },
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
        fuck: _.remove(),
      },
    });
  }

  @Get('/setById')
  setById(): Promise<UpdateResult> {
    return this.dbService.setById({
      dbName: 'qa-users',
      id: '123456123456123456123456',
      dataJson: {
        fuck: '我曹牛吗',
      },
    });
  }

  @Get('/jwt')
  async testJwt(): Promise<string> {
    // const token = this.jwtService.generateToken({
    //   userId: '12345',
    //   username: 'testuser',
    //   role: 'admin',
    // });
    // return token;
    return this.jwtService.generateToken('123');
  }

   @Get('/cacheRead')
  async cacheRead() {
    return {
      value: await this.cache.get('wuhu'),
    };
  }

 @Get('/cacheSet')
  async cacheSet() {
    return await this.cache.set('wuhu', { name: 1 });
  }

  @Get('/giao')
  async giao() {
    return await this.cache.deleteByPrefix('auth');
  }
 @Get('/incr')
  async incr() {
    return await this.cache.incr('authVersion');
  }
}
