import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as fs from 'fs/promises';
import * as path from 'path';

export interface GeneratedFile {
  path: string;
  content: string;
  type: 'vue' | 'ts' | 'schema' | 'controller' | 'service';
  description?: string;
}

@Injectable()
export class CodeGeneratorService {
  private readonly frontendBase = 'E:\\quick-admin1.1\\template\\admin\\src';
  private readonly backendBase = 'E:\\quick-admin1.1\\src';

  constructor(private configService: ConfigService) {}

  /**
   * 生成 Vue 组件
   */
  async generateVueComponent(options: {
    name: string;
    description?: string;
    fields?: string[];
    template?: string;
  }): Promise<GeneratedFile[]> {
    const { name, description, fields = [], template } = options;
    const componentName = this.toPascalCase(name);
    const fileName = this.toKebabCase(name);

    let content = '';

    if (template) {
      content = template;
    } else {
      content = this.getDefaultVueTemplate(componentName, description, fields);
    }

    const filePath = path.join(this.frontendBase, 'pages', fileName, 'index.vue');

    return [
      {
        path: filePath,
        content,
        type: 'vue',
        description: `Vue 组件: ${componentName}`,
      },
    ];
  }

  /**
   * 生成 MongoDB Schema
   */
  async generateModel(options: {
    name: string;
    fields?: string[];
    description?: string;
  }): Promise<GeneratedFile[]> {
    const { name, fields = [], description } = options;
    const modelName = this.toPascalCase(name);
    const fileName = this.toKebabCase(name);

    const schemaContent = this.getSchemaTemplate(modelName, fields, description);
    const interfaceContent = this.getInterfaceTemplate(modelName, fields);

    return [
      {
        path: path.join(this.backendBase, 'db', `${fileName}.schema.ts`),
        content: schemaContent,
        type: 'schema',
        description: `MongoDB Schema: ${modelName}`,
      },
      {
        path: path.join(this.backendBase, 'db', `${fileName}.interface.ts`),
        content: interfaceContent,
        type: 'ts',
        description: `接口定义: ${modelName}`,
      },
    ];
  }

  /**
   * 生成控制器
   */
  async generateController(options: {
    name: string;
    description?: string;
  }): Promise<GeneratedFile[]> {
    const { name, description } = options;
    const controllerName = this.toPascalCase(name);
    const fileName = this.toKebabCase(name);

    const controllerContent = this.getControllerTemplate(controllerName, description);
    const serviceContent = this.getServiceTemplate(controllerName, description);
    const dtoContent = this.getDtoTemplate(controllerName);

    return [
      {
        path: path.join(this.backendBase, 'app', fileName, `${fileName}.controller.ts`),
        content: controllerContent,
        type: 'controller',
        description: `控制器: ${controllerName}Controller`,
      },
      {
        path: path.join(this.backendBase, 'app', fileName, `${fileName}.service.ts`),
        content: serviceContent,
        type: 'service',
        description: `服务: ${controllerName}Service`,
      },
      {
        path: path.join(this.backendBase, 'app', fileName, `dto`, `${fileName}.dto.ts`),
        content: dtoContent,
        type: 'ts',
        description: `DTO: ${controllerName}`,
      },
    ];
  }

  /**
   * 写入文件
   */
  async writeFiles(files: GeneratedFile[]): Promise<void> {
    for (const file of files) {
      await fs.mkdir(path.dirname(file.path), { recursive: true });
      await fs.writeFile(file.path, file.content, 'utf-8');
    }
  }

  /**
   * 分析代码结构
   */
  async analyzeCode(filePath: string): Promise<any> {
    const fullPath = filePath.startsWith('E:') ? filePath : path.join(this.frontendBase, filePath);

    try {
      const stats = await fs.stat(fullPath);
      const content = await fs.readFile(fullPath, 'utf-8');

      return {
        path: fullPath,
        size: stats.size,
        lines: content.split('\n').length,
        content,
        analysis: this.performBasicAnalysis(content),
      };
    } catch (error) {
      throw new Error(`无法读取文件: ${filePath}`);
    }
  }

  // Private helper methods

  private toPascalCase(str: string): string {
    return str
      .split(/[-_\s]+/)
      .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
      .join('');
  }

  private toKebabCase(str: string): string {
    return str
      .replace(/([a-z])([A-Z])/g, '$1-$2')
      .replace(/\s+/g, '-')
      .toLowerCase();
  }

  private getDefaultVueTemplate(name: string, description?: string, fields: string[] = []): string {
    const fieldsTemplate = fields.map(f => `    <el-form-item label="${f}">\n      <el-input v-model="form.${f}" />\n    </el-form-item>`).join('\n');

    return `<template>
  <div class="${this.toKebabCase(name)}-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>${description || name}</span>
          <el-button type="primary" @click="handleCreate">新建</el-button>
        </div>
      </template>

      <el-table :data="tableData" v-loading="loading">
        <el-table-column prop="_id" label="ID" width="220" />
${fields.map(f => `        <el-table-column prop="${f}" label="${f}" />`).join('\n')}
        <el-table-column label="操作" width="180">
          <template #default="{ row }">
            <el-button size="small" @click="handleEdit(row)">编辑</el-button>
            <el-button size="small" type="danger" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :total="total"
        layout="total, sizes, prev, pager, next"
        @change="fetchData"
      />
    </el-card>

    <!-- Dialog -->
    <el-dialog v-model="dialogVisible" title="编辑" width="500px">
      <el-form :model="form" label-width="100px">
${fieldsTemplate}
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'

const loading = ref(false)
const tableData = ref([])
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const dialogVisible = ref(false)
const form = ref({})

const fetchData = async () => {
  loading.value = true
  try {
    // TODO: 调用 API
  } finally {
    loading.value = false
  }
}

const handleCreate = () => {
  form.value = {}
  dialogVisible.value = true
}

const handleEdit = (row: any) => {
  form.value = { ...row }
  dialogVisible.value = true
}

const handleDelete = async (row: any) => {
  await ElMessageBox.confirm('确定删除？', '提示', { type: 'warning' })
  // TODO: 调用删除 API
  ElMessage.success('删除成功')
  fetchData()
}

const handleSubmit = async () => {
  // TODO: 调用提交 API
  ElMessage.success('操作成功')
  dialogVisible.value = false
  fetchData()
}

onMounted(() => {
  fetchData()
})
</script>

<style lang="scss" scoped>
.${this.toKebabCase(name)}-container {
  padding: 20px;

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
}
</style>
`;
  }

  private getSchemaTemplate(name: string, fields: string[], description?: string): string {
    const fieldsDef = fields.map(f => `  ${f}: { type: ${this.inferSchemaType(f)}, required: true },`).join('\n');

    return `import { Schema } from 'mongoose';

/**
 * ${description || name} Schema
 */
export const ${name}Schema = new Schema(
  {
${fieldsDef}
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export const ${name}ModelName = '${name}';
`;
  }

  private getInterfaceTemplate(name: string, fields: string[]): string {
    const fieldsDef = fields.map(f => `  ${f}: ${this.inferTsType(f)};`).join('\n');

    return `export interface ${name} {
  _id: string;
${fieldsDef}
  createdAt: Date;
  updatedAt: Date;
}
`;
  }

  private getControllerTemplate(name: string, description?: string): string {
    return `import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
} from '@nestjs/common';
import { ${name}Service } from './${this.toKebabCase(name)}.service';
import { Create${name}Dto, Update${name}Dto, Query${name}Dto } from './dto/${this.toKebabCase(name)}.dto';

@Controller('${this.toKebabCase(name)}')
export class ${name}Controller {
  constructor(private readonly ${this.toCamelCase(name)}Service: ${name}Service) {}

  @Get()
  async findAll(@Query() query: Query${name}Dto) {
    return this.${this.toCamelCase(name)}Service.findAll(query);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.${this.toCamelCase(name)}Service.findOne(id);
  }

  @Post()
  async create(@Body() createDto: Create${name}Dto) {
    return this.${this.toCamelCase(name)}Service.create(createDto);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDto: Update${name}Dto) {
    return this.${this.toCamelCase(name)}Service.update(id, updateDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.${this.toCamelCase(name)}Service.remove(id);
  }
}
`;
  }

  private getServiceTemplate(name: string, description?: string): string {
    return `import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ${name}, ${name}Document } from '@/db/${this.toKebabCase(name)}.interface';
import { ${name}ModelName } from '@/db/${this.toKebabCase(name)}.schema';
import { Create${name}Dto, Update${name}Dto, Query${name}Dto } from './dto/${this.toKebabCase(name)}.dto';

@Injectable()
export class ${name}Service {
  constructor(
    @InjectModel(${name}ModelName)
    private ${this.toCamelCase(name)}Model: Model<${name}Document>
  ) {}

  async findAll(query: Query${name}Dto) {
    const { page = 1, pageSize = 10 } = query;
    const skip = (page - 1) * pageSize;
    
    const [items, total] = await Promise.all([
      this.${this.toCamelCase(name)}Model.find().skip(skip).limit(pageSize).exec(),
      this.${this.toCamelCase(name)}Model.countDocuments().exec(),
    ]);

    return {
      items,
      total,
      page,
      pageSize,
    };
  }

  async findOne(id: string): Promise<${name} | null> {
    return this.${this.toCamelCase(name)}Model.findById(id).exec();
  }

  async create(createDto: Create${name}Dto): Promise<${name}> {
    const created = new this.${this.toCamelCase(name)}Model(createDto);
    return created.save();
  }

  async update(id: string, updateDto: Update${name}Dto): Promise<${name} | null> {
    return this.${this.toCamelCase(name)}Model.findByIdAndUpdate(id, updateDto, { new: true }).exec();
  }

  async remove(id: string): Promise<${name} | null> {
    return this.${this.toCamelCase(name)}Model.findByIdAndDelete(id).exec();
  }
}
`;
  }

  private getDtoTemplate(name: string): string {
    return `import { IsString, IsOptional, IsNumber, Min } from 'class-validator';

export class Create${name}Dto {
  // TODO: 添加字段验证
}

export class Update${name}Dto {
  @IsOptional()
  // TODO: 添加字段验证
}

export class Query${name}Dto {
  @IsOptional()
  @IsNumber()
  @Min(1)
  page?: number = 1;

  @IsOptional()
  @IsNumber()
  @Min(1)
  pageSize?: number = 10;
}
`;
  }

  private inferSchemaType(field: string): string {
    const lowerField = field.toLowerCase();
    if (lowerField.includes('email')) return 'String';
    if (lowerField.includes('phone')) return 'String';
    if (lowerField.includes('age')) return 'Number';
    if (lowerField.includes('price')) return 'Number';
    if (lowerField.includes('count')) return 'Number';
    if (lowerField.includes('date')) return 'Date';
    if (lowerField.includes('time')) return 'Date';
    return 'String';
  }

  private inferTsType(field: string): string {
    const lowerField = field.toLowerCase();
    if (lowerField.includes('age')) return 'number';
    if (lowerField.includes('price')) return 'number';
    if (lowerField.includes('count')) return 'number';
    if (lowerField.includes('date')) return 'Date';
    if (lowerField.includes('time')) return 'Date';
    return 'string';
  }

  private performBasicAnalysis(content: string): any {
    return {
      imports: (content.match(/^import .+$/gm) || []).length,
      functions: (content.match(/function\s+\w+/g) || []).length,
      classes: (content.match(/class\s+\w+/g) || []).length,
      components: (content.match(/@Component|defineComponent/g) || []).length,
      linesOfCode: content.split('\n').length,
    };
  }

  private toCamelCase(str: string): string {
    const pascal = this.toPascalCase(str);
    return pascal.charAt(0).toLowerCase() + pascal.slice(1);
  }
}
