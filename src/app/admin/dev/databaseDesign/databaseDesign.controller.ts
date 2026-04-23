import {
  BadRequestException,
  Body,
  Controller,
  Post,
  Res,
} from '@nestjs/common';
import { METHOD_METADATA, PATH_METADATA } from '@nestjs/common/constants';
import { InjectConnection } from '@nestjs/mongoose';
import type { Connection } from 'mongoose';
import type { Db, InsertOneResult } from 'mongodb';
import type { Response } from 'express';
import { existsSync, mkdirSync, readFileSync, readdirSync, rmSync, statSync, writeFileSync } from 'fs';
import { dirname, relative, resolve } from 'path';
import archiver = require('archiver');
import { DbService } from '@/common/db/db.service';
import { AuthService } from '@/app/admin/auth/auth.service';

/** 单字段描述，对应 $jsonSchema properties 里的一项（复杂规则请改用 body.jsonSchema） */
export type SchemaField = {
  key: string;
  bsonType?: string | string[];
  anyOf?: Record<string, unknown>[];
  /** 写入该字段的 description，仅文档/工具可读，不参与校验逻辑 */
  description?: string;
  minLength?: number;
  maxLength?: number;
  minimum?: number;
  maximum?: number;
  pattern?: string;
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

type CrudField = SchemaField & {
  title?: string;
  required?: boolean;
  formType?: string;
  formConfig?: Record<string, any>;
};

type DownloadControllerBody = {
  dirName?: string;
  controllerName?: string;
  tableName?: string;
  collectionName?: string;
  fields?: CrudField[];
};

type DownloadCrudBody = {
  dirName: string;
  controllerName: string;
  tableName: string;
  autoGenerateRoute?: boolean;
  pageRelativePath?: string;
  menuConfig?: CrudMenuConfig;
  fields?: CrudField[];
};

type CrudMenuConfig = {
  menu_id?: string;
  title?: string;
  icon?: string;
  sort?: number | string;
  parent_id?: string;
  enable?: boolean;
  comment?: string;
};

type NormalizedCrudMenuConfig = {
  menu_id: string;
  title: string;
  icon?: string;
  sort: number;
  parent_id?: string;
  enable: boolean;
  comment?: string;
  path: string;
  component: string;
};

type GetAdminRoutesBody = {
  keyword?: string;
};

type AdminRouteItem = {
  path: string;
  controller: string;
  file: string;
};

type AdminRouteTreeNode = {
  controller: string;
  controllerPath: string;
  file: string;
  routes: AdminRouteItem[];
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
  ];
  for (const f of fields) {
    if (!f?.key || typeof f.key !== 'string') continue;
    const spec: Record<string, unknown> = {};
    if (Array.isArray(f.anyOf) && f.anyOf.length) {
      spec.anyOf = f.anyOf;
    } else {
      const bsonTypes = Array.isArray(f.bsonType) ? f.bsonType : [f.bsonType];
      if (!bsonTypes.length || bsonTypes.some((type) => typeof type !== 'string' || !type.trim())) {
        throw new BadRequestException(`字段 ${f.key} 缺少 bsonType`);
      }
      spec.bsonType = bsonTypes.length === 1 ? bsonTypes[0] : bsonTypes;
    }
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

function toControllerClassName(value: string): string {
  const parts = value
    .replace(/([a-z0-9])([A-Z])/g, '$1 $2')
    .split(/[^a-zA-Z0-9]+/)
    .filter(Boolean)
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1).toLowerCase());

  const className = parts.join('');
  if (!className) {
    throw new BadRequestException('集合名无法生成有效控制器类名');
  }
  return /^\d/.test(className) ? `Generated${className}` : className;
}

function toControllerFileName(value: string): string {
  const fileName = value.trim();

  if (!fileName) {
    throw new BadRequestException('集合名无法生成有效文件名');
  }
  if (/[\\/:*?"<>|]/.test(fileName)) {
    throw new BadRequestException('控制器名称包含非法文件名字符');
  }
  return fileName;
}

function readControllerTemplate(): string {
  const templatePaths = [
    resolve(process.cwd(), 'src/app/admin/dev/databaseDesign/控制器模板'),
    resolve(__dirname, '控制器模板'),
  ];

  for (const templatePath of templatePaths) {
    if (existsSync(templatePath)) {
      return readFileSync(templatePath, 'utf8');
    }
  }

  throw new BadRequestException('未找到控制器模板文件');
}

function readFrontendTemplate(): string {
  const templatePaths = [
    resolve(process.cwd(), 'src/app/admin/dev/databaseDesign/前端页面模板'),
    resolve(__dirname, '前端页面模板'),
  ];
  for (const p of templatePaths) {
    if (existsSync(p)) return readFileSync(p, 'utf8');
  }
  throw new BadRequestException('未找到前端页面模板文件');
}

const ADMIN_PAGES_ROUTE_ROOT = '/src/pages';

function assertCrudGeneratorAvailable() {
  const nodeEnv = `${process.env.NODE_ENV ?? ''}`.trim().toLowerCase();
  const explicitEnabled = `${process.env.ENABLE_CRUD_GENERATOR ?? ''}`.trim().toLowerCase() === 'true';
  if (nodeEnv === 'production') {
    throw new BadRequestException('该功能仅开发环境可用');
  }
  if (nodeEnv !== 'development' && !explicitEnabled) {
    throw new BadRequestException('未开启 CRUD 生成器，请设置 ENABLE_CRUD_GENERATOR=true');
  }
}

function normalizeCrudPageRelativePath(pageDir: string): string {
  const normalized = `${pageDir ?? ''}`
    .split('/')
    .map((item) => item.trim())
    .filter(Boolean);
  if (!normalized.length) {
    throw new BadRequestException('页面相对路径不能为空');
  }
  if (normalized.some((item) => item === '.' || item === '..')) {
    throw new BadRequestException('页面相对路径不能包含 . 或 ..');
  }
  if (normalized.some((item) => /[\\:*?"<>|]/.test(item))) {
    throw new BadRequestException('页面相对路径包含非法字符');
  }
  return normalized
    .join('/');
}

function buildCrudComponentPath(
  pageDir: string,
): string {
  const relativePath = normalizeCrudPageRelativePath(pageDir);
  return `${ADMIN_PAGES_ROUTE_ROOT}/${relativePath}/index`;
}

function resolveAdminPagesDir(): string {
  return resolve(process.cwd(), 'template/admin/src/pages');
}

function resolveCrudPageFilePath(
  componentPath: string,
): string {
  const normalizedComponentPath = `${componentPath ?? ''}`
    .trim()
    .replace(/\\/g, '/')
    .replace(/\.vue$/i, '');

  if (!normalizedComponentPath.startsWith(`${ADMIN_PAGES_ROUTE_ROOT}/`)) {
    throw new BadRequestException('页面组件路径不在后台 pages 目录下');
  }

  const relativeComponentPath = normalizedComponentPath
    .slice(ADMIN_PAGES_ROUTE_ROOT.length)
    .replace(/^\/+/, '');
  if (!relativeComponentPath) {
    throw new BadRequestException('页面组件路径不能为空');
  }

  const pagesDir = resolveAdminPagesDir();
  const filePath = resolve(pagesDir, `${relativeComponentPath}.vue`);
  const relativeFilePath = relative(pagesDir, filePath).replace(/\\/g, '/');

  if (!relativeFilePath || relativeFilePath.startsWith('..')) {
    throw new BadRequestException('非法的页面输出路径');
  }

  return filePath;
}

function normalizeCrudMenuConfig(
  menuConfig: CrudMenuConfig | undefined,
  path: string,
): NormalizedCrudMenuConfig {
  const menu_id = menuConfig?.menu_id?.trim();
  const title = menuConfig?.title?.trim();
  if (!menu_id) {
    throw new BadRequestException('菜单标识不能为空');
  }
  if (!title) {
    throw new BadRequestException('菜单名称不能为空');
  }

  const parent_id = menuConfig?.parent_id?.trim();
  if (parent_id && parent_id === menu_id) {
    throw new BadRequestException('父级不能与本菜单的 menu_id 相同');
  }

  const sortValue = Number(menuConfig?.sort ?? 0);
  const normalizedPath = normalizeCrudPageRelativePath(path);
  const normalizedComponent = buildCrudComponentPath(normalizedPath);
  return {
    menu_id,
    title,
    icon: menuConfig?.icon?.trim() || undefined,
    sort: Number.isFinite(sortValue) ? sortValue : 0,
    parent_id: parent_id || undefined,
    enable: menuConfig?.enable !== false,
    comment: menuConfig?.comment?.trim() || undefined,
    path: normalizedPath,
    component: normalizedComponent,
  };
}

function objToJS(obj: Record<string, any>, baseIndent = 0): string {
  const raw = JSON.stringify(obj, null, 2);
  const cleaned = raw.replace(/"([a-zA-Z_$][a-zA-Z0-9_$]*)"\s*:/g, '$1: ');
  if (baseIndent <= 0) return cleaned;
  const indent = ' '.repeat(baseIndent);
  return cleaned.split('\n').map((line, i) => (i === 0 ? line : indent + line)).join('\n');
}

function buildTableColumnsStr(fields: CrudField[]): string {
  return fields.map((f) => {
    const title = f.title;
    return '    ' + objToJS({ key: f.key, type: 'text', title, width: 200 }, 4);
  }).join(',\n');
}

function buildQueryColumnsStr(fields: CrudField[]): string {
  return fields.map((f) => {
    const title = f.title;
    return '    ' + objToJS({ key: f.key, type: 'text', title, width: 200, mode: '=' }, 4);
  }).join(',\n');
}

function buildFormColumnObj(f: CrudField): Record<string, any> {
  const title = f.title;
  const col: Record<string, any> = { key: f.key, type: f.formType || 'text', title };
  const cfg = f.formConfig || {};
  switch (f.formType) {
    case 'select': case 'radio': case 'checkbox':
      if (cfg.data) col.data = cfg.data;
      if (cfg.placeholder) col.placeholder = cfg.placeholder;
      break;
    case 'switch':
      if (cfg.useCustomSwitchValue) {
        if (cfg.activeValue !== undefined && cfg.activeValue !== '') col.activeValue = cfg.activeValue;
        if (cfg.inactiveValue !== undefined && cfg.inactiveValue !== '') col.inactiveValue = cfg.inactiveValue;
      }
      break;
    case 'remote-select':
      if (cfg.action) col.action = cfg.action;
      if (cfg.placeholder) col.placeholder = cfg.placeholder;
      if (cfg.propsValue || cfg.propsLabel) {
        col.props = {
          ...(cfg.propsValue ? { value: cfg.propsValue } : {}),
          ...(cfg.propsLabel ? { label: cfg.propsLabel } : {}),
        };
      }
      break;
    case 'cascader':
    case 'tree-select':
      if (cfg.action) col.action = cfg.action;
      if (cfg.placeholder) col.placeholder = cfg.placeholder;
      if (cfg.propsList || cfg.propsValue || cfg.propsLabel || cfg.propsChildren || cfg.multiple !== undefined || cfg.lazy !== undefined) {
        col.props = {
          ...(cfg.propsList ? { list: cfg.propsList } : {}),
          ...(cfg.propsValue ? { value: cfg.propsValue } : {}),
          ...(cfg.propsLabel ? { label: cfg.propsLabel } : {}),
          ...(cfg.propsChildren ? { children: cfg.propsChildren } : {}),
          ...(cfg.multiple !== undefined ? { multiple: cfg.multiple } : {}),
          ...(cfg.lazy !== undefined ? { lazy: cfg.lazy } : {}),
        };
      }
      break;
    case 'table-select':
      if (cfg.action) col.action = cfg.action;
      if (cfg.columns) col.columns = cfg.columns;
      if (cfg.queryColumns) col.queryColumns = cfg.queryColumns;
      break;
    case 'number':
      if (cfg.step !== undefined) col.step = cfg.step;
      if (cfg.min !== undefined) col.min = cfg.min;
      if (cfg.max !== undefined) col.max = cfg.max;
      if (cfg.precision !== undefined) col.precision = cfg.precision;
      break;
  }
  return col;
}

function buildFormColumnsStr(fields: CrudField[]): string {
  return fields.map((f) => '      ' + objToJS(buildFormColumnObj(f), 6)).join(',\n');
}

function buildRulesStr(fields: CrudField[]): string {
  const requiredFields = fields.filter((f) => f.required);
  if (!requiredFields.length) return '';
  const entries = requiredFields.map((f) => {
    const title = f.formConfig?.placeholder || f.description || f.key;
    return `\n        ${f.key}: [\n          { required: true, message: "请输入${title}", trigger: "blur" }\n        ]`;
  });
  return entries.join(',') + '\n      ';
}

function renderTemplate(
  template: string,
  variables: Record<string, string>,
): string {
  let content = template;
  for (const [key, value] of Object.entries(variables)) {
    content = content.replaceAll(`\${${key}}`, value);
  }
  return content;
}

function extractAllowedFieldKeys(fields: SchemaField[] | undefined): string[] {
  if (!Array.isArray(fields)) {
    return [];
  }

  return [...new Set(
    fields
      .map((field) => field?.key?.trim())
      .filter((key): key is string => !!key && key !== '_id'),
  )];
}

function isValidIdentifier(value: string): boolean {
  return /^[A-Za-z_$][A-Za-z0-9_$]*$/.test(value);
}

function toSafeVariableName(value: string, usedNames: Set<string>): string {
  const normalized = value
    .replace(/[^A-Za-z0-9_$]+/g, '_')
    .replace(/^[^A-Za-z_$]+/, '');
  let candidate = normalized || 'fieldValue';
  while (usedNames.has(candidate)) {
    candidate = `${candidate}_1`;
  }
  usedNames.add(candidate);
  return candidate;
}

function buildUpdateFieldParts(fieldKeys: string[]) {
  const usedNames = new Set<string>(['_id']);
  const destructureParts: string[] = ['_id'];
  const objectParts: string[] = [];

  for (const key of fieldKeys) {
    if (isValidIdentifier(key)) {
      usedNames.add(key);
      destructureParts.push(key);
      objectParts.push(key);
      continue;
    }

    const variableName = toSafeVariableName(key, usedNames);
    const keyLiteral = JSON.stringify(key);
    destructureParts.push(`${keyLiteral}: ${variableName}`);
    objectParts.push(`${keyLiteral}: ${variableName}`);
  }

  return {
    destructureCode: `    const { ${destructureParts.join(', ')} } = data`,
    dataJsonCode: objectParts.map((part) => `        ${part},`).join('\n'),
  };
}

function buildAddFieldParts(fieldKeys: string[]) {
  const usedNames = new Set<string>();
  const destructureParts: string[] = [];
  const objectParts: string[] = [];

  for (const key of fieldKeys) {
    if (isValidIdentifier(key)) {
      usedNames.add(key);
      destructureParts.push(key);
      objectParts.push(key);
      continue;
    }

    const variableName = toSafeVariableName(key, usedNames);
    const keyLiteral = JSON.stringify(key);
    destructureParts.push(`${keyLiteral}: ${variableName}`);
    objectParts.push(`${keyLiteral}: ${variableName}`);
  }

  return {
    destructureCode: `    const { ${destructureParts.join(', ')} } = data`,
    dataJsonCode: objectParts.map((part) => `        ${part},`).join('\n'),
  };
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

function isSelectableRoute(path: string): boolean {
  return path.toLowerCase().includes('get');
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


@Controller()
export class DatabaseDesignController {
  constructor(
    @InjectConnection() private readonly connection: Connection,
    private readonly dbService: DbService,
    private readonly authService: AuthService,
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

  /**
   * 根据控制器模板生成 ZIP
   * ZIP 结构: {dirName}/{controllerName}/{controllerName}.controller.ts + index.vue
   * POST body: { dirName?, controllerName?, collectionName, tableName?, fields? }
   */
  @Post('/downloadController')
  async downloadController(
    @Body() body: DownloadControllerBody,
    @Res() res: Response,
  ) {
    const collectionName = (body.collectionName ?? body.tableName)?.trim();
    assertCollectionName(collectionName);

    const dir = toControllerFileName((body.dirName ?? collectionName).trim());
    const ctrl = toControllerFileName((body.controllerName ?? collectionName).trim());
    const fields: CrudField[] = Array.isArray(body.fields)
      ? body.fields.filter((f) => f?.key?.trim())
      : [];

    const template = readControllerTemplate();
    const controllerName = toControllerClassName(ctrl);
    const controllerFileName = `${toControllerFileName(ctrl)}.controller.ts`;
    const allowedFieldKeys = extractAllowedFieldKeys(fields);
    const updateParts = buildUpdateFieldParts(allowedFieldKeys);
    const addParts = buildAddFieldParts(allowedFieldKeys);
    const controllerContent = renderTemplate(template, {
      ControllerName: controllerName,
      collectionName: JSON.stringify(collectionName),
      addDestructureCode: addParts.destructureCode,
      addDataJsonCode: addParts.dataJsonCode,
      updateDestructureCode: updateParts.destructureCode,
      updateDataJsonCode: updateParts.dataJsonCode,
    });

    const frontendTemplate = readFrontendTemplate();
    const frontendContent = renderTemplate(frontendTemplate, {
      目录名称: dir,
      控制器名称: ctrl,
      表名: collectionName,
      传入表格字段: buildTableColumnsStr(fields),
      传入查询字段: buildQueryColumnsStr(fields),
      传入表单字段: buildFormColumnsStr(fields),
      传入校验规则: buildRulesStr(fields),
    });

    const zipFileName = `${dir}.zip`;
    res.setHeader('Content-Type', 'application/zip');
    res.setHeader(
      'Content-Disposition',
      `attachment; filename*=UTF-8''${encodeURIComponent(zipFileName)}`,
    );

    const archive = archiver('zip', { zlib: { level: 9 } });
    archive.pipe(res);
    archive.append(controllerContent, { name: `${dir}/${ctrl}/${controllerFileName}` });
    archive.append(frontendContent, { name: 'index.vue' });
    await archive.finalize();
  }

  /**
   * 生成 CRUD 全套代码并以 ZIP 下载
   * ZIP 结构: {dirName}/{controllerName}/{controllerName}.controller.ts + index.vue
   */
  @Post('/downloadCRUD')
  async downloadCRUD(
    @Body() body: DownloadCrudBody,
    @Res() res: Response,
  ) {
    const {
      dirName,
      controllerName: ctrlName,
      tableName,
      autoGenerateRoute,
      pageRelativePath,
      menuConfig,
    } = body;
    assertCrudGeneratorAvailable();
    if (!dirName?.trim()) throw new BadRequestException('目录名称不能为空');
    if (!ctrlName?.trim()) throw new BadRequestException('控制器名称不能为空');
    if (!tableName?.trim()) throw new BadRequestException('表名不能为空');

    const dir = dirName.trim();
    const ctrl = ctrlName.trim();
    const table = tableName.trim();
    const fields: CrudField[] = Array.isArray(body.fields)
      ? body.fields.filter((f) => f?.key?.trim())
      : [];

    // 1) 渲染后端控制器
    const controllerTemplate = readControllerTemplate();
    const className = toControllerClassName(ctrl);
    const controllerFileName = `${toControllerFileName(ctrl)}.controller.ts`;
    const allowedKeys = extractAllowedFieldKeys(fields);
    const updateParts = buildUpdateFieldParts(allowedKeys);
    const addParts = buildAddFieldParts(allowedKeys);
    const controllerContent = renderTemplate(controllerTemplate, {
      ControllerName: className,
      collectionName: JSON.stringify(table),
      addDestructureCode: addParts.destructureCode,
      addDataJsonCode: addParts.dataJsonCode,
      updateDestructureCode: updateParts.destructureCode,
      updateDataJsonCode: updateParts.dataJsonCode,
    });

    // 2) 渲染前端页面
    const frontendTemplate = readFrontendTemplate();
    const frontendContent = renderTemplate(frontendTemplate, {
      目录名称: dir,
      控制器名称: ctrl,
      表名: table,
      传入表格字段: buildTableColumnsStr(fields),
      传入查询字段: buildQueryColumnsStr(fields),
      传入表单字段: buildFormColumnsStr(fields),
      传入校验规则: buildRulesStr(fields),
    });

    if (autoGenerateRoute) {
      const routePath = normalizeCrudPageRelativePath(
        pageRelativePath?.trim() || `${dir}/${ctrl}`,
      );
      const normalizedMenu = normalizeCrudMenuConfig(
        menuConfig,
        routePath,
      );
      const pageFilePath = resolveCrudPageFilePath(normalizedMenu.component);

      if (existsSync(pageFilePath)) {
        throw new BadRequestException(`页面已存在: ${pageFilePath}`);
      }

      const existingMenu = await this.dbService.findByWhereJson({
        dbName: 'qa-menus',
        whereJson: { menu_id: normalizedMenu.menu_id },
      });
      if (existingMenu) {
        throw new BadRequestException(`菜单已存在: ${normalizedMenu.menu_id}`);
      }

      let menuInsertResult: InsertOneResult | null = null;
      let fileWritten = false;
      try {
        mkdirSync(dirname(pageFilePath), { recursive: true });
        writeFileSync(pageFilePath, frontendContent, 'utf8');
        fileWritten = true;

        menuInsertResult = await this.dbService.add({
          dbName: 'qa-menus',
          dataJson: {
            menu_id: normalizedMenu.menu_id,
            title: normalizedMenu.title,
            name: normalizedMenu.title,
            parent_id: normalizedMenu.parent_id,
            component: normalizedMenu.component,
            path: normalizedMenu.path,
            enable: normalizedMenu.enable,
            comment: normalizedMenu.comment,
            icon: normalizedMenu.icon,
            sort: normalizedMenu.sort,
          },
        });
        await this.authService.updateAuthVersion();
      } catch (error) {
        if (menuInsertResult?.insertedId) {
          try {
            await this.dbService.deleteById({
              dbName: 'qa-menus',
              id: `${menuInsertResult.insertedId}`,
            });
            await this.authService.updateAuthVersion();
          } catch {}
        }
        if (fileWritten && existsSync(pageFilePath)) {
          try {
            rmSync(pageFilePath, { force: true });
          } catch {}
        }
        throw error;
      }
    }

    // 3) 打包 ZIP
    const zipFileName = `${dir}.zip`;
    res.setHeader('Content-Type', 'application/zip');
    res.setHeader(
      'Content-Disposition',
      `attachment; filename*=UTF-8''${encodeURIComponent(zipFileName)}`,
    );

    const archive = archiver('zip', { zlib: { level: 9 } });
    archive.pipe(res);
    archive.append(controllerContent, { name: `${dir}/${ctrl}/${controllerFileName}` });
    archive.append(frontendContent, { name: 'index.vue' });
    await archive.finalize();
  }

  @Post('/getRouter')
  async getRoute(@Body() body: GetAdminRoutesBody = {}) {
    const adminDir = resolve(__dirname, '../..');
    const rootDir = resolve(adminDir, '../..');
    if (!existsSync(adminDir)) {
      throw new BadRequestException(`未找到 admin 目录: ${adminDir}`);
    }

    const keyword = body.keyword?.trim().toLowerCase();

    const routes: AdminRouteItem[] = [];
    const treeMap = new Map<string, AdminRouteTreeNode>();

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
      const file = relative(adminDir, filePath).replace(/\\/g, '/');
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
            /** 与权限校验一致：不含 Nest 的 globalPrefix（如 api） */
            path: joinRoutePath(controllerPath, methodPath),
            controller: controllerClass.name,
            file,
          };

          if (!isSelectableRoute(route.path)) {
            continue;
          }

          if (keyword) {
            const searchText =
              `${route.path} ${route.controller} ${route.file}`.toLowerCase();
            if (!searchText.includes(keyword)) {
              continue;
            }
          }

          routes.push(route);

          if (!treeMap.has(controllerClass.name)) {
            treeMap.set(controllerClass.name, {
              controller: controllerClass.name,
              controllerPath,
              file,
              routes: [],
            });
          }
          treeMap.get(controllerClass.name)!.routes.push(route);
        }
      }
    }

    routes.sort((a, b) => a.path.localeCompare(b.path));

    const tree = Array.from(treeMap.values()).sort((a, b) =>
      a.controllerPath.localeCompare(b.controllerPath),
    );

    return {
      ok: true,
      total: routes.length,
      list: routes,
      tree,
    };
  }
}
