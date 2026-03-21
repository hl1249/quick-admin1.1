import { Controller, Get, Req, Post, Body } from '@nestjs/common';
import { Document, UpdateResult } from 'mongodb'
import { DbService } from '@/common/utils/db.service';
import { AuthService } from '@/app/admin/auth/auth.service';
import { AppConfigService } from '@/config';
import { _ } from '@/common/utils/fieldQueryTemp';
import * as bcrypt from 'bcryptjs';

@Controller()
export class SystemUserController {
  constructor(
    private readonly dbService: DbService,
    private readonly authService: AuthService,
    private readonly appConfig: AppConfigService,
  ) {}

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.getTableData({
      dbName: 'qa-users',
      data,
      fieldJson: {
        password: 0,
      },
    });
  }

  @Post('/update')
  async update(@Body() data): Promise<Document | null> {
    let { _id, nickname, avatar, rate, enable = true } = data;

    const result: UpdateResult = await this.dbService.updateById({
      dbName: 'qa-users',
      id: _id,
      dataJson: {
        nickname,
        avatar,
        rate,
        enable,
      },
    });

    return result;
  }
  @Post('/add')
  add(@Body() data): Promise<Document | null> {
    return this.dbService.add({
      dbName: 'qa-users',
      dataJson: data,
    });
  }

  @Post('/delete')
  delete(@Body() whereJson): Promise<Document | null> {
    return this.dbService.del({
      dbName: 'qa-users',
      whereJson,
    });
  }

  @Post('/bindRole')
  bindRole(@Body() data): Promise<Document | null> {
    const { user_id, roleList } = data;
    return this.dbService.updateById({
      id: user_id,
      dbName: 'qa-users',
      dataJson: {
        role: roleList,
      },
    });
  }

  @Post('/resetPassword')
  async resetPassword(@Body() data): Promise<Document | null> {
    const { user_id, password } = data;
    const hashedPassword = await bcrypt.hash(password + this.appConfig.passwordSecret, 10);
    const result = await this.dbService.updateById({
      id: user_id,
      dbName: 'qa-users',
      dataJson: {
        password: hashedPassword,
        token: [], // 清空该用户所有 token，强制重新登录
      },
    });
    await this.authService.updateAuthVersion();
    return result;
  }

  @Post('/batchUpdateStatus')
  async batchUpdateStatus(
    @Body() data: { user_ids: string[]; status: number },
  ): Promise<Document | null> {
    const { status, user_ids } = data;
    const result = await this.dbService.update({
      dbName: 'qa-users',
      whereJson: {
        _id: _.in(user_ids),
      },
      dataJson: {
        status,
      },
    });

    return result;
  }
}