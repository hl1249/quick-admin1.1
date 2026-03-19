import {
  BadRequestException,
  Body,
  Controller,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { OssService } from '@/common/oss/oss.service';

@Controller()
export class SystemFileController {
  constructor(private readonly ossService: OssService) {}

  @Post('/upload')
  @UseInterceptors(FileInterceptor('file'))
  async upload(
    @UploadedFile() file: { buffer: Buffer; originalname: string; mimetype: string },
    @Body() data: { folder?: string; provider?: 'local' | 'tencent' | 'aliyun' | 'qiniu' }
  ) {
    if (!file) {
      throw new BadRequestException('请上传 file 文件');
    }

    const result = await this.ossService.upload(file.buffer, {
      filename: file.originalname,
      contentType: file.mimetype,
      folder: data?.folder,
      provider: data?.provider,
    });

    return {
      message: '上传成功',
      ...result,
    };
  }
}