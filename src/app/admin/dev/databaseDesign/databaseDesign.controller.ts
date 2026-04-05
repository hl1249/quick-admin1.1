import {
  BadRequestException,
  Body,
  Controller,
  Post,
} from '@nestjs/common';
import { InjectConnection } from '@nestjs/mongoose';
import type { Connection } from 'mongoose';
import type { Db } from 'mongodb';

/** 单字段描述，对应 $jsonSchema properties 里的一项 */
export type SchemaField = {
  key: string;
  bsonType: string;
};

export type CreateCollectionBody = {
  /** MongoDB 数据库名；省略则使用连接串默认库 */
  dbName?: string;
  /** 集合名（表名）；可与 collectionName 二选一 */
  tableName?: string;
  collectionName?: string;
  /** 字段列表；空数组表示只建集合、不加 schema 校验 */
  fields?: SchemaField[];
  /** 对应 $jsonSchema.required，文档必须包含的字段名 */
  required?: string[];
  /**
   * 是否在集合上启用 validator（需 fields 非空）
   * 默认 true；若 false 则仅 createCollection，不挂 $jsonSchema
   */
  withValidator?: boolean;
};

function assertCollectionName(name: string) {
  if (!name || typeof name !== 'string') {
    throw new BadRequestException('tableName 不能为空');
  }
  if (name.includes('\0') || name === '' || name.startsWith('system.')) {
    throw new BadRequestException('非法的集合名');
  }
  if (name.includes('$')) {
    throw new BadRequestException('集合名不能包含 $');
  }
}

function buildJsonSchema(
  fields: SchemaField[],
  requiredKeys: string[] | undefined,
): Record<string, unknown> {
  const properties: Record<string, unknown> = {};
  for (const f of fields) {
    if (!f?.key || typeof f.key !== 'string') continue;
    if (!f.bsonType || typeof f.bsonType !== 'string') {
      throw new BadRequestException(`字段 ${f.key} 缺少 bsonType`);
    }
    properties[f.key] = { bsonType: f.bsonType };
  }
  const schema: Record<string, unknown> = {
    bsonType: 'object',
    properties,
  };
  if (requiredKeys?.length) {
    schema.required = [...new Set(requiredKeys)];
  }
  return schema;
}

@Controller()
export class DatabaseDesignController {
  constructor(@InjectConnection() private readonly connection: Connection) {}

  private getTargetDb(databaseName?: string): Db {
    const db = databaseName?.trim()
      ? this.connection.useDb(databaseName.trim(), { useCache: true }).db
      : this.connection.db;
    if (!db) {
      throw new BadRequestException('未获取到 MongoDB Db 实例，请确认已连接');
    }
    return db;
  }

  /**
   * 创建集合（表）；可选根据 fields 写入 $jsonSchema 校验器
   * POST body: { dbName?, tableName, fields?, required?, withValidator? }
   */
  @Post('/createDatabase')
  async createDatabase(@Body() body: CreateCollectionBody) {
    const tableName = (body.tableName ?? body.collectionName)?.trim();
    assertCollectionName(tableName!);

    const fields = Array.isArray(body.fields) ? body.fields : [];
    const withValidator =
      body.withValidator !== false && fields.length > 0;

    const mongoDb = this.getTargetDb(body.dbName);

    const names = await mongoDb.listCollections({ name: tableName }).toArray();
    if (names.length > 0) {
      throw new BadRequestException(`集合已存在: ${tableName}`);
    }

    if (withValidator) {
      const $jsonSchema = buildJsonSchema(fields, body.required);
      await mongoDb.createCollection(tableName, {
        validator: { $jsonSchema },
        validationLevel: 'strict',
        validationAction: 'error',
      });
    } else {
      await mongoDb.createCollection(tableName);
    }

    return {
      ok: true,
      dbName: body.dbName ?? this.connection.name,
      tableName,
      validator: withValidator,
    };
  }
}
