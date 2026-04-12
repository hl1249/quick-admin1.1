import { Injectable, Logger } from '@nestjs/common';
import { Namespace } from 'socket.io';
import {
  AdminOrderUpdatePayload,
} from './socket.types';
import {
  SOCKET_EVENTS,
  buildBizRoom,
  buildUserRoom,
} from './socket.constants';

@Injectable()
export class AdminSocketService {
  private readonly logger = new Logger(AdminSocketService.name);
  private namespace?: Namespace;

  registerNamespace(namespace: Namespace) {
    this.namespace = namespace;
  }

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
