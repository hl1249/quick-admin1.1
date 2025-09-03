import { Injectable, Logger } from '@nestjs/common';

import type {
  AddParams, AddsParams, DelParams, DelByIdParams, FindById, FindByWhereJsonParams, SelectsParams,
  SelectParams, SelectResult, CountParams, UpdateParams, UpdateByIdParams, UpdateAndReturnParams, SetByIdParams,
  SumParams,
  MaxParams,
  MinParams,
  AvgParams,
  SampleParams,
} from './utils.types';
import { InsertOneResult, DeleteResult, UpdateResult, ObjectId, Document, InsertManyResult } from 'mongodb'
import { InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';
import { DEBUG } from '@/config';
import { UtilsService } from './utils.service';
import { TransformDbParams } from './db.decorator';

@Injectable()
export class DbService {

  constructor(
    @InjectConnection() private readonly connection: Connection,
    private readonly utilsService: UtilsService,
  ) {
    if (DEBUG) {
      let logger = new Logger('DbService');
      logger.debug('默认DB操作数据库', this.connection.name);
    }
  }

  // 单条数据插入
  async add(params: AddParams): Promise<InsertOneResult> {
    const {
      dbName,
      dataJson,
      cancelAddTime = false,
      cancelAddTimeStr = false,
      db
    } = params;
    
    // 是否包含添加时间戳
    if (!cancelAddTime) {
      dataJson['_add_time'] = Date.now();
      if (!cancelAddTimeStr) {
        dataJson['_add_time_str'] = this.utilsService.formatTimestamp(new Date())
      }
    }

    // 判断是否有传入数据库实例
    if (db) {
      // 用传入的数据库实例执行添加
      return await db.collection(dbName).add(dataJson);
    } else {
      //插入到默认数据库
      return await this.connection.collection(dbName).insertOne(dataJson); // 示例
    }

  }

  async adds(params: AddsParams): Promise<InsertManyResult> {
    const {
      dbName,
      dataJson,
      cancelAddTime = false,
      cancelAddTimeStr = false,
      db
    } = params;
    // 是否包含添加时间戳
    if (!cancelAddTime) {
      const currentTime = Date.now();
      const currentTimeStr = this.utilsService.formatTimestamp(new Date());
      dataJson.forEach(item => {
        item['_add_time'] = currentTime;
        if (!cancelAddTimeStr) {
          item['_add_time_str'] = currentTimeStr;
        }
      });
    }

    if (db) {
      return await db.collection(dbName).insertMany(dataJson);
    } else {
      return await this.connection.collection(dbName).insertMany(dataJson);
    }
  }

  // 批量删除
  @TransformDbParams
  async del(params: DelParams): Promise<DeleteResult> {
    const {
      dbName,
      whereJson,
      db
    } = params;

    if (db) {
      return await db.collection(dbName).deleteMany(whereJson);
    } else {
      return await this.connection.collection(dbName).deleteMany(whereJson);
    }
  }

  // 根据ID删除
  @TransformDbParams
  async deleteById(params: DelByIdParams): Promise<DeleteResult> {
    const {
      dbName,
      id,
      db
    } = params;

    if (db) {
      return await db.collection(dbName).deleteMany({ _id: new ObjectId(id) });
    } else {
      return await this.connection.collection(dbName).deleteMany({ _id: new ObjectId(id) });
    }
  }

  @TransformDbParams
  async findById(params: FindById): Promise<Document | null> {

    const {
      dbName,
      id,
      fieldJson = {},
      db
    } = params;

    if (db) {
      return await db.collection(dbName).findOne({ _id: new ObjectId(id) }, { projection: fieldJson })
    } else {
      return await this.connection.collection(dbName).findOne({ _id: new ObjectId(id) }, { projection: fieldJson })
    }
  }


  @TransformDbParams
  async findByWhereJson(params: FindByWhereJsonParams): Promise<Document | null> {

    const {
      dbName,
      whereJson,
      fieldJson = {},
      db
    } = params;
    if (db) {
      return await db.collection(dbName).findOne(whereJson, { projection: fieldJson })
    } else {
      return await this.connection.collection(dbName).findOne(whereJson, { projection: fieldJson })
    }
  }

  @TransformDbParams
  async update(params: UpdateParams): Promise<UpdateResult> {
    const {
      dbName,
      whereJson,
      dataJson = {},
      db
    } = params;

    // 如果没有传入数据，则不进行更新
    if (Object.keys(dataJson).length === 0) {
      throw new Error('没有传入更新数据');
    }

    // 判断是否有传入数据库实例
    if (db) {
      return await db.collection(dbName).updateMany(whereJson, dataJson);
    } else {
      return await this.connection.collection(dbName).updateMany(whereJson, dataJson);
    }

  }

  @TransformDbParams
  async updateById(params: UpdateByIdParams): Promise<UpdateResult> {
    const {
      dbName,
      id,
      dataJson = {},
      db
    } = params;

    // 如果没有传入数据，则不进行更新
    if (Object.keys(dataJson).length === 0) {
      throw new Error('没有传入更新数据');
    }

    // 判断是否有传入数据库实例
    if (db) {
      return await db.collection(dbName).updateMany({ _id: new ObjectId(id) }, dataJson);
    } else {
      return await this.connection.collection(dbName).updateMany({ _id: new ObjectId(id) }, dataJson);
    }

  }

  @TransformDbParams
  async updateAndReturn(params: UpdateAndReturnParams): Promise<Document | null> {
    const {
      dbName,
      whereJson,
      dataJson = {},
      db
    } = params;

    // 如果没有传入数据，则不进行更新
    if (Object.keys(dataJson).length === 0) {
      throw new Error('没有传入更新数据');
    }

    // 判断是否有传入数据库实例
    if (db) {
      return await db.collection(dbName).findOneAndUpdate(whereJson, dataJson, {
        returnDocument: 'after', // 返回更新后的文档
      });
    } else {
      return await this.connection.collection(dbName).findOneAndUpdate(whereJson, dataJson, {
        returnDocument: 'after', // 返回更新后的文档
      });
    }

  }

  @TransformDbParams
  async setById(params: SetByIdParams): Promise<UpdateResult> {
    const {
      dbName,
      id,
      dataJson = {},
      db
    } = params;

    // 如果没有传入数据，则不进行更新
    if (Object.keys(dataJson).length === 0) {
      throw new Error('没有传入更新数据');
    }

    // 判断是否有传入数据库实例
    if (db) {
      return await db.collection(dbName).updateOne({ _id: new ObjectId(id) }, dataJson, {
        upsert: true, // 找不到时插入新文档
      });
    } else {
      return await this.connection.collection(dbName).updateOne({ _id: new ObjectId(id) }, dataJson, {
        upsert: true, // 找不到时插入新文档
      });
    }
  }

  @TransformDbParams
  async selects(params: SelectsParams): Promise<SelectResult | Document[]> {
    let {
      dbName,
      data = {},
      whereJson = {},
      foreignDB = [],
      groupJson = {},
      addFields = {},
      getMain = false,
      getOne = false,
      getCount = false,
      hasMore = false,
      pageIndex = 1,
      pageSize = 10,
      sortArr = {},
      lastWhereJson = {},
      fieldJson = {},
      db
    } = params;

    if (data.pageIndex) pageIndex = Number(data.pageIndex);
    if (data.pageSize) pageSize = Number(data.pageSize);
    if (data.sortRule) sortArr = data.sortRule

    console.log("表渲染", data)
    // 统一获取集合引用
    const collection = db
      ? db.collection(dbName)
      : this.connection.collection(dbName);

    console.log('foreignDB[0]', JSON.stringify(foreignDB, null, 2))
    console.log('addFields[0]', JSON.stringify(addFields, null, 2))
    console.log('查询语句',JSON.stringify([
      ...(data.match && Object.keys(data.match).length > 0 ? [{ $match: data.match }] : []),
      { $match: whereJson },
      ...(groupJson && Object.keys(groupJson).length > 0 ? [{ $group: groupJson }] : []),
      ...foreignDB,
      { $match: lastWhereJson },
      ...(addFields && Object.keys(addFields).length > 0 ? [{ $addFields: addFields }] : []),
      ...(fieldJson && Object.keys(fieldJson).length > 0 ? [{ $project: fieldJson }] : []),
      ...(sortArr && Object.keys(sortArr).length > 0 ? [{ $sort: sortArr }] : []),
      { $skip: pageSize * (pageIndex - 1) },
      { $limit: pageSize }
    ]))
    // 执行查询
    const result = await collection.aggregate([
      ...(data.match && Object.keys(data.match).length > 0 ? [{ $match: data.match }] : []),
      { $match: whereJson },
      ...(groupJson && Object.keys(groupJson).length > 0 ? [{ $group: groupJson }] : []),
      ...foreignDB,
      { $match: lastWhereJson },
      ...(addFields && Object.keys(addFields).length > 0 ? [{ $addFields: addFields }] : []),
      ...(fieldJson && Object.keys(fieldJson).length > 0 ? [{ $project: fieldJson }] : []),
      ...(sortArr && Object.keys(sortArr).length > 0 ? [{ $sort: sortArr }] : []),
      { $skip: pageSize * (pageIndex - 1) },
      { $limit: pageSize }
    ]).toArray();


    // 如果只需要返回主数据，提前返回
    if (getMain) {
      return result;
    }

    // 处理单条结果
    if (getOne) {
      return {
        rows: result[0],
        hasMore: false,
        total: 1,
        getCount,
        pagination: { pageIndex, pageSize },
        msg: '查询成功',
        code: 0
      };
    }

    // 计算总数和是否有更多数据
    let total = result.length;
    let calculatedHasMore = result.length >= pageSize;

    if (getCount || hasMore) {
      total = await collection.countDocuments(whereJson);
      calculatedHasMore = (pageIndex * pageSize) < total;
    }

    return {
      rows: result,
      hasMore: calculatedHasMore,
      total,
      getCount,
      pagination: { pageIndex, pageSize },
      msg: '查询成功',
      code: 0
    };
  }

  @TransformDbParams
  async getTableData(params: SelectsParams): Promise<SelectResult | Document[]> {
    return this.selects(params);
  }

  @TransformDbParams
  async select(params: SelectParams): Promise<SelectResult | Document[]> {
    const {
      dbName,
      getCount = false,
      hasMore = false,
      getMain = false,
      getOne = false,
      pageIndex = 1,
      pageSize = 10,
      whereJson = {},
      fieldJson = {},
      sortArr = {},
      db
    } = params;

    // 统一获取集合引用
    const collection = db
      ? db.collection(dbName)
      : this.connection.collection(dbName);

    // 执行查询
    const cursor = collection.find(whereJson, { projection: fieldJson })
      .sort(sortArr)
      .skip((pageIndex - 1) * pageSize)
      .limit(pageSize);

    const result = await cursor.toArray();

    // 如果只需要返回主数据，提前返回
    if (getMain) {
      return result;
    }

    // 处理单条结果
    if (getOne) {
      return {
        rows: result[0],
        hasMore: false,
        total: 1,
        getCount,
        pagination: { pageIndex, pageSize },
        msg: '查询成功',
        code: 0
      };
    }

    // 计算总数和是否有更多数据
    let total = result.length;
    let calculatedHasMore = result.length >= pageSize;

    if (getCount || hasMore) {
      total = await collection.countDocuments(whereJson);
      calculatedHasMore = (pageIndex * pageSize) < total;
    }

    return {
      rows: result,
      hasMore: calculatedHasMore,
      total,
      getCount,
      pagination: { pageIndex, pageSize },
      msg: '查询成功',
      code: 0
    };
  }

  @TransformDbParams
  async count(params: CountParams): Promise<number> {
    const {
      dbName,
      whereJson = {},
      foreignDB = [],
      lastWhereJson = {},
      db
    } = params;


    // 统一获取集合引用
    const collection = db
      ? db.collection(dbName)
      : this.connection.collection(dbName);

    // 执行查询
    const result = await collection.aggregate([
      { $match: whereJson },
      ...foreignDB,
      { $match: lastWhereJson },
      { $count: 'total' }
    ]).toArray();
    const total = result.length > 0 ? result[0].total : 0;
    return total;
  }

  @TransformDbParams
  async sum(params: SumParams): Promise<number> {
    const {
      dbName,
      whereJson = {},
      fieldName = '',
      db
    } = params;


    // 统一获取集合引用
    const collection = db
      ? db.collection(dbName)
      : this.connection.collection(dbName);

    // 执行查询
    const result = await collection.aggregate([
      { $match: whereJson },
      {
        $group: {
          _id: null,                  // 不分组，全部聚合
          totalAmount: { $sum: `$${fieldName}` }
        }
      }
    ]).toArray();
    const totalAmount = result.length > 0 ? result[0].totalAmount : 0;
    return totalAmount;
  }

  @TransformDbParams
  async max(params: MaxParams): Promise<number> {
    const {
      dbName,
      whereJson = {},
      fieldName = '',
      db
    } = params;


    // 统一获取集合引用
    const collection = db
      ? db.collection(dbName)
      : this.connection.collection(dbName);

    // 执行查询
    const result = await collection.aggregate([
      { $match: whereJson },
      {
        $group: {
          _id: null,                  // 不分组，全部聚合
          totalAmount: { $max: `$${fieldName}` }
        }
      }
    ]).toArray();
    const totalAmount = result.length > 0 ? result[0].totalAmount : 0;
    return totalAmount;
  }

  @TransformDbParams
  async min(params: MinParams): Promise<number> {
    const {
      dbName,
      whereJson = {},
      fieldName = '',
      db
    } = params;


    // 统一获取集合引用
    const collection = db
      ? db.collection(dbName)
      : this.connection.collection(dbName);

    // 执行查询
    const result = await collection.aggregate([
      { $match: whereJson },
      {
        $group: {
          _id: null,                  // 不分组，全部聚合
          totalAmount: { $min: `$${fieldName}` }
        }
      }
    ]).toArray();
    const totalAmount = result.length > 0 ? result[0].totalAmount : 0;
    return totalAmount;
  }

  @TransformDbParams
  async avg(params: AvgParams): Promise<number> {
    const {
      dbName,
      whereJson = {},
      fieldName = '',
      db
    } = params;


    // 统一获取集合引用
    const collection = db
      ? db.collection(dbName)
      : this.connection.collection(dbName);

    // 执行查询
    const result = await collection.aggregate([
      { $match: whereJson },
      {
        $group: {
          _id: null,                  // 不分组，全部聚合
          totalAmount: { $avg: `$${fieldName}` }
        }
      }
    ]).toArray();
    const totalAmount = result.length > 0 ? result[0].totalAmount : 0;
    return totalAmount;
  }

  @TransformDbParams
  async sample(params: SampleParams): Promise<number> {
    const {
      dbName,
      whereJson = {},
      size = 1,
      fieldJson = {},
      db
    } = params;


    // 统一获取集合引用
    const collection = db
      ? db.collection(dbName)
      : this.connection.collection(dbName);

    // 执行查询
    const result = await collection.aggregate([
      { $match: whereJson },
      { $sample: { size } },
      { projection: fieldJson }
    ]).toArray();
    const totalAmount = result.length > 0 ? result[0].totalAmount : 0;
    return totalAmount;
  }



}