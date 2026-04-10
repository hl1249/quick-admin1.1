import { Global, Module } from '@nestjs/common';
import { OssModule } from '@/common/oss/oss.module';
import { AppConfigModule } from '@/config/app-config.module';
import { UploadService } from './upload.service';

@Global()
@Module({
  imports: [OssModule, AppConfigModule],
  providers: [UploadService],
  exports: [UploadService],
})
export class UploadModule {}
