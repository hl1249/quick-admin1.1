import { Socket } from 'socket.io';

export type SocketNamespaceKey = 'admin' | 'client';

export interface SocketUserInfo {
  _id: string;
  username?: string;
  nickname?: string;
  role?: string[];
  [key: string]: any;
}

export interface SocketSessionData {
  namespace: SocketNamespaceKey;
  token: string;
  userInfo: SocketUserInfo;
}

export type AuthenticatedSocket = Socket & {
  data: SocketSessionData;
};

export interface JoinBizRoomPayload {
  bizType: string;
  bizId: string;
}

export interface AdminOrderUpdatePayload {
  orderId: string;
  title?: string;
  message: string;
  level?: 'info' | 'warning' | 'urgent';
  operatorId?: string;
  extra?: Record<string, any>;
}

export interface ClientChatPayload extends JoinBizRoomPayload {
  message: string;
}

export interface ClientCartSyncPayload extends JoinBizRoomPayload {
  cart: Record<string, any>;
}
