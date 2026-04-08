import { BadRequestException, Controller, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/db/db.service';

type SchemaFieldDoc = Record<string, any>

type SchemaDocBody = {
  _id?: string
  name?: string
  fields?: SchemaFieldDoc[]
  required?: string[]
  jsonSchema?: Record<string, unknown>
  fieldCount?: number
}

function normalizeSchemaName(name: unknown): string {
  const value = typeof name === 'string' ? name.trim() : ''
  if (!value) {
    throw new BadRequestException('Schema 名称不能为空')
  }
  return value
}

function normalizeSchemaPayload(data: SchemaDocBody) {
  const name = normalizeSchemaName(data.name)
  const fields = Array.isArray(data.fields) ? data.fields : []
  const required = Array.isArray(data.required)
    ? data.required.filter((item): item is string => typeof item === 'string' && !!item.trim())
    : []
  const jsonSchema = data.jsonSchema && typeof data.jsonSchema === 'object' && !Array.isArray(data.jsonSchema)
    ? data.jsonSchema
    : { bsonType: 'object', properties: {} }

  return {
    name,
    fields,
    required,
    jsonSchema,
    fieldCount: typeof data.fieldCount === 'number'
      ? data.fieldCount
      : fields.filter((field) => typeof field?.key === 'string' && field.key.trim()).length,
    _update_time: Date.now(),
  }
}

@Controller()
export class SchemasController {
  constructor(
    private readonly dbService: DbService,
  ) {
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {
    const payload = normalizeSchemaPayload(data)
    return this.dbService.add({
      dbName: "qa-schemas",
      dataJson: payload
    })
  }

  @Post('/delete')
  delete(@Body() data): Promise<Document | null> {
    return this.dbService.deleteById({
      dbName: "qa-schemas",
      id: data._id
    })
  }

  @Post('/update')
  update(@Body() data): Promise<Document | null> {
    if (!data?._id) {
      throw new BadRequestException('缺少 schema id')
    }

    const { _id } = data
    const payload = normalizeSchemaPayload(data)
    return this.dbService.updateById({
      id: _id,
      dbName: "qa-schemas",
      dataJson: payload
    })
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.getTableData({
      dbName: "qa-schemas",
      data
    })
  }
}