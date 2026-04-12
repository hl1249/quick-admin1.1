import { Injectable, Logger } from '@nestjs/common';
import { Namespace } from 'socket.io';
import {
  AuthenticatedSocket,
  ClientCartSyncPayload,
  ClientChatPayload,
} from './socket.types';
import {
  SOCKET_EVENTS,
  buildBizRoom,
  buildUserRoom,
} from './socket.constants';

@Injectable()
export class ClientSocketService {
  private readonly logger = new Logger(ClientSocketService.name);
  private namespace?: Namespace;

  registerNamespace(namespace: Namespace) {
    this.namespace = namespace;
  }

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
