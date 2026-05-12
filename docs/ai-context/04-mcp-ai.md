# MCP And AI Assistant

MCP/DeepSeek 后端位于：

```text
src/app/mcp/
```

前端 AI 弹窗位于：

```text
template/admin/src/components/ai/AiAssistantOverlay.vue
```

## 接口

实际接口路径带 `/api` 前缀：

```text
POST /api/mcp/chat
POST /api/mcp/chat/smart
GET  /api/mcp/files
GET  /api/mcp/file
POST /api/mcp/file
POST /api/mcp/file/edit
```

前端通过 axios baseURL `/api` 调用时，代码里写：

```ts
url: '/mcp/chat/smart'
```

## DeepSeek 配置

配置来自 `.env`：

```text
DEEPSEEK_API_URL
DEEPSEEK_MODEL
DEEPSEEK_API_KEY
```

不要读取或输出 `.env` 的真实密钥内容。

## 文件工具

`src/app/mcp/tools/file.service.ts` 提供：

- `findFiles`
- `readFile`
- `writeFile`
- `editFile`

当前 MCP 文件根目录是项目根目录：

```ts
process.cwd()
```

所以相对路径应从 `E:\quick-admin1.1` 开始解析。

## 上下文策略

AI 助手应把以下信息作为 system prompt 传给 DeepSeek：

- 当前路由
- 当前页面组件路径
- 本文档索引路径：`docs/ai-context/README.md`
- 当前任务类型：分析、解释、改写或创建代码

处理代码任务时建议顺序：

1. 读取 `docs/ai-context/README.md`
2. 按需读取 `01-project-structure.md`、`02-admin-frontend.md`、`03-backend-api.md`
3. 读取当前页面或目标文件真实内容
4. 给出方案或直接修改文件
5. 如修改文件，尽量复查目标文件关键片段

## 限制

当前后端已放宽：

- 工具调用最多 12 轮。
- 默认读取文件 80KB。
- 单次读取最大 200KB。

如果仍然遇到工具调用轮数上限，优先要求用户明确目标文件、路由、组件或具体改动点。

