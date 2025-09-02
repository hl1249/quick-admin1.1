import { Injectable, BadRequestException, SetMetadata, Request, Post } from '@nestjs/common';
import { InsertOneResult } from 'mongodb'
import { JWT_SECRET } from '@/config'
import { UtilsService } from '@/common/utils/utils.service';
import { DeleteResult, UpdateResult, Document, InsertManyResult } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { JwtService } from '@/common/jwt/jwt.service';
import { _ } from '@/common/utils/fieldQueryTemp';
import { Log } from '@/common/logger/logger.decorator';
import * as bcrypt from 'bcryptjs';
import { UserDto } from './auth.dto';
@Injectable()
export class authService {
    constructor(
        private readonly utilsService: UtilsService,
        private readonly dbService: DbService,
        private readonly jwtService: JwtService,
    ) {
    }

    @Post()
    login(userDto: UserDto): Promise<Document | null> {
        return this.dbService.findByWhereJson({
            dbName: 'qa-users',
            whereJson: {

            }
        })
    }
}