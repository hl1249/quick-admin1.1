import { Injectable, Logger } from '@nestjs/common';
import { Namespace, Socket } from 'socket.io';
import {
  AdminOrderUpdatePayload,
  AuthenticatedSocket,
} from '../types/socket.types';
import {
  SOCKET_EVENTS,
  buildBizRoom,
  buildUserRoom,
} from '../constants/socket.constants';

interface AdminSocketConnectionRecord {
  socket: AuthenticatedSocket;
  connectedAt: number;
}

export interface AdminSocketConnectionItem {
  topic: string;
  namespace: string;
  socketId: string;
  userId: string;
  username: string;
  nickname: string;
  rooms: string[];
  connectedAt: number;
  connectedAtText: string;
  ageMs: number;
  ageText: string;
}

export interface AdminSocketConnectionQuery {
  topic?: string;
  socketId?: string;
  userId?: string;
  username?: string;
  nickname?: string;
  pageIndex?: number;
  pageSize?: number;
}

@Injectable()
export class AdminSocketService {
  private readonly logger = new Logger(AdminSocketService.name);
  private namespace?: Namespace;
  private readonly connectionPool = new Map<string, AdminSocketConnectionRecord>();

  // 在 Gateway 初始化后注册后台命名空间，供其他业务模块复用同一个推送出口。
  registerNamespace(namespace: Namespace) {
    this.namespace = namespace;
  }

  registerConnection(client: AuthenticatedSocket) {
    this.connectionPool.set(client.id, {
      socket: client,
      connectedAt: Date.now(),
    });
  }

  unregisterConnection(socketId: string) {
    this.connectionPool.delete(socketId);
  }

  getConnectionList(query: AdminSocketConnectionQuery = {}) {
    const {
      topic = '',
      socketId = '',
      userId = '',
      username = '',
      nickname = '',
      pageIndex = 1,
      pageSize = 10,
    } = query;

    const keywordTopic = topic.trim().toLowerCase();
    const keywordSocketId = socketId.trim().toLowerCase();
    const keywordUserId = userId.trim().toLowerCase();
    const keywordUsername = username.trim().toLowerCase();
    const keywordNickname = nickname.trim().toLowerCase();

    const list = Array.from(this.connectionPool.values())
      .map(record => this.toConnectionItem(record))
      .filter(item => {
        if (keywordTopic && !item.topic.toLowerCase().includes(keywordTopic)) return false;
        if (keywordSocketId && !item.socketId.toLowerCase().includes(keywordSocketId)) return false;
        if (keywordUserId && !item.userId.toLowerCase().includes(keywordUserId)) return false;
        if (keywordUsername && !item.username.toLowerCase().includes(keywordUsername)) return false;
        if (keywordNickname && !item.nickname.toLowerCase().includes(keywordNickname)) return false;
        return true;
      })
      .sort((a, b) => b.connectedAt - a.connectedAt);

    const safePageIndex = Number(pageIndex) > 0 ? Number(pageIndex) : 1;
    const safePageSize = Number(pageSize) > 0 ? Number(pageSize) : 10;
    const start = (safePageIndex - 1) * safePageSize;
    const rows = list.slice(start, start + safePageSize);

    return {
      rows,
      list,
      total: list.length,
      pageIndex: safePageIndex,
      pageSize: safePageSize,
    };
  }

  disconnectConnection(socketId: string) {
    const record = this.connectionPool.get(socketId);
    if (!record) {
      return {
        disconnected: false,
        socketId,
      };
    }

    record.socket.emit('exception', {
      message: '管理员已主动断开当前 Socket 连接',
      socketId,
      ts: Date.now(),
    });
    record.socket.disconnect(true);
    this.connectionPool.delete(socketId);

    return {
      disconnected: true,
      socketId,
      userId: record.socket.data.userInfo._id,
    };
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

  // 向指定业务房间发送通知，适合按群组/业务维度做定向广播。
  emitNotifyToBizRoom(
    bizType: string,
    bizId: string,
    payload: Record<string, any>,
  ) {
    if (!this.namespace) {
      this.logger.warn('Admin namespace 尚未初始化，忽略业务房间通知推送');
      return;
    }

    this.namespace.to(buildBizRoom(bizType, bizId)).emit(SOCKET_EVENTS.notify, {
      ...payload,
      ts: Date.now(),
    });
  }

  private toConnectionItem(record: AdminSocketConnectionRecord): AdminSocketConnectionItem {
    const { socket, connectedAt } = record;
    const rooms = this.getSocketRooms(socket);
    const ageMs = Math.max(Date.now() - connectedAt, 0);
    const userInfo = socket.data?.userInfo || { _id: '' };

    return {
      topic: rooms.join(', ') || socket.nsp.name,
      namespace: socket.nsp.name,
      socketId: socket.id,
      userId: userInfo._id,
      username: String(userInfo.username || ''),
      nickname: String(userInfo.nickname || ''),
      rooms,
      connectedAt,
      connectedAtText: this.formatDateTime(connectedAt),
      ageMs,
      ageText: this.formatDuration(ageMs),
    };
  }

  private getSocketRooms(socket: Socket) {
    return Array.from(socket.rooms).filter(room => room !== socket.id);
  }

  private formatDateTime(timestamp: number) {
    const date = new Date(timestamp);
    const pad = (value: number) => String(value).padStart(2, '0');

    return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} ${pad(
      date.getHours(),
    )}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`;
  }

  private formatDuration(durationMs: number) {
    const totalSeconds = Math.floor(durationMs / 1000);
    const days = Math.floor(totalSeconds / 86400);
    const hours = Math.floor((totalSeconds % 86400) / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;
    const parts: string[] = [];

    if (days > 0) parts.push(`${days}天`);
    if (hours > 0) parts.push(`${hours}小时`);
    if (minutes > 0) parts.push(`${minutes}分钟`);
    if (seconds > 0 || parts.length === 0) parts.push(`${seconds}秒`);

    return parts.join(' ');
  }
}
