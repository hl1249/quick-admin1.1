# AI 开发助手 - 使用指南

## 概述

AI 开发助手是一个集成到 quick-admin 项目的智能开发工具，通过 Alt+R 快捷键唤起聊天框，可以帮助你快速生成代码、创建模块、分析代码结构。

## 功能特性

### 1. 🎨 Vue 组件生成
- 自动生成标准的 Vue 3 组件
- 包含表格、分页、弹窗等常用功能
- 支持自定义字段和模板

### 2. 🗄️ 数据模型生成
- MongoDB Schema 定义
- TypeScript 接口定义
- 支持字段类型推断

### 3. 🔌 控制器生成
- RESTful API 控制器
- Service 服务层
- DTO 数据验证

### 4. 📦 完整模块创建
- 一键生成前后端完整代码
- 自动创建目录结构
- 统一的命名规范

## 快捷键

| 快捷键 | 功能 |
|--------|------|
| Alt+R | 打开/关闭 AI 聊天框 |
| Ctrl+Enter | 发送消息 |
| Esc | 关闭聊天框 |

## 使用方式

### 方式一：自然语言对话

直接在聊天框中描述你的需求：

```
创建一个用户管理页面，包含用户列表、搜索、添加、编辑、删除功能
```

```
生成一个订单数据表，包含订单号、用户、商品、金额、状态等字段
```

```
帮我创建商品管理的后端控制器和服务
```

### 方式二：使用快捷操作

聊天框提供快捷按钮：
- 📊 分析当前页面 - 分析页面代码结构
- ➕ 添加功能 - 在当前页面添加新功能
- 🗄️ 生成数据表 - 创建新的数据模型
- 🔧 生成控制器 - 创建后端控制器

### 方式三：直接调用 API

#### 1. 生成 Vue 组件

```bash
curl -X POST http://localhost:3000/mcp/generate \
  -H "Content-Type: application/json" \
  -d '{
    "type": "vue_component",
    "name": "product",
    "description": "商品管理页面",
    "fields": ["name", "price", "stock", "category"]
  }'
```

响应：
```json
{
  "success": true,
  "data": {
    "files": [
      {
        "path": "E:\\quick-admin1.1\\template\\admin\\src\\pages\\product\\index.vue",
        "type": "vue",
        "description": "Vue 组件: Product"
      }
    ],
    "message": "成功生成 1 个文件"
  }
}
```

#### 2. 生成数据模型

```bash
curl -X POST http://localhost:3000/mcp/generate \
  -H "Content-Type: application/json" \
  -d '{
    "type": "model",
    "name": "order",
    "description": "订单数据表",
    "fields": ["orderNo", "userId", "totalAmount", "status", "createdAt"]
  }'
```

响应：
```json
{
  "success": true,
  "data": {
    "files": [
      {
        "path": "E:\\quick-admin1.1\\src\\db\\order.schema.ts",
        "type": "schema",
        "description": "MongoDB Schema: Order"
      },
      {
        "path": "E:\\quick-admin1.1\\src\\db\\order.interface.ts",
        "type": "ts",
        "description": "接口定义: Order"
      }
    ],
    "message": "成功生成 2 个文件"
  }
}
```

#### 3. 生成控制器

```bash
curl -X POST http://localhost:3000/mcp/generate \
  -H "Content-Type: application/json" \
  -d '{
    "type": "controller",
    "name": "product",
    "description": "商品管理控制器"
  }'
```

响应：
```json
{
  "success": true,
  "data": {
    "files": [
      {
        "path": "E:\\quick-admin1.1\\src\\app\\product\\product.controller.ts",
        "type": "controller",
        "description": "控制器: ProductController"
      },
      {
        "path": "E:\\quick-admin1.1\\src\\app\\product\\product.service.ts",
        "type": "service",
        "description": "服务: ProductService"
      },
      {
        "path": "E:\\quick-admin1.1\\src\\app\\product\\dto\\product.dto.ts",
        "type": "ts",
        "description": "DTO: Product"
      }
    ],
    "message": "成功生成 3 个文件"
  }
}
```

#### 4. 创建完整模块

```bash
curl -X POST http://localhost:3000/mcp/module \
  -H "Content-Type: application/json" \
  -d '{
    "moduleName": "order",
    "description": "订单管理模块",
    "features": ["orderNo", "userId", "totalAmount", "status", "items"],
    "targetSide": "backend"
  }'
```

#### 5. 分析代码

```bash
curl "http://localhost:3000/mcp/analyze?path=E:\\quick-admin1.1\\src\\app\\user\\user.controller.ts"
```

响应：
```json
{
  "success": true,
  "data": {
    "path": "E:\\quick-admin1.1\\src\\app\\user\\user.controller.ts",
    "size": 1234,
    "lines": 45,
    "content": "...",
    "analysis": {
      "imports": 8,
      "functions": 6,
      "classes": 1,
      "components": 0,
      "linesOfCode": 45
    }
  }
}
```

## 生成的代码示例

### Vue 组件示例

生成的 Vue 组件包含：
- ✅ 表格展示（带分页）
- ✅ 新建/编辑弹窗
- ✅ 删除确认
- ✅ 加载状态
- ✅ 响应式布局

```vue
<template>
  <div class="product-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>商品管理页面</span>
          <el-button type="primary" @click="handleCreate">新建</el-button>
        </div>
      </template>

      <el-table :data="tableData" v-loading="loading">
        <el-table-column prop="_id" label="ID" width="220" />
        <el-table-column prop="name" label="name" />
        <el-table-column prop="price" label="price" />
        <!-- 更多字段... -->
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

    <!-- 编辑弹窗 -->
    <el-dialog v-model="dialogVisible" title="编辑" width="500px">
      <!-- 表单内容 -->
    </el-dialog>
  </div>
</template>
```

### MongoDB Schema 示例

```typescript
import { Schema } from 'mongoose';

export const OrderSchema = new Schema(
  {
    orderNo: { type: String, required: true },
    userId: { type: String, required: true },
    totalAmount: { type: Number, required: true },
    status: { type: String, required: true },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export const OrderModelName = 'Order';
```

### 控制器示例

```typescript
@Controller('product')
export class ProductController {
  constructor(private readonly productService: ProductService) {}

  @Get()
  async findAll(@Query() query: QueryProductDto) {
    return this.productService.findAll(query);
  }

  @Post()
  async create(@Body() createDto: CreateProductDto) {
    return this.productService.create(createDto);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDto: UpdateProductDto) {
    return this.productService.update(id, updateDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.productService.remove(id);
  }
}
```

## 系统提示词

AI 使用以下上下文来理解项目：

```
你是一个专业的全栈开发助手，正在帮助开发者快速开发 quick-admin 项目。
当前页面路径: /admin/dashboard
项目前端路径: E:\quick-admin1.1\template\admin\src
项目后端路径: E:\quick-admin1.1\src
前端使用 Vue 3 + TypeScript + Element Plus + Vite
后端使用 NestJS + MongoDB + TypeScript

你可以：
1. 修改或创建 Vue 组件 (.vue 文件)
2. 生成后端数据表 (MongoDB Schema)
3. 生成后端控制器和服务
4. 分析现有代码并提供优化建议
```

## 注意事项

### 1. 仅开发环境可用
AI 聊天框只在开发环境（`npm run dev`）中显示，生产环境自动隐藏。

### 2. 需要后端服务
确保后端服务已启动：
```bash
cd E:\quick-admin1.1
pnpm run start:dev
```

### 3. 文件覆盖
生成的文件会直接覆盖同名文件，请提前备份重要代码。

### 4. API Key
确保 `.env` 文件中配置了 DeepSeek API Key：
```env
DEEPSEEK_API_KEY=sk-xxxxxxxx
```

## 工作流程示例

### 示例1：创建用户管理模块

1. 打开前端项目，按 Alt+R
2. 输入："创建用户管理模块，包含用户名、邮箱、角色、状态字段"
3. AI 分析并生成：
   - 前端：`src/pages/user/index.vue`
   - 后端：`src/db/user.schema.ts`, `src/db/user.interface.ts`
   - 控制器：`src/app/user/user.controller.ts`, `src/app/user/user.service.ts`
4. 检查生成的代码，根据需要调整
5. 添加路由配置
6. 测试功能

### 示例2：添加搜索功能

1. 在当前页面，按 Alt+R
2. 输入："在当前页面添加按名称搜索的功能"
3. AI 分析当前页面代码
4. 生成搜索表单和逻辑
5. 使用工具修改文件
6. 刷新页面测试

## 技术架构

```
前端 (Vue 3)
├── AiChatBox.vue        # AI 聊天框组件
├── Alt+R 快捷键监听    # 全局键盘事件
└── HTTP 调用 MCP API    # 与后端通信

后端 (NestJS)
├── mcp.controller.ts    # MCP API 控制器
├── mcp.service.ts      # DeepSeek API 调用
├── code-generator.service.ts  # 代码生成服务
└── file.service.ts     # 文件操作服务
```

## 扩展开发

### 添加新的生成模板

编辑 `code-generator.service.ts`，添加新的生成方法：

```typescript
async generateCustomComponent(options: any): Promise<GeneratedFile[]> {
  // 自定义生成逻辑
}
```

### 自定义系统提示词

在前端 `AiChatBox.vue` 中修改 `getSystemPrompt()` 方法。

---

**提示**：这是一个开发辅助工具，生成的代码可能需要人工调整和优化。建议先在测试环境验证，再应用到生产环境。
