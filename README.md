<p align="center">
  <img style="margin: auto"  src="https://gitee.com/hr1249412130/quick-admin/raw/master/logo.png" width="250" alt="Nest Logo" />
</p>


 ## 📝 介绍
Quick Admin是一款基于NestJS + MongoDB 的前后端分离的快速开发框架，提供封装的dbService 类来简化MongDB的数据库操作。旨在帮助前端开发者快速搭建全栈项目。

## 📦 功能
- [x] 基于NestJS + MongoDB 的快速开发框架
- [x] 封装dbService类来简化MongDB的数据库操作
- [x] 提供统一响应、错误过滤、日志拦截、鉴权等功能
- [x] 提供前后端分离的快速开发框架
- [x] 提供丰富的工具函数
- [x] 动态生成路由配置
 ## 📄 运行
 <br/>
 
 ##### 💾 数据库

 1. 安装 <a href="https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-8.0.3-signed.msi">MongoDB</a>
 2. 导入quick/quick.sql执行(建议使用navicat导入SQL文件)
 3. 如果没有navicat复制sql语句 找到mongoDB Compass => 选择主机 => Create database => 选择创建的数据quickAdmin => Open MongoDB shell => 粘贴根目录quickAdmin.sql 执行
 <br/>
 <br/>
 ##### 💻 服务端

```bash
quick
├── src
│   ├── public.module.ts  # 共享注入模块
│   ├── config            # 配置文件
│   ├── app               # 业务模块
│   │   ├── admin         # 后台接口模块
│   │   ├── client        # 客户端接口模块
│   ├── common
│   │   ├── auth          # 鉴权
│   │   ├── cach          # 缓存模块（支持Redis/内存缓存）
│   │   ├── utils         # 工具类
│   │   ├── exception     # 错误过滤
│   │   ├── jwt           # JWT工具类
│   │   ├── logger        # 日志拦截
│   │   ├── response      # 统一响应
│   │   ├── validator     # 字段验证器
│   ├── db
│   │   ├── quickAdmin.sql       # 数据库文件
└─────────────────────────
```
```bash
# 安装依赖
$ pnpm install

# 开发模式
$ npm run start

# 开发模式:日志监听
$ npm run start:dev

# 生产模式
$ npm run start:prod
```
 <br/>

 ##### 📰 后台


```bash
template
├── src
│   ├── api           # 接口
│   ├── assets        # 静态资源
│   ├── components    # 全局组件
│   ├── config        # 配置文件
│   ├── layout        # 左右布局
│   ├── pages         # 页面
│   ├── router        # 路由配置
│   ├── store         # 状态管理
│   ├── util          # 工具类
│   ├── main.js       # 入口文件
└──────────────────────
```

```bash
# 安装依赖
$ pnpm install

# 开发模式
$ npm run dev

# 打包
$ npm run build

# 生产模式预览
$ npm run preview
```

<style>p{text-indent:2em}</style>