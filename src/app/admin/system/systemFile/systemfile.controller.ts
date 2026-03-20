import {
  BadRequestException,
  Body,
  Req,
  Controller,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { UploadService } from '@/common/upload/upload.service';
import { DbService } from '@/common/utils/db.service';
import { Document } from 'mongodb';

@Controller()
export class SystemFileController {
  constructor(
    private readonly uploadService: UploadService,
    private readonly dbService: DbService,
  ) {}

  @Post('/upload')
  @UseInterceptors(FileInterceptor('file'))
  async upload(
    @UploadedFile() file: { buffer: Buffer; originalname: string; mimetype: string },
    @Body() data: { folder?: string; provider?: 'local' | 'tencent' | 'aliyun' | 'qiniu' }
  ) {
    if (!file) {
      throw new BadRequestException('请上传 file 文件');
    }

    const result = await this.uploadService.uploadFile(file, {
      folder: data?.folder,
      provider: data?.provider,
    });

    return {
      message: '上传成功',
      ...result,
    };
  }

  @Post('/getSpaceList')
  async getList(@Req() req, @Body() data): Promise<Document | null>{
    return await this.dbService.getTableData({
      dbName: 'qa-storage-space',
      data,
    });
  }
  @Post('/updateSpace')
  async updateSpace(@Req() req, @Body() data): Promise<Document | null>{
    const { _id, name, region, accessKey, secretKey, bucketName } = data
    return await this.dbService.updateById({
      dbName:'qa-storage-space',
      id:_id,
      dataJson:{
        _id,
        name,
        region,
        accessKey,
        secretKey,
        bucketName
      }
    })
  }

  @Post('/deleteSpace')
  async deleteSpace(@Body() data): Promise<Document | null>{
    const { _id } = data
    return await this.dbService.deleteById({
      dbName:'qa-storage-space',
      id:_id
    })
  }

  @Post('/addSpace')
  async addSpace(@Body() data): Promise<Document | null>{
    const { name, region, accessKey, secretKey, bucketName } = data
    return await this.dbService.add({
      dbName:'qa-storage-space',
      dataJson:{
        name,
        region,
      }
    })
  }
  
  @Post('/updateStorageConfig')
  async updateStorageConfig(@Body() data: { provider: 'local' | 'tencent' | 'aliyun' | 'qiniu' }) {
    const { provider } = data;
    const result = await this.dbService.updateById({
      dbName:'qa-storage-config',
      id:'69bcba3b0c34b64800565ea7',
      dataJson:{
        provider
      }
    })
    return {
      message: '更新成功',
      ...result,
    };
  }

  @Post('/getStorageConfig')
  async getStorageConfig(): Promise<Document | null>{
    return await this.dbService.findById({
      dbName:'qa-storage-config',
      id:'69bcba3b0c34b64800565ea7'
    })
  }
  
}