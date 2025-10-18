import { Module, DynamicModule as NestDynamicModule } from '@nestjs/common';
import { loadControllers,loadProviders } from './dynamic.loader';
import { join } from 'path';
import { Public } from '@/public.module';

@Module({
  imports: [Public],
})
export class DynamicModule {
  static register(): NestDynamicModule {
    const basePath = join(__dirname);
    const rootDir = join(__dirname, '..');

    const controllers = loadControllers(basePath, rootDir);
    const providers = loadProviders(basePath);

    return {
      module: DynamicModule,
      controllers,
      providers,
      exports: providers, // 如果其他模块也要用 service，需要导出
    };
  }

  static registerAdmin(): NestDynamicModule {
    const adminPath = join(__dirname, 'admin');
    const rootDir = join(__dirname, '..');

    const controllers = loadControllers(adminPath, rootDir);
    const providers = loadProviders(adminPath);

    return {
      module: DynamicModule,
      controllers,
      providers,
      exports: providers,
    };
  }

  static registerClient(): NestDynamicModule {
    const clientPath = join(__dirname, 'client');
    const rootDir = join(__dirname, '..');

    const controllers = loadControllers(clientPath, rootDir);
    const providers = loadProviders(clientPath);

    return {
      module: DynamicModule,
      controllers,
      providers,
      exports: providers,
    };
  }
}
