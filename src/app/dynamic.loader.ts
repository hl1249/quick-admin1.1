import { Module, DynamicModule as NestDynamicModule, Type } from '@nestjs/common';
import { join, relative } from 'path';
import { readdirSync, statSync } from 'fs';
import { PATH_METADATA } from '@nestjs/common/constants';
import { DEBUG } from '@/config';

// 递归获取所有 controller 或 service 文件
function getFiles(dir: string, suffix: string[] = []): string[] {
  const files = readdirSync(dir);
  const result: string[] = [];

  files.forEach((file) => {
    const fullPath = join(dir, file);
    const stat = statSync(fullPath);

    if (stat.isDirectory()) {
      result.push(...getFiles(fullPath, suffix));
    } else if (suffix.some(s => file.endsWith(s))) {
      result.push(fullPath);
    }
  });

  return result;
}

// 动态加载 controller 并设置路由前缀 加载的 controller 必须以 Controller 结尾
export function loadControllers(basePath: string, rootDir: string): Type<any>[] {
  const files = getFiles(basePath, ['.controller.ts', '.controller.js']);
  const controllers: Type<any>[] = [];

  files.forEach(file => {
    try {
      const module = require(file);
      const controllerClass = Object.values(module).find(
        m => typeof m === 'function' && m.name && m.name.endsWith('Controller')
      ) as Type<any>;

      if (controllerClass) {
        const relativePath = relative(rootDir, file)
          .replace(/\.controller\.(ts|js)$/, '')
          .replace(/\\/g, '/')
          .split('/')
          .filter(p => p !== 'controller' && p !== 'controllers')
          .join('/');

        const routePrefix = `/${relativePath}`;
        Reflect.defineMetadata(PATH_METADATA, routePrefix, controllerClass);
        controllers.push(controllerClass);

         DEBUG ? console.log(`动态加载控制器: ${controllerClass.name} 控制器路由前缀: ${routePrefix}`) : null;
       
      }
    } catch (err) {
      DEBUG ? console.warn(`动态加载控制器失败 ${file}:`, err) : null;
    }
  });

  return controllers;
}

// 动态加载 service 加载的 service 必须以 Service 结尾
export function loadProviders(basePath: string): Type<any>[] {
  const files = getFiles(basePath, ['.service.ts', '.service.js']);
  const providers: Type<any>[] = [];

  files.forEach(file => {
    try {
      const module = require(file);
      const serviceClass = Object.values(module).find(
        m => typeof m === 'function' && m.name && m.name.endsWith('Service')
      ) as Type<any>;

      if (serviceClass) {
        providers.push(serviceClass);
        DEBUG ? console.log(`动态加载服务层模块: ${serviceClass.name}`) : null;
      }
    } catch (err) {
      DEBUG ? console.warn(`动态加载服务层模块失败 ${file}:`, err) : null;
    }
  });

  return providers;
}