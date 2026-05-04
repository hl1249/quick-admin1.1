<p align="center">
  <img style="margin: auto" src="https://gitee.com/hr1249412130/quick-admin/raw/master/logo.png" width="250" alt="Quick Admin Logo" />
</p>

<h1 align="center">Quick Admin</h1>

<p align="center">
  基于 NestJS + MongoDB 的前后端分离快速开发框架
</p>

---

## 📝 介绍

**Quick Admin** 是一款基于 **NestJS + MongoDB** 的全栈快速开发框架，内置封装的 `DbService` 类，大幅简化 MongoDB 数据库操作。旨在帮助开发者专注于业务逻辑，快速搭建前后端分离项目。

---

## ✨ 核心特性

| 特性 | 说明 |
|------|------|
| 📦 快速开发 | 基于 NestJS + MongoDB，开箱即用 |
| 🗄️ DbService | 封装增删改查，告别繁琐原生操作 |
| 🔐 鉴权体系 | JWT 鉴权 + 权限校验，安全可靠 |
| 📡 统一响应 | 统一的响应格式与异常过滤处理 |
| 📋 日志拦截 | 内置请求日志拦截，便于追踪调试 |
| 🛠️ 工具函数 | 提供丰富的业务工具函数 |
| 🔄 动态路由 | 动态生成路由配置，灵活扩展 |
| 💾 缓存支持 | 支持 Redis / 内存缓存双模式 |

---

## 📁 项目结构

### 服务端（quick）

```
quick/
├── src/
│   ├── main.ts                 # 应用入口
│   ├── app.module.ts           # 根模块
│   ├── app.controller.ts       # 根控制器
│   ├── app.service.ts          # 根服务
│   ├── public.module.ts        # 共享注入模块
│   ├── load-env.ts             # 环境变量加载
│   ├── config/                 # 配置文件
│   ├── app/
│   │   ├── admin/              # 后台接口模块
│   │   └── client/             # 客户端接口模块
│   └── common/
│       ├── auth/               # 鉴权守卫
│       ├── cache/              # 缓存模块（Redis / 内存缓存）
│       ├── exception/          # 全局异常过滤
│       ├── jwt/                # JWT 工具类
│       ├── logger/             # 请求日志拦截
│       ├── oss/                # OSS 对象存储
│       ├── response/           # 统一响应格式
│       ├── upload/             # 文件上传
│       ├── utils/              # 工具类（含 DbService）
│       └── validation/         # 字段验证器
├── db/
│   └── quickAdmin.sql          # 数据库初始化文件
├── deploy/                     # 部署相关脚本
├── scripts/                    # 辅助脚本
├── uploads/                    # 本地上传文件目录
├── .env                        # 环境变量
└── .env.example                # 环境变量模板
```

### 前台模板（template）

```
template/
├── src/
│   ├── main.ts                 # 应用入口
│   ├── App.vue                 # 根组件
│   ├── api/                    # 接口层
│   ├── assets/                 # 静态资源
│   ├── components/             # 全局组件
│   ├── config/                 # 配置文件
│   ├── layout/                 # 左右布局
│   ├── pages/                  # 页面
│   ├── router/                 # 路由配置
│   ├── store/                  # 状态管理
│   ├── style/                  # 全局样式
│   └── utils/                  # 工具类
```

---

## 🚀 快速开始

### 第一步：安装 MongoDB

下载并安装 [MongoDB 8.0](https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-8.0.3-signed.msi)，确保 MongoDB 服务已启动。

### 第二步：启动服务端

```bash
# 安装依赖
pnpm install

# 开发模式
npm run start

# 开发模式（热重载 + 日志监听）
npm run start:dev

# 生产模式
npm run start:prod
```

### 第三步：初始化数据库

服务端启动后，浏览器访问 [http://localhost:3000/setup/index.html](http://localhost:3000/setup/index.html)，按页面提示完成数据库初始化。

### 第四步：启动前台

```bash
# 安装依赖
pnpm install

# 开发模式
npm run dev

# 构建生产包
npm run build

# 生产预览
npm run preview
```

---

## 🗄️ DbService 使用指南

`DbService` 是本框架的核心，注入即用，无需手写繁琐的 MongoDB 原生语句。

### 注入方式

```typescript
import { DbService } from '@/common/db/db.service';

@Injectable()
export class UserService {
  constructor(private readonly db: DbService) {}
}
```

---

### ➕ 新增（Insert）

**示例一：新增单条用户记录**

```typescript
// 新增一个用户，自动附加 _add_time 和 _add_time_str 字段
const result = await this.db.add({
  dbName: 'user',
  dataJson: {
    name: '张三',
    age: 25,
    role: 'admin',
    status: 1,
  },
});
// result.insertedId 为新插入文档的 _id
```

**示例二：批量新增商品记录**

```typescript
// 批量插入多条商品数据
const result = await this.db.adds({
  dbName: 'product',
  dataJson: [
    { name: '苹果手机', price: 5999, stock: 100 },
    { name: '华为平板', price: 3299, stock: 50 },
    { name: '小米耳机', price: 299,  stock: 200 },
  ],
});
// result.insertedCount 为成功插入的文档数量
```

---

### 🗑️ 删除（Delete）

**示例一：根据 ID 删除指定用户**

```typescript
// 通过文档 _id 精准删除单条记录
const result = await this.db.deleteById({
  dbName: 'user',
  id: '665f1a2b3c4d5e6f7a8b9c0d',
});
// result.deletedCount 为实际删除的文档数
```

**示例二：按条件批量删除已禁用用户**

```typescript
// 删除所有 status 为 0（禁用状态）的用户
const result = await this.db.del({
  dbName: 'user',
  whereJson: {
    status: 0,
  },
});
```

---

### ✏️ 修改（Update）

**示例一：根据 ID 更新用户信息**

```typescript
// 通过 _id 更新指定用户的昵称和年龄
const result = await this.db.updateById({
  dbName: 'user',
  id: '665f1a2b3c4d5e6f7a8b9c0d',
  dataJson: {
    $set: {
      name: '李四',
      age: 30,
    },
  },
});
```

**示例二：按条件批量更新商品状态**

```typescript
// 将所有库存为 0 的商品状态改为下架（status: 2）
const result = await this.db.update({
  dbName: 'product',
  whereJson: { stock: 0 },
  dataJson: {
    $set: { status: 2 },
  },
});
```

---

### 🔍 查询（Select）

**示例一：分页查询用户列表（带条件 + 排序）**

```typescript
// 查询 status=1 的用户，按创建时间倒序，第1页每页10条，并返回总数
const result = await this.db.select({
  dbName: 'user',
  whereJson: { status: 1 },
  pageIndex: 1,
  pageSize: 10,
  getCount: true,
  sortArr: [{ name: '_add_time', type: 'desc' }],
  fieldJson: { password: 0 },   // 排除敏感字段
});

// result.rows     → 当前页数据列表
// result.total    → 总记录数
// result.hasMore  → 是否还有下一页
```

**示例二：联表查询订单详情（关联商品信息）**

```typescript
// 查询订单列表，并通过 $lookup 关联 product 集合获取商品详情
const result = await this.db.selects({
  dbName: 'order',
  whereJson: { userId: '665f1a2b3c4d5e6f7a8b9c0d' },
  foreignDB: [
    {
      $lookup: {
        from: 'product',
        localField: 'productId',
        foreignField: '_id',
        as: 'productInfo',
      },
    },
    { $unwind: { path: '$productInfo', preserveNullAndEmptyArrays: true } },
  ],
  pageIndex: 1,
  pageSize: 10,
  getCount: true,
  sortArr: [{ name: '_add_time', type: 'desc' }],
});
```

---

## 📊 DbService API 一览

| 方法 | 说明 |
|------|------|
| `add()` | 新增单条文档，自动附加时间戳 |
| `adds()` | 批量新增文档 |
| `del()` | 按条件批量删除文档 |
| `deleteById()` | 按 `_id` 删除文档 |
| `update()` | 按条件批量更新文档 |
| `updateById()` | 按 `_id` 更新文档 |
| `updateAndReturn()` | 更新并返回更新后的文档 |
| `setById()` | 按 `_id` 更新（不存在则插入） |
| `select()` | 普通分页查询 |
| `selects()` | 聚合分页查询（支持联表） |
| `getTableData()` | 列表查询（默认携带总数） |
| `findById()` | 按 `_id` 查询单条文档 |
| `findByWhereJson()` | 按条件查询单条文档 |
| `count()` | 统计数量 |
| `sum()` | 字段求和 |
| `max()` | 字段最大值 |
| `min()` | 字段最小值 |
| `avg()` | 字段平均值 |
| `sample()` | 随机抽样查询 |

---

## 🧩 管理后台组件使用指南

以下示例来自 `template/admin/src/pages/template/table/index.vue`，用于说明管理后台中 `qa-table` 表格和 `qa-form` 表单的常见配置方式。

### qa-table

`qa-table` 对应组件为 `qa-data-table`，用于快速渲染后台数据表格，支持接口请求、分页、序号列、多选/单选、操作按钮、自定义右侧按钮、详情弹窗和多种字段展示类型。

#### props 配置属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `action` | `string` | - | 列表接口地址，组件会根据接口请求表格数据。 |
| `columns` | `Columns[]` | - | 表格列配置，决定字段、标题、展示类型、宽度等。 |
| `queryFormParam` | `Record<string, any>` | - | 查询表单参数，通常传入 `qa-table-query` 使用的对象。 |
| `rightBtns` | `('detail_auto' \| 'update' \| 'delete' \| 'more')[]` | - | 右侧内置操作按钮：详情、编辑、删除、更多。 |
| `rightBtnsMore` | `RightBtnMoreItem[]` | - | 更多按钮下拉菜单配置。 |
| `customRightBtns` | `CustomRightBtn[]` | - | 自定义右侧操作按钮。 |
| `rowNo` | `boolean` | `false` | 是否显示序号列。 |
| `rowKey` | `string` | `_id` | 表格行唯一键。 |
| `selection` | `boolean` | `false` | 是否显示选择列。 |
| `multiple` | `boolean` | `true` | 是否多选；为 `false` 时为单选。 |
| `selectionData` | `TableRow[] \| TableRow \| string[] \| number[] \| string \| number \| null` | - | 默认选中数据，用于回显。 |
| `renderNode` | `'detail' \| 'row'` | `row` | 字段渲染位置。 |
| `height` | `string \| number` | `100%` | 表格高度。 |
| `border` | `boolean` | - | 是否显示边框。 |
| `highlightCurrentRow` | `boolean` | - | 是否高亮当前行。 |
| `size` | `'' \| 'large' \| 'default' \| 'small'` | - | 表格尺寸。 |
| `selectable` | `(row, index) => boolean` | - | 控制某一行是否可选。 |
| `stripe` | `boolean` | - | 是否显示斑马纹。 |
| `pagination` | `boolean` | - | 是否启用分页，示例中使用 `:pagination="false"` 关闭分页。 |

常用事件：

| 事件 | 说明 |
|------|------|
| `selection-change` | 选择项变化时触发。 |
| `update` | 点击内置编辑按钮时触发。 |
| `delete` | 点击内置删除按钮确认后触发。 |
| `current-change` | 当前行变化时触发。 |
| `row-click` / `row-dblclick` | 行点击 / 双击时触发。 |
| `pagination-change` | 分页变化时触发。 |

基础示例：

```vue
<qa-data-table
  ref="qaTableRef"
  :action="table.action"
  :columns="table.columns"
  :query-form-param="queryForm"
  :pagination="false"
  :right-btns="['detail_auto', 'update', 'delete', 'more']"
  :right-btns-more="table.rightBtnsMore"
  :row-no="true"
  selection
  highlight-current-row
  @selection-change="selectionChange"
  @update="updateBtn"
  @delete="deleteBtn"
  @current-change="currentChange"
/>
```

列配置示例：

```typescript
const table = ref({
  action: '/app/admin/system/systemUser/systemUser/getList',
  columns: [
    { key: 'username', title: '用户名', type: 'text' },
    { key: 'avatar', title: '头像', type: 'avatar', shape: 'circle' },
    { key: 'image', title: '图像', type: 'image' },
    { key: 'is_login', title: '允许登陆', type: 'switch', width: 200 },
    { key: 'rate', title: '评分', type: 'rate', width: 200 },
    {
      key: 'username',
      title: '用户类型',
      type: 'tag',
      data: [
        { value: 'admin', label: '管理员', tagType: 'success' },
        { value: 'agent', label: '代理', tagType: 'danger' },
      ],
    },
  ],
  rightBtnsMore: [
    {
      title: '按钮1',
      disabled: () => false,
      onClick: (row) => console.log(row),
    },
  ],
})
```

#### type 有哪些类型

`qa-table` 的 `columns[].type` 支持以下类型：

| type | 说明 | 常用配置 |
|------|------|----------|
| `text` | 普通文本 | `formatter`、`width` |
| `radio` | 单选展示 | `data` |
| `select` | 下拉选项展示 | `data` |
| `checkbox` | 多选展示 | `data` |
| `json` | JSON 内容展示 | - |
| `image` | 图片展示 | `imageWidth` |
| `avatar` | 头像展示 | `shape` |
| `rate` | 评分展示 | `size` |
| `switch` | 开关展示 | `activeValue`、`inactiveValue` |
| `icon` | 图标展示 | `data.icon` |
| `tag` | 标签展示 | `data.tagType` |
| `time` | 时间展示 | `valueFormat` |
| `object` | 对象字段展示 | `columns` |
| `html` | HTML 内容展示 | - |
| `money` | 金额展示 | - |
| `percentage` | 百分比展示 | - |
| `address` | 地址展示 | - |
| `userInfo` | 用户信息展示 | - |
| `group` | 表头分组 | `columns` |
| `table` | 嵌套表格展示 | `columns` |

分组、对象列示例：

```typescript
const columns = [
  {
    key: '',
    title: '分组',
    type: 'group',
    columns: [
      {
        key: 'userInfo',
        title: '用户',
        type: 'object',
        columns: [
          { key: 'name', title: '姓名', type: 'text' },
          { key: 'age', title: '年龄', type: 'text' },
        ],
      },
      { key: 'last_login_date', title: '添加时间', type: 'money' },
    ],
  },
]
```

### qa-form

`qa-form` 用于快速生成新增、编辑、查询等表单。它通过 `v-model` 绑定表单数据，通过 `columns` 配置表单项，通过 `rules` 配置 Element Plus 表单校验，并支持提交前预处理和提交成功回调。

#### props 配置属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `modelValue` | `any` | - | 表单数据，使用 `v-model` 双向绑定。 |
| `rules` | `any` | - | 表单校验规则，兼容 Element Plus `el-form` rules。 |
| `action` | `string \| ({ data }) => void` | - | 提交地址或自定义提交函数。字符串时会以 POST 请求提交。 |
| `formType` | `string` | - | 表单模式，常用 `add`、`edit`、`query`，可配合列的 `show` 控制显示。 |
| `columns` | `QaFormColumns[]` | - | 表单项配置数组。 |
| `labelWidth` | `string \| number` | - | 表单项标签宽度。 |
| `beforeAction` | `(value) => boolean \| void \| any` | - | 提交前预处理；返回 `false` 会阻止提交，返回对象会作为提交数据。 |
| `cancelText` | `string` | `取消` | 取消按钮文本。 |
| `submitText` | `string` | `确认` | 提交按钮文本。 |
| `data` | `any` | - | 扩展数据。 |

表单列常用配置：

| 字段 | 说明 |
|------|------|
| `key` | 绑定字段名，支持点路径。 |
| `title` | 表单项标题。 |
| `type` | 表单项类型。 |
| `width` | 表单控件宽度。 |
| `labelWidth` | 当前表单项标签宽度。 |
| `placeholder` | 占位提示。 |
| `show` | 根据 `formType` 控制显示，如 `['add', 'edit']`。 |
| `showRule` | 动态显示规则，支持函数或简单字符串表达式。 |
| `disabled` | 动态禁用规则，支持函数或简单字符串表达式。 |
| `data` | 选项数据，适用于 `radio`、`checkbox`、`select` 等。 |
| `props` | 透传给内部组件的扩展配置。 |
| `rules` | 单个表单项校验规则。 |
| `tips` | 表单项底部提示文本。 |
| `watch` | 当前字段值变化监听。 |

基础示例：

```vue
<qa-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
  <qa-form
    ref="formRefs"
    v-model="form.data"
    :rules="form.props.rules"
    :action="form.props.action"
    :form-type="form.props.formType"
    :columns="form.props.columns"
    label-width="80px"
    :before-action="form.props.beforeAction"
    @success="() => { form.props.show = false; refresh() }"
    @closeForm="form.props.show = false"
  />
</qa-dialog>
```

配置示例：

```typescript
const form = ref({
  data: {
    username: '',
    nickname: '',
    password: '',
    avatar: '',
    is_login: false,
    rate: 0,
    last_login_date: '',
  },
  props: {
    beforeAction: (formData) => true,
    action: '/app/admin/system/systemUser/systemUser/add',
    formType: 'add',
    columns: [
      { key: 'username', title: '用户名', type: 'text', width: 250, show: ['add'] },
      { key: 'nickname', title: '昵称', type: 'text', width: 250, show: ['add', 'edit'] },
      { key: 'password', title: '密码', type: 'password', width: 250, show: ['add'] },
      { key: 'image', title: '头像', type: 'file-select', width: 250, placeholder: '图片' },
      { key: 'userInfo', title: 'JSON 类型', type: 'json' },
      { key: 'is_login', title: '允许登陆', type: 'switch', width: 250 },
      { key: 'rate', title: '评分', type: 'rate', width: 250 },
      {
        key: 'last_login_date',
        title: '添加时间',
        type: 'date',
        dateType: 'datetime',
        valueFormat: 'x',
        format: 'YYYY-MM-DD HH:mm:ss',
        width: 250,
      },
    ],
    rules: {
      username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
      nickname: [{ required: true, message: '请输入昵称', trigger: 'blur' }],
    },
    title: '添加',
    show: true,
  },
})
```

#### type 类型举例

`qa-form` 的 `columns[].type` 支持以下常用类型：

| type | 说明 | 示例配置 |
|------|------|----------|
| `text` | 普通输入框 | `{ key: 'username', title: '用户名', type: 'text' }` |
| `number` | 数字输入框 | `{ key: 'sort', title: '排序', type: 'number' }` |
| `password` | 密码输入框 | `{ key: 'password', title: '密码', type: 'password' }` |
| `textarea` | 多行文本 | `{ key: 'remark', title: '备注', type: 'textarea' }` |
| `switch` | 开关 | `{ key: 'status', title: '状态', type: 'switch' }` |
| `rate` | 评分 | `{ key: 'rate', title: '评分', type: 'rate' }` |
| `color` | 颜色选择器 | `{ key: 'color', title: '颜色', type: 'color' }` |
| `slider` | 滑块 | `{ key: 'progress', title: '进度', type: 'slider' }` |
| `radio` | 单选 | `{ key: 'gender', title: '性别', type: 'radio', data: [{ value: 1, label: '男' }] }` |
| `checkbox` | 多选 | `{ key: 'tags', title: '标签', type: 'checkbox', data: [{ value: 'hot', label: '热门' }] }` |
| `select` | 下拉选择 | `{ key: 'role', title: '角色', type: 'select', data: [{ value: 'admin', label: '管理员' }] }` |
| `remote-select` | 远程选择 | `{ key: 'userId', title: '用户', type: 'remote-select', action: '/user/list' }` |
| `cascader` | 级联选择 | `{ key: 'category', title: '分类', type: 'cascader', data: [] }` |
| `date` | 日期/时间选择 | `{ key: 'date', title: '日期', type: 'date', dateType: 'datetime', valueFormat: 'x' }` |
| `datetimerange` | 日期时间范围 | `{ key: 'range', title: '时间范围', type: 'datetimerange' }` |
| `time` | 时间选择 | `{ key: 'time', title: '时间', type: 'time' }` |
| `editor` | 富文本编辑器 | `{ key: 'content', title: '内容', type: 'editor' }` |
| `json` | JSON 编辑器 | `{ key: 'config', title: '配置', type: 'json' }` |
| `array<string>` | 字符串数组 | `{ key: 'keywords', title: '关键词', type: 'array<string>' }` |
| `array<number>` | 数字数组 | `{ key: 'scores', title: '分数', type: 'array<number>' }` |
| `array<object>` | 对象数组 | `{ key: 'items', title: '明细', type: 'array<object>', columns: [] }` |
| `file` | 文件上传 | `{ key: 'file', title: '文件', type: 'file' }` |
| `file-select` | 文件选择器 | `{ key: 'image', title: '图片', type: 'file-select', fileType: 'image' }` |
| `icon` | 图标选择器 | `{ key: 'icon', title: '图标', type: 'icon' }` |
| `tree-select` | 树选择器 | `{ key: 'parentId', title: '上级', type: 'tree-select', action: '/tree/list' }` |
| `table-select` | 表格选择器 | `{ key: 'userId', title: '用户', type: 'table-select', action: '/user/list', columns: [] }` |
| `address` / `area-cascader` | 省市区选择 | `{ key: 'address', title: '地区', type: 'area-cascader' }` |
| `map` | 地图选点 | `{ key: 'location', title: '位置', type: 'map' }` |
| `tag` | 标签输入 | `{ key: 'tags', title: '标签', type: 'tag' }` |

查询表单也复用 `qa-form-item` 的类型，例如：

```vue
<qa-table-query
  :columns="queryForm.columns"
  v-model="queryForm.formData"
  @search="search"
/>
```

```typescript
const queryForm = ref({
  formData: {},
  columns: [
    { key: 'username', type: 'text', title: '用户名', width: 230, mode: 'in' },
    { key: 'nickname', type: 'text', title: '用户昵称', mode: '=', width: 230 },
    { key: '_add_time', type: 'datetimerange', title: '添加时间', mode: '[]', width: 230 },
  ],
})
```

---

## 📄 License

[MIT licensed](LICENSE)
