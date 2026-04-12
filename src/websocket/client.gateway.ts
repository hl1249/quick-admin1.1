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
import { ClientSocketService } from './client-socket.service';
import { SOCKET_EVENTS, SOCKET_NAMESPACES, buildBizRoom, buildUserRoom } from './socket.constants';
import type {
  AuthenticatedSocket,
  ClientCartSyncPayload,
  ClientChatPayload,
  JoinBizRoomPayload,
} from './socket.types';
import { WsAuthService } from './ws-auth.service';

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

  afterInit(server: Namespace) {
    this.clientSocketService.registerNamespace(server);
  }

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

  handleDisconnect(client: Socket) {
    this.logger.log(`client socket disconnected: ${client.id}`);
  }

  @SubscribeMessage(SOCKET_EVENTS.ping)
  handlePing(@ConnectedSocket() client: AuthenticatedSocket) {
    client.emit(SOCKET_EVENTS.pong, {
      ts: Date.now(),
      namespace: 'client',
    });
  }

  @SubscribeMessage(SOCKET_EVENTS.roomJoin)
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

  private ensureRoomPayload(payload: JoinBizRoomPayload) {
    if (!payload?.bizType || !payload?.bizId) {
      throw new WsException('bizType 和 bizId 不能为空');
    }

    return buildBizRoom(payload.bizType, payload.bizId);
  }

  private ensureJoinedRoom(client: AuthenticatedSocket, room: string) {
    if (!client.rooms.has(room)) {
      throw new WsException('请先加入业务房间');
    }
  }
}
