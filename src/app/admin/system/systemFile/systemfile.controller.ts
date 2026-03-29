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
import { basename } from 'path';
import { UploadService } from '@/common/upload/upload.service';
import { DbService } from '@/common/utils/db.service';
import { Document } from 'mongodb';
import { _, } from '@/common/utils/fieldQueryTemp';
import { formatTimestamp } from '@/common/utils/utils'
import { LocalOssProvider } from '@/common/oss/providers/local.oss';
import { TencentOssProvider } from '@/common/oss/providers/tencent.oss';
import { AliyunOssProvider } from '@/common/oss/providers/aliyun.oss';
import { QiniuOssProvider } from '@/common/oss/providers/qiniu.oss';

@Controller()
export class SystemFileController {
  private readonly $cosac = "public-read"
  constructor(
    private readonly uploadService: UploadService,
    private readonly dbService: DbService,
    private readonly localOssProvider: LocalOssProvider,
    private readonly tencentOssProvider: TencentOssProvider,
    private readonly aliyunOssProvider: AliyunOssProvider,
    private readonly qiniuOssProvider: QiniuOssProvider,
  ) {}

  private parseDomainHost(domain: string) {
    try {
      const parsedUrl = new URL(domain);
      if (!parsedUrl.hostname) {
        throw new Error('invalid hostname');
      }
      return parsedUrl.hostname.trim().toLowerCase();
    } catch {
      throw new BadRequestException('域名输入有误');
    }
  }

  private async validateDomainBeforeUpdate(space: any, domain?: string) {
    if (!domain || space?.domain === domain) {
      return;
    }

    const domainHost = this.parseDomainHost(domain);

    try {
      if (space.provider === 'tencent') {
        await this.tencentOssProvider.ensureBucketDomain({
          bucket: space.name,
          region: space.region,
          secretId: space.accessKey,
          secretKey: space.secretKey,
          domain: domainHost,
          type: 'REST',
        });
        return;
      }

      if (space.provider === 'aliyun') {
        await this.aliyunOssProvider.ensureBucketDomain({
          bucket: space.name,
          region: space.region,
          accessKeyId: space.accessKey,
          accessKeySecret: space.secretKey,
          endpoint: space.endpoint,
          domain: domainHost,
        });
      }
    } catch (error) {
      throw new BadRequestException((error as Error).message);
    }
  }

  private getFileType(mimetype?: string) {
    if (!mimetype) {
      return 'file';
    }

    if (mimetype.startsWith('image/')) {
      return 'image';
    }

    if (mimetype.startsWith('video/')) {
      return 'video';
    }

    if (mimetype.startsWith('audio/')) {
      return 'audio';
    }

    return 'file';
  }

  private getImageSize(buffer: Buffer, mimetype?: string) {
    if (!mimetype?.startsWith('image/')) {
      return { width: null, height: null };
    }

    if (buffer.length >= 24 && buffer.readUInt32BE(0) === 0x89504e47) {
      return {
        width: buffer.readUInt32BE(16),
        height: buffer.readUInt32BE(20),
      };
    }

    if (
      buffer.length >= 10 &&
      buffer[0] === 0x47 &&
      buffer[1] === 0x49 &&
      buffer[2] === 0x46
    ) {
      return {
        width: buffer.readUInt16LE(6),
        height: buffer.readUInt16LE(8),
      };
    }

    if (
      buffer.length >= 30 &&
      buffer[0] === 0x52 &&
      buffer[1] === 0x49 &&
      buffer[2] === 0x46 &&
      buffer[3] === 0x46 &&
      buffer[8] === 0x57 &&
      buffer[9] === 0x45 &&
      buffer[10] === 0x42 &&
      buffer[11] === 0x50
    ) {
      const chunkType = buffer.toString('ascii', 12, 16);

      if (chunkType === 'VP8X' && buffer.length >= 30) {
        return {
          width: 1 + buffer.readUIntLE(24, 3),
          height: 1 + buffer.readUIntLE(27, 3),
        };
      }

      if (chunkType === 'VP8 ' && buffer.length >= 30) {
        return {
          width: buffer.readUInt16LE(26) & 0x3fff,
          height: buffer.readUInt16LE(28) & 0x3fff,
        };
      }

      if (chunkType === 'VP8L' && buffer.length >= 25) {
        const bits = buffer.readUInt32LE(21);
        return {
          width: (bits & 0x3fff) + 1,
          height: ((bits >> 14) & 0x3fff) + 1,
        };
      }
    }

    if (buffer.length >= 4 && buffer[0] === 0xff && buffer[1] === 0xd8) {
      let offset = 2;

      while (offset < buffer.length) {
        if (buffer[offset] !== 0xff) {
          offset += 1;
          continue;
        }

        const marker = buffer[offset + 1];
        const length = buffer.readUInt16BE(offset + 2);

        if (
          [
            0xc0, 0xc1, 0xc2, 0xc3, 0xc5, 0xc6, 0xc7,
            0xc9, 0xca, 0xcb, 0xcd, 0xce, 0xcf,
          ].includes(marker)
        ) {
          return {
            height: buffer.readUInt16BE(offset + 5),
            width: buffer.readUInt16BE(offset + 7),
          };
        }

        if (!length || offset + length + 2 > buffer.length) {
          break;
        }

        offset += length + 2;
      }
    }

    return { width: null, height: null };
  }

  @Post('/upload')
  @UseInterceptors(FileInterceptor('file'))
  async upload(
    @Req() req,
    @UploadedFile() file: { buffer: Buffer; originalname: string; mimetype: string; size?: number },
    @Body() data: { folder?: string; category_id?: string | null }
  ) {
    if (!file) {
      throw new BadRequestException('请上传 file 文件');
    }

    const result = await this.uploadService.uploadFile(file, {
      folder: data?.folder,
    });
    const userId = req?.userInfo?._id?.toHexString?.() ?? String(req?.userInfo?._id ?? '');
    const fileType = this.getFileType(file.mimetype);
    const { width, height } = this.getImageSize(file.buffer, file.mimetype);
    const objectName = basename(result.key);
    const record = {
      user_id: userId,
      sort: 0,
      status: 0,
      type: fileType,
      url: result.url,
      display_name: objectName,
      original_name: file.originalname,
      size: file.size ?? file.buffer.length,
      file_id: result.url,
      provider: result.provider,
      width,
      height,
      category_id: data?.category_id ?? null,
    };
    const saveResult = await this.dbService.add({
      dbName: 'qa-files',
      dataJson: record,
    });

    return {
      message: '上传成功',
      ...result,
      record_id: saveResult.insertedId,
      record,
    };
  }

  @Post('/space/getList')
  async getList(@Body() data): Promise<Document | null>{
    return await this.dbService.getTableData({
      dbName: 'qa-storage-space',
      data,
    });
  }


  @Post('/space/update')
  async updateSpace(@Req() req, @Body() data): Promise<Document | null>{
    const { _id, domain, cdn  } = data

    const space = await this.dbService.findById({
      dbName:'qa-storage-space',
      id:_id
    })

    if(!space){
      throw new BadRequestException('存储空间不存在');
    }

    await this.validateDomainBeforeUpdate(space, domain)

    return await this.dbService.updateById({
      dbName:'qa-storage-space',
      id:_id,
      dataJson:{
        domain, cdn,
        _update_time: Date.now(),
        _update_time_str: formatTimestamp(new Date()),
      }
    })
  }

  @Post('/space/delete')
  async deleteSpace(@Body() data): Promise<Document | null>{
    const { _id } = data
    const space = await this.dbService.findById({
      dbName:'qa-storage-space',
      id:_id
    })
    if(space?.enable){
      throw new BadRequestException('存储空间已启用，请先禁用');
    }
    return await this.dbService.deleteById({
      dbName:'qa-storage-space',
      id:_id
    })
  }

  @Post('/space/add')
  async addSpace(@Body() data): Promise<Document | null>{
    const { name, region, provider, acl} = data
    let bucketName = name

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

    try {
      if (provider === 'tencent') {
        const result = await this.tencentOssProvider.createBucket({
          bucket: name,
          region,
          secretId: config.accessKey,
          secretKey: config.secretKey,
          appId: config.appId,
          acl,
        });
        bucketName = result.bucket;
      } else if (provider === 'aliyun') {
        const result = await this.aliyunOssProvider.createBucket({
          bucket: name,
          region,
          accessKeyId: config.accessKey,
          accessKeySecret: config.secretKey,
          acl,
        });
        bucketName = result.bucket;
      } else if (provider === 'qiniu') {
        const result = await this.qiniuOssProvider.createBucket({
          bucket: name,
          region,
          accessKey: config.accessKey,
          secretKey: config.secretKey,
          acl,
        });
        bucketName = result.bucket;
      }
    } catch (error) {
      throw new BadRequestException((error as Error).message);
    }

    let domain 
    if(provider === 'tencent'){
      domain =  `https://${bucketName}.cos.${region}.myqcloud.com`
    }else if(provider === 'aliyun'){
      domain = `https://${bucketName}.${region}.aliyuncs.com`
    }else if(provider === 'qiniu'){
      domain = `https://${bucketName}.${region}.qiniucdn.com`
    }

    return await this.dbService.add({
      dbName:'qa-storage-space',
      dataJson:{
        name: bucketName,
        region,
        domain,
        provider,
        acl,
        accessKey: config.accessKey,
        secretKey: config.secretKey,
        enable:false,
        _update_time: Date.now(),
        _update_time_str: formatTimestamp(new Date()),
      }
    })
  }
  
  @Post('/appConfig/update')
  async updateAppConfig(@Body() data: { oss_provider: 'local' | 'tencent' | 'aliyun' | 'qiniu' }) {
    const { oss_provider } = data;

    const enabledSpaceList = await this.dbService.selects({
      dbName:'qa-storage-space',
      whereJson:{
        provider:oss_provider,
        enable: true,
      },
      getMain: true,
      pageSize: 1000,
    })

    if(oss_provider != 'local' && enabledSpaceList.length <= 0){
      throw new BadRequestException('当前存储提供商下至少需要一个已启用的存储空间');
    }

    const result = await this.dbService.updateById({
      dbName:'qa-app-config',
      id:'69bcbb2e0c34b64800565ec6',
      dataJson:{
        oss_provider,
        _update_time: Date.now(),
        _update_time_str: formatTimestamp(new Date()),
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
    
    return await this.dbService.setById({
      dbName:'qa-storage-config',
      id:_id,
      dataJson:{
        provider,
        accessKey,
        secretKey,
        appId: provider === 'tencent' ? appId : _.remove()
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
        ...(provider === 'tencent' ? { appId } : {}),
        _update_time: Date.now(),
        _update_time_str: formatTimestamp(new Date()),
      }
    })
  }
  @Post('/region/getList')
  async getRegionList(@Body() data): Promise<Document | null>{
    const { provider } = data

    switch (provider) {
      case 'tencent':
        return this.tencentOssProvider.getRegions()
      case 'aliyun':
        return this.aliyunOssProvider.getRegions()
      case 'qiniu':
        return this.qiniuOssProvider.getRegions()
      case 'local':
      default:
        return this.localOssProvider.getRegions()
    }
  }
  @Post('/space/updateBase')
  async updateSpaceBase(@Body() data): Promise<Document | null>{
    
    const {_id, enable, provider } = data
    const space = await this.dbService.findById({
      dbName:'qa-storage-space',
      id:_id,
    })

    if(!space?.domain && enable){
      throw new BadRequestException('请先配置存储空间域名');
    }

    return await this.dbService.update({
      dbName:'qa-storage-space',
      whereJson:{
        _id,
        provider
      },
      dataJson:{
        enable,
        _update_time: Date.now(),
        _update_time_str: formatTimestamp(new Date()),
      },
    })
  }

  @Post('/space/getBase')
  async getSpaceBase(@Body() data): Promise<Document | null>{
    const { _id } = data
    return await this.dbService.findById({
      dbName:'qa-storage-space',
      id:_id
    })
  }

  @Post('/space/sync')
  async syncSpace(@Body() data: { provider?: 'local' | 'tencent' | 'aliyun' | 'qiniu' }) {
    const provider = data?.provider ?? 'tencent';
    if (provider === 'local') {
      throw new BadRequestException('本地存储无需同步存储空间');
    }

    const config = await this.dbService.findByWhereJson({
      dbName: 'qa-storage-config',
      whereJson: {
        provider,
      },
    });

    if (!config) {
      throw new BadRequestException('请先配置存储提供商');
    }

    let serviceData: {
      owner?: { id?: string; displayName?: string };
      buckets: Array<{
        name: string;
        region: string;
        domain: string;
        creationDate?: string;
        bucketType?: string;
        ofsType?: string;
        azType?: string;
        storageClass?: string;
        private?: number;
        protected?: number;
      }>;
    };

    switch (provider) {
      case 'tencent':
        serviceData = await this.tencentOssProvider.getBucketList({
          secretId: config.accessKey,
          secretKey: config.secretKey,
        });
        break;
      case 'aliyun':
        serviceData = await this.aliyunOssProvider.getBucketList({
          accessKeyId: config.accessKey,
          accessKeySecret: config.secretKey,
          region: config.region,
        });
        break;
      case 'qiniu':
        serviceData = await this.qiniuOssProvider.getBucketList({
          accessKey: config.accessKey,
          secretKey: config.secretKey,
        });
        break;
      default:
        throw new BadRequestException('不支持的存储提供商');
    }

    const remoteBuckets = serviceData.buckets;
    const localSpaces = await this.dbService.selects({
      dbName: 'qa-storage-space',
      whereJson: {
        provider,
      },
      pageIndex: 1,
      pageSize: Math.max(remoteBuckets.length, 1000),
      getMain: true,
    });

    const appIdSuffix = config.appId ? `-${config.appId}` : '';
    const localMap = new Map<string, Document>();

    for (const item of localSpaces) {
      if (typeof item?.name !== 'string') {
        continue;
      }

      localMap.set(item.name, item);
      if (appIdSuffix && item.name.endsWith(appIdSuffix)) {
        localMap.set(item.name.slice(0, -appIdSuffix.length), item);
      }
    }

    let created = 0;
    let updated = 0;

    for (const bucket of remoteBuckets) {
      const localSpace =
        localMap.get(bucket.name) ??
        (appIdSuffix && bucket.name.endsWith(appIdSuffix)
          ? localMap.get(bucket.name.slice(0, -appIdSuffix.length))
          : undefined);

      const dataJson = {
        name: bucket.name,
        region: bucket.region,
        domain: bucket.domain,
        provider,
        accessKey: config.accessKey,
        secretKey: config.secretKey,
        acl: provider === 'tencent' ? this.$cosac : localSpace?.acl,
        // bucketType: bucket.bucketType,
        // ofsType: bucket.ofsType,
        // azType: bucket.azType,
        // storageClass: bucket.storageClass,
        // private: bucket.private,
        // protected: bucket.protected,
        creationDate: bucket.creationDate,
        _update_time: Date.now(),
        _update_time_str: formatTimestamp(new Date()),
      };

      if (localSpace?._id) {
        await this.dbService.updateById({
          dbName: 'qa-storage-space',
          id: String(localSpace._id),
          dataJson,
        });
        updated += 1;
        continue;
      }

      await this.dbService.add({
        dbName: 'qa-storage-space',
        dataJson: {
          ...dataJson,
          enable: false,
        },
      });
      created += 1;
    }

    return {
      message: '同步成功',
      provider,
      owner: serviceData.owner,
      total: remoteBuckets.length,
      created,
      updated,
      buckets: remoteBuckets,
    };
  }
}