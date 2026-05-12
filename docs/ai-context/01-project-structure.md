# Project Structure

QuickAdmin 是一个 NestJS 后端 + Vue 后台模板的项目。当前工作根目录是 `E:\quick-admin1.1`。

## 根目录

```text
E:\quick-admin1.1
├─ src/                 # NestJS 后端源码
├─ template/admin/      # Vue3 + Element Plus 后台管理端
├─ template/client/     # 客户端模板
├─ db/                  # 初始化/演示数据
├─ docs/                # 项目文档
├─ deploy/              # 构建后部署目录
├─ setup/               # 安装引导静态页面
├─ uploads/             # 本地上传文件
├─ scripts/             # 构建、启动辅助脚本
├─ package.json         # 后端工程配置
└─ pnpm-lock.yaml
```

## 后端入口

- `src/main.ts`：Nest 应用入口，设置全局前缀 `/api`、静态资源、CORS、Socket.IO。
- `src/app.module.ts`：根模块，注册全局 Guard、Interceptor、Filter、Pipe，并引入动态模块。
- `src/app/dynamic.module.ts`：动态加载 `src/app/**/**.controller.ts` 和 `*.service.ts`。
- `src/app/dynamic.loader.ts`：动态加载器。若 Controller 自己声明了 `@Controller('xxx')`，应优先尊重这个路径。

## 后台前端入口

- `template/admin/src/main.ts`：Vue 应用入口，注册 Pinia、Router、Element Plus icons、QuickAdmin 组件。
- `template/admin/src/App.vue`：全局外壳，目前挂载 AI 助手蒙层。
- `template/admin/src/router/`：静态路由、动态菜单路由和模板路由。
- `template/admin/src/layout/main.vue`：后台主布局。

## 构建命令

后端：

```bash
pnpm run build
pnpm start
pnpm start:dev
```

后台前端：

```bash
cd template/admin
pnpm exec vue-tsc -b
pnpm run build
pnpm run dev
```

## 运行端口

- 后端默认端口：`3000`
- 后端 API 前缀：`/api`
- 后台前端开发端口通常是：`5173`
- 前端开发环境通过 Vite proxy 将 `/api` 代理到后端。

