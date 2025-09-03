import { Injectable, BadRequestException, SetMetadata, Request, Post } from '@nestjs/common';
import { DbService } from '@/common/utils/db.service';
import { Document } from 'mongodb'
@Injectable()
export class authService {
    constructor(
        private readonly dbService: DbService,
    ) {
    }

    @Post()
    login(): Promise<Document | null> {
        return this.dbService.findByWhereJson({
            dbName: 'qa-users',
            whereJson: {
                age:20
            }
        })
    }
}