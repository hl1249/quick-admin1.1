# MCP 集成到 quick-admin1.1 项目

## 集成概述

已将桌面 MCP (Model Context Protocol) 项目成功嵌入到 quick-admin1.1 NestJS 项目中，提供 DeepSeek AI 对话能力和本地文件操作功能。

## 文件结构

```
src/app/mcp/
├── mcp.service.ts          # MCP 服务 - DeepSeek API 调用
├── mcp.controller.ts       # MCP 控制器 - HTTP API 接口
├── dto/
│   └── chat.dto.ts        # DTO 数据传输对象
└── tools/
    └── file.tool.ts       # 文件操作工具
```

## API 接口

### 1. 基础聊天接口

**POST** `/mcp/chat`

请求体：
```json
{
  "message": "你好，请介绍一下自己",
  "system": "可选的系统提示词",
  "history": [
    {"role": "user", "content": "之前的问题"},
    {"role": "assistant", "content": "之前的回答"}
  ]
}
```

响应：
```json
{
  "success": true,
  "data": {
    "reply": "AI 的回复内容"
  }
}
```

### 2. 智能聊天接口（支持文件操作）

**POST** `/mcp/chat/smart`

请求体同上，但支持 AI 自动调用文件操作工具：
- `find_files` - 查找文件
- `read_file` - 读取文件内容
- `write_file` - 创建/覆盖文件
- `edit_file` - 编辑文件内容

### 3. 查找文件接口

**GET** `/mcp/files?folder=desktop&extensions=.png,.jpg&recursive=true`

查询参数：
- `folder`: 文件夹路径（默认 desktop）
- `extensions`: 文件扩展名数组
- `recursive`: 是否递归扫描（默认 false）
- `maxResults`: 最大结果数（默认 200）

### 4. 读取文件接口

**GET** `/mcp/file?path=文件路径&maxBytes=20000`

### 5. 写入文件接口

**POST** `/mcp/file`

请求体：
```json
{
  "path": "文件路径",
  "content": "文件内容"
}
```

### 6. 编辑文件接口

**POST** `/mcp/file/edit`

请求体：
```json
{
  "path": "文件路径",
  "oldText": "要替换的旧文本",
  "newText": "替换后的新文本"
}
```

## 环境变量

在 `.env` 文件中已添加：

```env
# DeepSeek MCP 配置
DEEPSEEK_API_KEY=sk-13aa3e6b65d84490898c173e21f132b9
DEEPSEEK_API_URL=https://api.deepseek.com/chat/completions
DEEPSEEK_MODEL=deepseek-chat
```

## 使用示例

### 使用 curl 测试

```bash
# 基础聊天
curl -X POST http://localhost:3000/mcp/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"你好"}'

# 智能聊天（带文件操作）
curl -X POST http://localhost:3000/mcp/chat/smart \
  -H "Content-Type: application/json" \
  -d '{"message":"桌面上有哪些图片文件？"}'

# 查找文件
curl "http://localhost:3000/mcp/files?folder=desktop&extensions=.png,.jpg"

# 读取文件
curl "http://localhost:3000/mcp/file?path=test.txt"

# 写入文件
curl -X POST http://localhost:3000/mcp/file \
  -H "Content-Type: application/json" \
  -d '{"path":"test.txt","content":"Hello World"}'

# 编辑文件
curl -X POST http://localhost:3000/mcp/file/edit \
  -H "Content-Type: application/json" \
  -d '{"path":"test.txt","oldText":"Hello","newText":"Hi"}'
```

## 技术特性

1. **动态加载**：利用项目的动态模块加载机制，MCP 模块自动被识别和加载
2. **RESTful API**：提供标准的 HTTP API 接口
3. **文件安全**：自动保护敏感文件（.env, .pem, .key 等）
4. **流式响应**：支持实时文件操作进度反馈
5. **工具集成**：AI 可以自动调用文件操作工具完成复杂任务

## 下一步

启动项目：
```bash
cd E:\quick-admin1.1
pnpm run start:dev
```

访问 `http://localhost:3000/mcp/chat` 开始使用！
