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

## 📄 License

[MIT licensed](LICENSE)
