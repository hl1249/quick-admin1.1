import { Module, DynamicModule as NestDynamicModule } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { loadControllers, loadProviders } from './dynamic.loader';
import { join } from 'path';
import { Public } from '@/public.module';
import { AppConfigService } from '@/config';

@Module({
  imports: [Public],
})
export class DynamicModule {
  static register(): NestDynamicModule {
    const basePath = join(__dirname);
    const rootDir = join(__dirname, '..');
    const debug = new AppConfigService(new ConfigService()).debug;

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
    const debug = new AppConfigService(new ConfigService()).debug;

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
    const debug = new AppConfigService(new ConfigService()).debug;

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
