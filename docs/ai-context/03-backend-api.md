# Backend API

后端位于 `src/`，使用 NestJS 11、MongoDB、Mongoose、Socket.IO。

## 全局前缀和响应格式

`src/main.ts` 中设置了全局 API 前缀：

```ts
app.setGlobalPrefix('api')
```

所以 `@Controller('mcp')` 的接口实际路径是：

```text
/api/mcp/...
```

响应会经过 `src/common/response/response.interceptors.ts` 包装：

```json
{
  "code": 0,
  "message": "成功!",
  "data": {},
  "requestId": null
}
```

前端提取深层数据时要注意这一层包装。

## 鉴权

全局 Guard：

- `src/common/auth/auth.guard.ts`：校验 JWT token。
- `src/common/auth/permission.guard.ts`：校验后台权限。

需要跳过鉴权时，现有代码使用：

```ts
@SetMetadata('skipAuth', true)
```

后台登录后的前端请求会自动携带 `Authorization` header。

## 动态 Controller 加载

动态加载器：

```text
src/app/dynamic.loader.ts
src/app/dynamic.module.ts
```

动态加载规则：

- 扫描 `src/app/**/*.controller.ts`
- 扫描 `src/app/**/*.service.ts`
- Controller 类名通常以 `Controller` 结尾
- Service 类名通常以 `Service` 结尾

如果 Controller 自己声明了 `@Controller('mcp')`，动态加载器应保留该路径，不要覆盖成文件路径。

## 后台业务接口路径

后台业务接口通常位于：

```text
src/app/admin/
```

动态路由会按目录生成路径，例如：

```text
src/app/admin/system/systemUser/systemUser.controller.ts
-> /api/app/admin/system/systemUser/systemUser/...
```

## DbService

数据库封装位于：

```text
src/common/db/db.service.ts
```

常见操作：

- `add`
- `adds`
- `deleteById`
- `del`
- `updateById`
- `update`
- `select`
- `selects`
- `findById`
- `findByWhereJson`

写新 Controller 时优先沿用这些封装。

## 数据库设计器

相关后端：

```text
src/app/admin/dev/databaseDesign/
```

常用接口：

- `POST /api/app/admin/dev/databaseDesign/databaseDesign/createDatabase`
- `POST /api/app/admin/dev/databaseDesign/databaseDesign/downloadCRUD`
- `POST /api/app/admin/dev/databaseDesign/schemas/add`
- `POST /api/app/admin/dev/databaseDesign/schemas/getList`

除非用户明确要求，不要在通用 AI 对话框里主动加入 CRUD 创建步骤。

