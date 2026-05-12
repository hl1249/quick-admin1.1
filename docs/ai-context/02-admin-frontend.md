# Admin Frontend

后台前端位于 `template/admin/`，使用 Vue 3、Vite、TypeScript、Pinia、Vue Router、Element Plus。

## 关键目录

```text
template/admin/src
├─ api/                 # 前端接口封装
├─ components/          # 全局/业务组件
│  ├─ ai/               # AI 助手弹窗
│  └─ quickAdmin/       # qa-table、qa-form 等 QuickAdmin 组件
├─ composables/         # 组合式逻辑，如 Socket
├─ layout/              # 后台主布局
├─ pages/               # 页面组件
├─ router/              # 路由配置
├─ store/               # Pinia store
├─ style/               # 全局样式
└─ utils/               # axios、工具函数
```

## 路由和页面

动态菜单最终会通过 `template/admin/src/utils/index.ts` 的 `buildAsyncMenus()` 转成 Vue Router routes。

菜单中的 `component` 通常是类似：

```text
/src/pages/system/systemUser/index
/src/pages/databaseDesign/index
```

构建路由时会通过 `import.meta.glob('@/pages/**/*.vue')` 匹配页面组件。

AI 助手根据当前路由和菜单配置推导当前页面文件。例如：

- `/home` -> `/src/pages/home/index.vue`
- `/databaseDesign` -> `/src/pages/databaseDesign/index.vue`

## HTTP 请求

统一 HTTP 封装：

```text
template/admin/src/utils/axios.ts
```

常规用法：

```ts
import http from '@/utils/axios'

http.request({
  url: '/app/admin/xxx/yyy',
  method: 'post',
  data: {},
})
```

注意：

- 前端传入的 `url` 通常不带 `/api`。
- `VITE_AXIOS_BASE_URL = '/api'` 时，最终请求会变成 `/api/...`。
- 登录后，拦截器会自动加 `Authorization: Bearer <token>`。

## QuickAdmin 组件

常用组件：

- `qa-table` / `qa-data-table`：后台列表。
- `qa-table-query`：查询表单。
- `qa-form`：表单渲染。
- `qa-dialog`：弹窗。

示例页面：

```text
template/admin/src/pages/template/table/index.vue
template/admin/src/pages/system/systemUser/index.vue
template/admin/src/pages/system/systemRole/index.vue
```

改后台页面时，优先参考这些已有页面结构，不要重新发明一套列表/表单模式。

## AI 助手

AI 弹窗：

```text
template/admin/src/components/ai/AiAssistantOverlay.vue
```

接口封装：

```text
template/admin/src/api/mcp.ts
```

全局挂载：

```text
template/admin/src/App.vue
```

快捷键：`Alt + R`

弹窗需要把当前路由、页面文件路径放进 system prompt，帮助 DeepSeek 聚焦当前页面。

