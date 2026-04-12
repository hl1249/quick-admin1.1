import {
  ConnectedSocket,
  MessageBody,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
  WsException,
} from '@nestjs/websockets';
import { Injectable, Logger } from '@nestjs/common';
import { Namespace, Socket } from 'socket.io';
import { ClientSocketService } from '../services/client-socket.service';
import {
  SOCKET_EVENTS,
  SOCKET_NAMESPACES,
  buildBizRoom,
  buildUserRoom,
} from '../constants/socket.constants';
import type {
  AuthenticatedSocket,
  ClientCartSyncPayload,
  ClientChatPayload,
  JoinBizRoomPayload,
} from '../types/socket.types';
import { WsAuthService } from '../services/ws-auth.service';

@Injectable()
@WebSocketGateway({
  namespace: SOCKET_NAMESPACES.client,
  cors: {
    origin: true,
    credentials: true,
  },
})
export class ClientGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  private readonly logger = new Logger(ClientGateway.name);

  @WebSocketServer()
  server!: Namespace;

  constructor(
    private readonly wsAuthService: WsAuthService,
    private readonly clientSocketService: ClientSocketService,
  ) {}

  // Gateway 初始化后保存前台命名空间实例，供其他模块复用推送能力。
  afterInit(server: Namespace) {
    this.clientSocketService.registerNamespace(server);
  }

  // 前台客户端连接时执行握手鉴权，并自动加入当前用户的专属房间。
  async handleConnection(client: Socket) {
    try {
      const authClient = await this.wsAuthService.authenticate(client, 'client');
      authClient.join(buildUserRoom(authClient.data.userInfo._id));
      this.logger.log(`client socket connected: ${authClient.id}`);
    } catch (error: any) {
      client.emit('exception', {
        message: error?.message || '连接鉴权失败',
      });
      client.disconnect();
    }
  }

  // 前台连接断开时记录日志，便于排查连接生命周期问题。
  handleDisconnect(client: Socket) {
    this.logger.log(`client socket disconnected: ${client.id}`);
  }

  @SubscribeMessage(SOCKET_EVENTS.ping)
  // 提供基础心跳检测能力，前端可据此确认连接仍然可用。
  handlePing(@ConnectedSocket() client: AuthenticatedSocket) {
    client.emit(SOCKET_EVENTS.pong, {
      ts: Date.now(),
      namespace: 'client',
    });
  }

  @SubscribeMessage(SOCKET_EVENTS.roomJoin)
  // 让前台客户端加入指定业务房间，以便接收对应范围内的实时消息。
  handleJoinRoom(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() payload: JoinBizRoomPayload,
  ) {
    const room = this.ensureRoomPayload(payload);
    client.join(room);
    return {
      room,
      joined: true,
    };
  }

  @SubscribeMessage(SOCKET_EVENTS.roomLeave)
  // 让前台客户端退出指定业务房间，停止接收该房间的广播消息。
  handleLeaveRoom(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() payload: JoinBizRoomPayload,
  ) {
    const room = this.ensureRoomPayload(payload);
    client.leave(room);
    return {
      room,
      joined: false,
    };
  }

  @SubscribeMessage(SOCKET_EVENTS.chatSend)
  // 校验房间归属后转发聊天消息，确保只有已加入房间的客户端才能发言。
  handleChatMessage(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() payload: ClientChatPayload,
  ) {
    const room = this.ensureRoomPayload(payload);
    this.ensureJoinedRoom(client, room);

    if (!payload.message?.trim()) {
      throw new WsException('消息内容不能为空');
    }

    this.clientSocketService.emitChatMessage(client, {
      ...payload,
      message: payload.message.trim(),
    });

    return {
      room,
      sent: true,
    };
  }

  @SubscribeMessage(SOCKET_EVENTS.cartSync)
  // 校验房间归属后同步购物车数据给同一业务房间内的其他客户端。
  handleCartSync(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() payload: ClientCartSyncPayload,
  ) {
    const room = this.ensureRoomPayload(payload);
    this.ensureJoinedRoom(client, room);

    this.clientSocketService.syncCart(client, payload);

    return {
      room,
      synced: true,
    };
  }

  // 校验业务房间参数并统一生成标准房间名。
  private ensureRoomPayload(payload: JoinBizRoomPayload) {
    if (!payload?.bizType || !payload?.bizId) {
      throw new WsException('bizType 和 bizId 不能为空');
    }

    return buildBizRoom(payload.bizType, payload.bizId);
  }

  // 确保当前连接已经加入目标房间，避免越权发送该房间消息。
  private ensureJoinedRoom(client: AuthenticatedSocket, room: string) {
    if (!client.rooms.has(room)) {
      throw new WsException('请先加入业务房间');
    }
  }
}
