import { Injectable, Logger } from '@nestjs/common';

import type { AddParams, AddsParams, DelParams, FindByWhereJsonParams, UpdateParams } from './db.types';
import { InsertOneResult, DeleteResult, UpdateResult, ObjectId, Document, InsertManyResult } from 'mongodb'
import { InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';
import { DEBUG } from '@/config';
import { UtilsService } from './utils.service';
import { WhereJsonDecorator } from './db.decorator';

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

  @WhereJsonDecorator
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

  @WhereJsonDecorator
  async findByWhereJson(params: FindByWhereJsonParams): Promise<Document[]> {

    const {
      dbName,
      whereJson,
      fieldJson = {},
      sortArr = [],
      db
    } = params;


    for(const itme in whereJson){
      console.log('or转换的',itme,whereJson[itme]);
    }    
    let cursor;
    if (db) {
      cursor = db.collection(dbName).find({whereJson}, { projection: fieldJson });
    } else {
      cursor = this.connection.collection(dbName).find(whereJson, { projection: fieldJson });
    }

    // 处理排序
    if (sortArr.length > 0) {
      const sortObj = sortArr.reduce((acc, curr) => ({ ...acc, ...curr }), {});
      cursor = cursor.sort(sortObj);
    }

    return await cursor.toArray();
  }

  @WhereJsonDecorator
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

}