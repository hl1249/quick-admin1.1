import { BadRequestException, Body, Controller, Post } from '@nestjs/common';
import { AdminSocketService } from '@/websocket/services/admin-socket.service';

@Controller()
export class SysSocketPoolController {
  constructor(
    private readonly adminSocketService: AdminSocketService,
  ) {}

  @Post('/getList')
  getList(
    @Body()
    data: {
      socketId?: string;
      userId?: string;
      username?: string;
      nickname?: string;
      pageIndex?: number;
      pageSize?: number;
    },
  ) {
    return this.adminSocketService.getConnectionList(data || {});
  }

  @Post('/disconnect')
  disconnect(@Body() data: { socketId?: string }) {
    const socketId = data?.socketId?.trim();
    if (!socketId) {
      throw new BadRequestException('socketId 不能为空');
    }

    const result = this.adminSocketService.disconnectConnection(socketId);
    if (!result.disconnected) {
      throw new BadRequestException('连接不存在或已断开');
    }

    return result;
  }
}
