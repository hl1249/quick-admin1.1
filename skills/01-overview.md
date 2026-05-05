# Quick Admin 项目概览

## 项目简介
Quick Admin 是一个基于 **NestJS 11 + MongoDB 8 + TypeScript** 的全栈快速开发框架，旨在帮助开发者专注于业务逻辑，快速搭建前后端分离的后台管理系统。

## 技术栈
| 领域 | 技术 |
|------|------|
| 后端框架 | NestJS 11 |
| 数据库 | MongoDB 8 + Mongoose |
| 语言 | TypeScript / JavaScript |
| 缓存 | Redis / 内存缓存双模式 |
| 鉴权 | JWT + 自定义权限守卫 |
| 存储 | 本地 / 阿里云OSS / 七牛云 / 腾讯云COS |
| 实时通信 | Socket.IO (WebSocket) |
| 包管理 | pnpm |
| 前端 | Vue 3 (template 目录) |

## 核心特性
- 📦 **开箱即用** — 基于 NestJS + MongoDB，内置完整后端架构
- 🗄️ **DbService** — 封装增删改查，告别繁琐原生 MongoDB 操作
- 🔐 **鉴权体系** — JWT 鉴权 + 权限校验，安全可靠
- 📡 **统一响应** — 统一的响应格式与异常过滤处理
- 📋 **日志拦截** — 内置请求日志拦截，便于追踪调试
- 🛠️ **工具函数** — 提供丰富的业务工具函数
- 🔄 **动态路由** — 动态生成路由配置，灵活扩展
- 💾 **缓存支持** — 支持 Redis / 内存缓存双模式
- 🔌 **多存储支持** — 本地、阿里云OSS、七牛云、腾讯云COS
- 🌐 **WebSocket** — 内置管理端和客户端 WebSocket 网关

## 目录结构
```
E:\quick-admin1.1/
├── src/                          # 后端源代码
│   ├── main.ts                   # 应用入口
│   ├── app.module.ts             # 根模块
│   ├── app.controller.ts         # 根控制器（含动态路由）
│   ├── app.service.ts            # 根服务
│   ├── public.module.ts          # 公共模块（全局注入）
│   ├── load-env.ts               # 环境变量加载
│   ├── config/                   # 配置模块
│   │   ├── configuration.ts      # 全局配置
│   │   ├── oss.config.ts         # OSS配置
│   │   └── app-config.service.ts # 应用配置服务
│   ├── app/
│   │   ├── admin/                # 后台管理接口
│   │   │   ├── auth/             # 认证模块（登录/注册）
│   │   │   ├── system/           # 系统管理
│   │   │   │   ├── systemUser/   # 用户管理
│   │   │   │   ├── systemRole/   # 角色管理
│   │   │   │   ├── systemMenu/   # 菜单管理
│   │   │   │   ├── systemPermission/ # 权限管理
│   │   │   │   ├── systemFile/   # 文件管理
│   │   │   │   ├── systemLog/    # 日志管理
│   │   │   │   ├── sysAppid/     # AppID管理
│   │   │   │   ├── sysSocketPool/ # Socket连接池
│   │   │   │   └── systemPayConfig/ # 支付配置
│   │   │   ├── dev/              # 开发工具
│   │   │   │   └── databaseDesign/ # 数据库设计器
│   │   │   └── template/         # 模板/Socket示例
│   │   ├── client/               # 客户端接口
│   │   │   ├── appid/            # AppID接口
│   │   │   └── user/             # 用户接口
│   │   ├── callback/             # 回调（如微信支付）
│   │   ├── setup/                # 安装初始化
│   │   ├── dynamic.loader.ts     # 动态模块加载器
│   │   └── dynamic.module.ts     # 动态模块
│   ├── common/                   # 公共模块
│   │   ├── auth/                 # 鉴权守卫
│   │   ├── cache/                # 缓存模块
│   │   ├── db/                   # 数据库核心（DbService）
│   │   ├── exception/            # 异常过滤
│   │   ├── jwt/                  # JWT工具
│   │   ├── logger/               # 日志拦截
│   │   ├── oss/                  # 对象存储
│   │   ├── response/             # 统一响应
│   │   ├── upload/               # 文件上传
│   │   ├── utils/                # 工具函数
│   │   └── validation/           # 参数验证
│   └── websocket/                # WebSocket模块
│       ├── gateways/             # 网关
│       ├── services/             # 服务
│       ├── constants/            # 常量
│       └── types/                # 类型定义
├── db/                           # 数据库数据文件（JSON格式）
├── deploy/                       # 部署版本
├── scripts/                      # 构建脚本
├── .env                          # 环境变量配置
├── package.json                  # 依赖配置
└── README.md                     # 项目文档
```
