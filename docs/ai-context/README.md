# QuickAdmin AI Context

这组文档是给后台 AI 助手和 DeepSeek MCP 调用前置阅读的项目说明。

当用户要求分析、改写或创建项目代码时，优先读取本目录文档，再读取真实源码。文档只提供导航和约定，最终实现以当前代码为准。

## 阅读顺序

1. `01-project-structure.md`：项目目录、入口、构建产物位置。
2. `02-admin-frontend.md`：后台 Vue 管理端结构、路由、HTTP、全局组件。
3. `03-backend-api.md`：Nest 后端结构、动态路由、鉴权、响应格式。
4. `04-mcp-ai.md`：MCP/DeepSeek 接口、文件工具和 AI 弹窗约定。

## 常用路径

- 后端源码：`src/`
- 后台前端：`template/admin/`
- 后台页面：`template/admin/src/pages/`
- 后台全局组件：`template/admin/src/components/`
- MCP 后端：`src/app/mcp/`
- 数据库设计器：`src/app/admin/dev/databaseDesign/`

## 工作原则

- 修改代码前先读真实文件，不要只凭文档猜。
- 用户在后台某个路由唤起 AI 时，优先关注当前路由对应的页面组件。
- 不要修改 `.env`、密钥、证书等敏感文件。
- 涉及后台页面时，优先沿用 `qa-table`、`qa-form`、Element Plus、Pinia、Vue Router 等现有模式。
- 涉及后端接口时，优先沿用现有 Controller、DbService、鉴权和响应拦截结构。

