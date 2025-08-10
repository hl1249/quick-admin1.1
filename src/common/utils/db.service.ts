import { Injectable,Logger } from '@nestjs/common';

import { AddParams } from './db.types';
import { InsertOneResult, DeleteResult, UpdateResult, ObjectId, Document, InsertManyResult } from 'mongodb'
import { InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';
import { DEBUG } from '@/config';

@Injectable()
export class DbService {

  constructor(
    @InjectConnection() private readonly connection: Connection,
  ) {
    if (DEBUG) {
      let logger = new Logger('DbService');
      logger.debug('默认DB操作数据库',this.connection.name);
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
        dataJson['_add_time_str'] = new Date().toISOString();
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
}