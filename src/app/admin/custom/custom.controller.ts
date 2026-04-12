import { Controller, Req, Post, Body } from '@nestjs/common';
import { Document } from 'mongodb'
import { DbService } from '@/common/db/db.service';
import { AdminSocketService } from '@/websocket/services/admin-socket.service';

@Controller()
export class CustomController {
  constructor(
    private readonly dbService: DbService,
    private readonly adminSocketService: AdminSocketService,
  ) {
  }

  @Post('/add')
  add(@Req() req, @Body() data): Promise<Document | null> {
    const { username, password, age, sex, groupId } = data

    return this.dbService.add({
      dbName: "custom",
      dataJson: {
        username,
        password,
        age,
        sex,
        groupId,
      }
    })
  }

  @Post('/delete')
  delete(@Body() whereJson): Promise<Document | null> {
    return this.dbService.del({
      dbName: "custom",
      whereJson
    })
  }

  @Post('/update')
  async update(@Req() req, @Body() data): Promise<any> {
    const { _id, username, password, age, sex, groupId } = data

    const result = await this.dbService.updateById({
      id: _id,
      dbName: "custom",
      dataJson: {
        username,
        password,
        age,
        sex,
        groupId,
      }
    })

    this.adminSocketService.emitNotify({
      type: 'custom:update',
      title: '自定义数据已更新',
      message: `custom 数据 ${username || _id} 已更新`,
      bizType: 'custom',
      bizId: _id,
      operatorId: req?.userInfo?._id?.toHexString?.() || req?.userInfo?._id,
      data: {
        _id,
        username,
        age,
        sex,
        groupId,
      },
    })

    return result
  }

  @Post('/getList')
  getList(@Req() req, @Body() data): Promise<Document | null> {
    return this.dbService.getTableData({
      dbName: "custom",
      data
    })
  }
}