import { BadRequestException, Body, Controller, Post, Req } from '@nestjs/common';
import { AdminSocketService } from '@/websocket/services/admin-socket.service';

@Controller()
export class SocketController {
  constructor(
    private readonly adminSocketService: AdminSocketService,
  ) {}

  @Post('/notify/send')
  sendNotify(@Req() req, @Body() data) {
    const {
      targetType = 'broadcast',
      userId,
      bizType,
      bizId,
      title,
      message,
      data: payloadData,
    } = data || {}

    if (!message?.trim()) {
      throw new BadRequestException('message 不能为空')
    }

    const payload = {
      title: title?.trim() || 'Socket 测试通知',
      message: message.trim(),
      targetType,
      bizType: bizType?.trim() || undefined,
      bizId: bizId?.trim() || undefined,
      operatorId: req?.userInfo?._id?.toHexString?.() || req?.userInfo?._id,
      data: payloadData ?? null,
    }

    if (targetType === 'broadcast') {
      this.adminSocketService.emitNotify(payload)
      return {
        sent: true,
        targetType,
      }
    }

    if (targetType === 'user') {
      if (!userId?.trim()) {
        throw new BadRequestException('userId 不能为空')
      }

      this.adminSocketService.emitNotifyToUser(userId.trim(), payload)
      return {
        sent: true,
        targetType,
        userId: userId.trim(),
      }
    }

    if (targetType === 'group') {
      if (!bizType?.trim() || !bizId?.trim()) {
        throw new BadRequestException('bizType 和 bizId 不能为空')
      }

      this.adminSocketService.emitNotifyToBizRoom(
        bizType.trim(),
        bizId.trim(),
        payload,
      )
      return {
        sent: true,
        targetType,
        bizType: bizType.trim(),
        bizId: bizId.trim(),
      }
    }

    throw new BadRequestException('targetType 仅支持 broadcast、user、group')
  }
}
