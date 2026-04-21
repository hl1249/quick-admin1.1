import { Post, Controller, Get, SetMetadata } from '@nestjs/common';
import {
  DeleteResult,
  UpdateResult,
  Document,
  InsertManyResult,
  CollectionInfo,
} from 'mongodb';
import { SelectResult } from '@/common/db/db.types';
import { DbService } from '@/common/db/db.service';
import { JwtService } from '@/common/jwt/jwt.service';
import { _, $ } from '@/common/db/field-query';
import { Log } from '@/common/logger/logger.decorator';
import { CacheService } from '@/common/cache/cache.service';
import { InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';
@Log()
@Controller()
@SetMetadata('skipAuth', true) // 设置该路由不需要验证token
export class AppController {
  constructor(private readonly dbService: DbService) {}

  @Post('/callback')
  async callback() {

  }
}
