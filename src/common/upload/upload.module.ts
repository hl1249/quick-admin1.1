import { Global, Module } from '@nestjs/common';
import { OssModule } from '@/common/oss/oss.module';
import { UploadService } from './upload.service';

@Global()
@Module({
  imports: [OssModule],
  providers: [UploadService],
  exports: [UploadService],
})
export class UploadModule {}
