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

  @Post('/space/getList')
  async getList(@Req() req, @Body() data): Promise<Document | null>{
    return await this.dbService.getTableData({
      dbName: 'qa-storage-space',
      data,
    });
  }
  @Post('/space/update')
  async updateSpace(@Req() req, @Body() data): Promise<Document | null>{
    const { _id, name, region, accessKey, secretKey, bucketName } = data

    const space = await this.dbService.findById({
      dbName:'qa-storage-space',
      id:_id
    })
    
    if(!space){
      throw new BadRequestException('存储空间不存在');
    }
    if(space.provider === 'tencent'){
      space.domain =  `https://${name}.cos.${region}.myqcloud.com`
    }else if(space.provider === 'aliyun'){
      space.domain = name + '.oss.' + region + '.aliyuncs.com'
    }else if(space.provider === 'qiniu'){
      space.domain = name + '.' + region + '.qiniucdn.com'
    }

    return await this.dbService.updateById({
      dbName:'qa-storage-space',
      id:_id,
      dataJson:{
        name,
        region,
        domain: space.domain,
      }
    })
  }

  @Post('/space/delete')
  async deleteSpace(@Body() data): Promise<Document | null>{
    const { _id } = data
    return await this.dbService.deleteById({
      dbName:'qa-storage-space',
      id:_id
    })
  }

  @Post('/space/add')
  async addSpace(@Body() data): Promise<Document | null>{
    const { name, region, provider} = data

    const config = await this.dbService.findByWhereJson({
      dbName:'qa-storage-config',
      whereJson:{
        provider
      }
    })

    console.log("config",config)

    if(!config){
      throw new BadRequestException('请先配置存储提供商');
    }

    let domain 
    if(provider === 'tencent'){
      domain =  `https://${name}.cos.${region}.myqcloud.com`
    }else if(provider === 'aliyun'){
      domain = name + '.oss.' + region + '.aliyuncs.com'
    }else if(provider === 'qiniu'){
      domain = name + '.' + region + '.qiniucdn.com'
    }

    return await this.dbService.add({
      dbName:'qa-storage-space',
      dataJson:{
        name,
        region,
        domain,
        provider,
        accessKey: config.accessKey,
        secretKey: config.secretKey,
      }
    })
  }
  
  @Post('/appConfig/update')
  async updateAppConfig(@Body() data: { oss_provider: 'local' | 'tencent' | 'aliyun' | 'qiniu' }) {
    const { oss_provider } = data;
    const result = await this.dbService.updateById({
      dbName:'qa-app-config',
      id:'69bcbb2e0c34b64800565ec6',
      dataJson:{
        oss_provider
      }
    })
    return {
      message: '更新成功',
      ...result,
    };
  }

  @Post('/appConfig/get')
  async getAppConfig(): Promise<Document | null>{
    return await this.dbService.findById({
      dbName:'qa-app-config',
      id:'69bcbb2e0c34b64800565ec6'
    })
  }
  
  
  @Post('/storageConfig/get')
  async getStorageConfig(@Body() data): Promise<Document | null>{

    const { provider } = data

    return await this.dbService.findByWhereJson({
      dbName:'qa-storage-config',
      whereJson:{
        provider
      }
    })
  }
  @Post('/storageConfig/update')
  async updateStorageConfig(@Body() data): Promise<Document | null>{
    const { _id, provider, accessKey, secretKey, appId } = data
    return await this.dbService.updateById({
      dbName:'qa-storage-config',
      id:_id,
      dataJson:{
        provider,
        accessKey,
        secretKey,
        appId,
      }
    })
  }
  @Post('/storageConfig/add')
  async addtStorageConfig(@Body() data): Promise<Document | null>{

    const { provider, accessKey, secretKey, appId } = data

    return await this.dbService.add({
      dbName:'qa-storage-config',
      dataJson:{
        provider,
        accessKey,
        secretKey,
        appId,
      }
    })
  }


  @Post('/region/getList')
  async getRegionList(@Body() data): Promise<Document | null>{
    const { provider } = data
    return await this.dbService.getTableData({
      dbName:'qa-storage-region',
      whereJson:{
        provider
      },
      data,
    })
  }
}