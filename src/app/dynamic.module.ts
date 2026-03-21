import { Module, DynamicModule as NestDynamicModule } from '@nestjs/common';
import { loadControllers, loadProviders } from './dynamic.loader';
import { join } from 'path';
import { Public } from '@/public.module';

/** 模块注册阶段无 DI，与 configuration 中 app.debug（DEBUG === 'true'）对齐 */
function isDynamicLoadDebug(): boolean {
  return process.env.DEBUG === 'true';
}

@Module({
  imports: [Public],
})
export class DynamicModule {
  static register(): NestDynamicModule {
    const basePath = join(__dirname);
    const rootDir = join(__dirname, '..');
    const debug = isDynamicLoadDebug();

    const controllers = loadControllers(basePath, rootDir, debug);
    const providers = loadProviders(basePath, debug);

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
    const debug = isDynamicLoadDebug();

    const controllers = loadControllers(adminPath, rootDir, debug);
    const providers = loadProviders(adminPath, debug);

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
    const debug = isDynamicLoadDebug();

    const controllers = loadControllers(clientPath, rootDir, debug);
    const providers = loadProviders(clientPath, debug);

    return {
      module: DynamicModule,
      controllers,
      providers,
      exports: providers,
    };
  }
}
