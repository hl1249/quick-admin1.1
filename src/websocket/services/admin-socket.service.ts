import { Injectable, Logger } from '@nestjs/common';
import { Namespace } from 'socket.io';
import {
  AdminOrderUpdatePayload,
} from '../types/socket.types';
import {
  SOCKET_EVENTS,
  buildBizRoom,
  buildUserRoom,
} from '../constants/socket.constants';

@Injectable()
export class AdminSocketService {
  private readonly logger = new Logger(AdminSocketService.name);
  private namespace?: Namespace;

  // 在 Gateway 初始化后注册后台命名空间，供其他业务模块复用同一个推送出口。
  registerNamespace(namespace: Namespace) {
    this.namespace = namespace;
  }

  // 向后台命名空间内的所有连接广播通用通知消息。
  emitNotify(payload: Record<string, any>) {
    if (!this.namespace) {
      this.logger.warn('Admin namespace 尚未初始化，忽略后台广播通知');
      return;
    }

    this.namespace.emit(SOCKET_EVENTS.notify, {
      ...payload,
      ts: Date.now(),
    });
  }

  // 广播订单更新消息，同时推送到全局和对应订单业务房间。
  emitOrderUpdated(payload: AdminOrderUpdatePayload) {
    if (!this.namespace) {
      this.logger.warn('Admin namespace 尚未初始化，忽略订单推送');
      return;
    }

    const message = {
      ...payload,
      ts: Date.now(),
    };

    this.namespace.emit(SOCKET_EVENTS.orderUpdated, message);
    this.namespace
      .to(buildBizRoom('order', payload.orderId))
      .emit(SOCKET_EVENTS.orderUpdated, message);
  }

  // 按用户房间定向推送订单更新，适合只通知特定后台账号。
  emitOrderUpdatedToUser(userId: string, payload: AdminOrderUpdatePayload) {
    if (!this.namespace) {
      this.logger.warn('Admin namespace 尚未初始化，忽略用户定向订单推送');
      return;
    }

    this.namespace.to(buildUserRoom(userId)).emit(SOCKET_EVENTS.orderUpdated, {
      ...payload,
      ts: Date.now(),
    });
  }

  // 向指定后台用户所在房间发送单播通知消息。
  emitNotifyToUser(userId: string, payload: Record<string, any>) {
    if (!this.namespace) {
      this.logger.warn('Admin namespace 尚未初始化，忽略后台通知推送');
      return;
    }

    this.namespace.to(buildUserRoom(userId)).emit(SOCKET_EVENTS.notify, {
      ...payload,
      ts: Date.now(),
    });
  }
}
