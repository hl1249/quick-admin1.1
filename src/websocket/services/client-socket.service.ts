import { Injectable, Logger } from '@nestjs/common';
import { Namespace } from 'socket.io';
import {
  AuthenticatedSocket,
  ClientCartSyncPayload,
  ClientChatPayload,
} from '../types/socket.types';
import {
  SOCKET_EVENTS,
  buildBizRoom,
  buildUserRoom,
} from '../constants/socket.constants';

@Injectable()
export class ClientSocketService {
  private readonly logger = new Logger(ClientSocketService.name);
  private namespace?: Namespace;

  // 在 Gateway 初始化后缓存客户端命名空间，便于业务代码主动下发消息。
  registerNamespace(namespace: Namespace) {
    this.namespace = namespace;
  }

  // 向当前业务房间广播聊天消息，并附带发送者信息与时间戳。
  emitChatMessage(sender: AuthenticatedSocket, payload: ClientChatPayload) {
    if (!this.namespace) {
      this.logger.warn('Client namespace 尚未初始化，忽略聊天广播');
      return;
    }

    const room = buildBizRoom(payload.bizType, payload.bizId);
    this.namespace.to(room).emit(SOCKET_EVENTS.chatMessage, {
      bizType: payload.bizType,
      bizId: payload.bizId,
      message: payload.message,
      sender: sender.data.userInfo,
      ts: Date.now(),
    });
  }

  // 将购物车变更同步给同一业务房间内的其他客户端连接。
  syncCart(sender: AuthenticatedSocket, payload: ClientCartSyncPayload) {
    if (!this.namespace) {
      this.logger.warn('Client namespace 尚未初始化，忽略购物车同步');
      return;
    }

    const room = buildBizRoom(payload.bizType, payload.bizId);
    sender.to(room).emit(SOCKET_EVENTS.cartSync, {
      bizType: payload.bizType,
      bizId: payload.bizId,
      cart: payload.cart,
      sender: sender.data.userInfo,
      ts: Date.now(),
    });
  }

  // 向指定前台用户的专属房间发送通知消息。
  emitNotifyToUser(userId: string, payload: Record<string, any>) {
    if (!this.namespace) {
      this.logger.warn('Client namespace 尚未初始化，忽略客户端通知推送');
      return;
    }

    this.namespace.to(buildUserRoom(userId)).emit(SOCKET_EVENTS.notify, {
      ...payload,
      ts: Date.now(),
    });
  }
}
