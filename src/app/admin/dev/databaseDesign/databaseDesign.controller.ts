import {
  BadRequestException,
  Body,
  Controller,
  Post,
  RequestMethod,
} from '@nestjs/common';
import { METHOD_METADATA, PATH_METADATA } from '@nestjs/common/constants';
import { InjectConnection } from '@nestjs/mongoose';
import type { Connection } from 'mongoose';
import type { Db } from 'mongodb';
import { existsSync, readdirSync, statSync } from 'fs';
import { relative, resolve } from 'path';
import { AppConfigService } from '@/config/app-config.service';

/** 单字段描述，对应 $jsonSchema properties 里的一项（复杂规则请改用 body.jsonSchema） */
export type SchemaField = {
  key: string;
  bsonType: string;
  /** 写入该字段的 description，仅文档/工具可读，不参与校验逻辑 */
  description?: string;
  minLength?: number;
  maxLength?: number;
  minimum?: number;
  maximum?: number;
  pattern?: string;
  enum?: unknown[];
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
   * 完整的 MongoDB $jsonSchema 对象（即 validator.$jsonSchema 的内层，含 bsonType、properties、required 等）。
   * 若提供则优先使用，不再根据 fields 拼装简易 schema。
   */
  jsonSchema?: Record<string, unknown>;
  /**
   * 与 Mongo 文档结构一致：等价于传入 jsonSchema，便于直接粘贴带 $jsonSchema 包一层的 JSON。
   */
  ['$jsonSchema']?: Record<string, unknown>;
  /**
   * 是否在集合上启用 validator（需 fields 非空或提供了 jsonSchema / $jsonSchema）
   * 默认 true；若 false 则仅 createCollection，不挂 $jsonSchema
   */
  withValidator?: boolean;
};

type GetAdminRoutesBody = {
  keyword?: string;
  withGlobalPrefix?: boolean;
};

type AdminRouteItem = {
  method: string;
  path: string;
  controller: string;
  handler: string;
  controllerPath: string;
  methodPath: string;
  file: string;
};

function assertCollectionName(
  name: string | undefined,
): asserts name is string {
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
  const optionalPropKeys: (keyof SchemaField)[] = [
    'description',
    'minLength',
    'maxLength',
    'minimum',
    'maximum',
    'pattern',
    'enum',
  ];
  for (const f of fields) {
    if (!f?.key || typeof f.key !== 'string') continue;
    if (!f.bsonType || typeof f.bsonType !== 'string') {
      throw new BadRequestException(`字段 ${f.key} 缺少 bsonType`);
    }
    const spec: Record<string, unknown> = { bsonType: f.bsonType };
    for (const k of optionalPropKeys) {
      const v = f[k];
      if (v !== undefined) spec[k as string] = v;
    }
    properties[f.key] = spec;
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

/** 从请求体取出自定义校验器：jsonSchema 优先，其次顶层 $jsonSchema */
function extractCustomJsonSchema(
  body: CreateCollectionBody,
): Record<string, unknown> | null {
  const a = body.jsonSchema;
  if (a && typeof a === 'object' && !Array.isArray(a) && Object.keys(a).length) {
    return a;
  }
  const b = body['$jsonSchema'];
  if (b && typeof b === 'object' && !Array.isArray(b) && Object.keys(b).length) {
    return b;
  }
  return null;
}

function scanControllerFiles(dir: string): string[] {
  const result: string[] = [];
  for (const name of readdirSync(dir)) {
    const fullPath = resolve(dir, name);
    const stat = statSync(fullPath);
    if (stat.isDirectory()) {
      result.push(...scanControllerFiles(fullPath));
      continue;
    }
    if (/\.controller\.(ts|js)$/.test(name)) {
      result.push(fullPath);
    }
  }
  return result;
}

function toRouteParts(value: unknown): string[] {
  if (Array.isArray(value)) {
    return value.flatMap((item) => toRouteParts(item));
  }
  if (typeof value === 'string') {
    return [value];
  }
  return [''];
}

function joinRoutePath(...parts: string[]): string {
  const normalized = parts
    .flatMap((part) => `${part ?? ''}`.split('/'))
    .map((part) => part.trim())
    .filter(Boolean);
  return normalized.length ? `/${normalized.join('/')}` : '/';
}

function getControllerRoutePrefix(filePath: string, rootDir: string): string {
  const relativePath = relative(rootDir, filePath)
    .replace(/\.controller\.(ts|js)$/, '')
    .replace(/\\/g, '/')
    .split('/')
    .filter((part) => part !== 'controller' && part !== 'controllers')
    .join('/');
  return joinRoutePath(relativePath);
}

function getRequestMethodName(methodMetadata: unknown): string {
  if (typeof methodMetadata === 'number' && RequestMethod[methodMetadata]) {
    return RequestMethod[methodMetadata].toUpperCase();
  }
  if (typeof methodMetadata === 'string') {
    return methodMetadata.toUpperCase();
  }
  return 'UNKNOWN';
}

@Controller()
export class DatabaseDesignController {
  constructor(
    @InjectConnection() private readonly connection: Connection,
    private readonly appConfig: AppConfigService,
  ) {}

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
   * POST body: { dbName?, tableName, fields?, required?, jsonSchema?, withValidator? }
   */
  @Post('/createDatabase')
  async createDatabase(@Body() body: CreateCollectionBody) {
    
    throw new BadRequestException('功能开发中');
    const tableName = (body.tableName ?? body.collectionName)?.trim();
    assertCollectionName(tableName);

    const fields = Array.isArray(body.fields)
      ? (body.fields as SchemaField[])
      : [];
    const customSchema = extractCustomJsonSchema(body);
    const withValidator =
      body.withValidator !== false &&
      (fields.length > 0 || customSchema != null);
    
    const mongoDb = this.getTargetDb(body.dbName);

    const names = await mongoDb.listCollections({ name: tableName }).toArray();
    if (names.length > 0) {
      throw new BadRequestException(`集合已存在: ${tableName}`);
    }

    if (withValidator) {
      const $jsonSchema =
        customSchema ?? buildJsonSchema(fields ?? [], body.required);
      await mongoDb.createCollection(tableName ?? '', {
        validator: { $jsonSchema },
        validationLevel: 'strict',
        validationAction: 'error',
      });
    } else {
      await mongoDb.createCollection(tableName ?? '');
    }

    return {
      ok: true,
      dbName: body.dbName ?? this.connection.name,
      tableName,
      validator: withValidator,
    };
  }

  @Post('/getRouter')
  async getRoute(@Body() body: GetAdminRoutesBody = {}) {
    const adminDir = resolve(__dirname, '../..');
    const rootDir = resolve(adminDir, '../..');
    if (!existsSync(adminDir)) {
      throw new BadRequestException(`未找到 admin 目录: ${adminDir}`);
    }

    const keyword = body.keyword?.trim().toLowerCase();
    const globalPrefix =
      body.withGlobalPrefix === false ? '' : this.appConfig.globalPrefix;

    const routes: AdminRouteItem[] = [];
    for (const filePath of scanControllerFiles(adminDir)) {
      const mod = require(filePath) as Record<string, unknown>;
      const controllerClass = Object.values(mod).find(
        (item) =>
          typeof item === 'function' &&
          !!item.name &&
          item.name.endsWith('Controller'),
      ) as { name: string; prototype: Record<string, unknown> } | undefined;

      if (!controllerClass?.prototype) {
        continue;
      }

      const controllerPath = getControllerRoutePrefix(filePath, rootDir);
      const handlerNames = Object.getOwnPropertyNames(controllerClass.prototype);

      for (const handlerName of handlerNames) {
        if (handlerName === 'constructor') {
          continue;
        }
        const handler = controllerClass.prototype[handlerName];
        if (typeof handler !== 'function') {
          continue;
        }

        const methodMetadata = Reflect.getMetadata(METHOD_METADATA, handler);
        if (methodMetadata === undefined) {
          continue;
        }

        const methodPaths = toRouteParts(
          Reflect.getMetadata(PATH_METADATA, handler),
        );

        for (const methodPath of methodPaths) {
          const route: AdminRouteItem = {
            method: getRequestMethodName(methodMetadata),
            path: joinRoutePath(globalPrefix, controllerPath, methodPath),
            controller: controllerClass.name,
            handler: handlerName,
            controllerPath,
            methodPath: joinRoutePath(methodPath),
            file: relative(adminDir, filePath).replace(/\\/g, '/'),
          };

          if (!keyword) {
            routes.push(route);
            continue;
          }

          const searchText =
            `${route.method} ${route.path} ${route.controller} ${route.handler} ${route.file}`.toLowerCase();
          if (searchText.includes(keyword)) {
            routes.push(route);
          }
        }
      }
    }

    routes.sort((a, b) => a.path.localeCompare(b.path) || a.method.localeCompare(b.method));

    return {
      ok: true,
      total: routes.length,
      list: routes,
    };
  }
}
