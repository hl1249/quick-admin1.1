import { Injectable } from '@nestjs/common';
import { JwtService } from '@/common/jwt/jwt.service';
import { UtilsService } from '@/common/utils/utils.service';
import { Connection } from 'mongoose';
import { InsertOneResult, DeleteResult, UpdateResult, ObjectId, Document, InsertManyResult, ReturnDocument } from 'mongodb'
import { InjectConnection } from '@nestjs/mongoose';

import { DbService } from '@/common/utils/db.service';
@Injectable()
export class AppService {

  constructor(
    private readonly jwtService: JwtService, 
    private readonly utilsService: UtilsService,
    private readonly dbService: DbService,
    @InjectConnection() private readonly connection: Connection,
  ) {
    // const token = this.jwtService.generateToken({ userId: 123 });
    // const untoken = this.jwtService.verifyToken(token);
  }

  async getHello() {
    return 'hello world';
  }
}
