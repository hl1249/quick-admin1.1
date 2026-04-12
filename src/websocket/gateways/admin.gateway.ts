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
import { AdminSocketService } from '../services/admin-socket.service';
import {
  SOCKET_EVENTS,
  SOCKET_NAMESPACES,
  buildBizRoom,
  buildUserRoom,
} from '../constants/socket.constants';
import type {
  AuthenticatedSocket,
  JoinBizRoomPayload,
} from '../types/socket.types';
import { WsAuthService } from '../services/ws-auth.service';

@Injectable()
@WebSocketGateway({
  namespace: SOCKET_NAMESPACES.admin,
  cors: {
    origin: true,
    credentials: true,
  },
})
export class AdminGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  private readonly logger = new Logger(AdminGateway.name);

  @WebSocketServer()
  server!: Namespace;

  constructor(
    private readonly wsAuthService: WsAuthService,
    private readonly adminSocketService: AdminSocketService,
  ) {}

  // Gateway 初始化后，把当前后台命名空间实例交给 service 保存，便于其他业务模块主动推送消息。
  afterInit(server: Namespace) {
    this.adminSocketService.registerNamespace(server);
  }

  // 后台客户端建立连接时先做握手鉴权，鉴权通过后自动加入当前用户专属房间。
  async handleConnection(client: Socket) {
    try {
      const authClient = await this.wsAuthService.authenticate(client, 'admin');
      authClient.join(buildUserRoom(authClient.data.userInfo._id));
      this.adminSocketService.registerConnection(authClient);
      this.logger.log(`admin socket connected: ${authClient.id}`);
    } catch (error: any) {
      client.emit('exception', {
        message: error?.message || '连接鉴权失败',
      });
      client.disconnect();
    }
  }

  // 后台连接断开时记录日志，便于排查在线状态和连接稳定性问题。
  handleDisconnect(client: Socket) {
    this.adminSocketService.unregisterConnection(client.id);
    this.logger.log(`admin socket disconnected: ${client.id}`);
  }

  @SubscribeMessage(SOCKET_EVENTS.ping)
  // 基础心跳检测接口，前端可用它确认后台命名空间是否已连通。
  handlePing(@ConnectedSocket() client: AuthenticatedSocket) {
    client.emit(SOCKET_EVENTS.pong, {
      ts: Date.now(),
      namespace: 'admin',
    });
  }

  @SubscribeMessage(SOCKET_EVENTS.roomJoin)
  // 让后台客户端加入某个业务房间，便于按订单、项目等业务维度接收推送。
  handleJoinRoom(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() payload: JoinBizRoomPayload,
  ) {
    const room = this.ensureBizRoomPayload(payload);
    client.join(room);
    return {
      room,
      joined: true,
    };
  }

  @SubscribeMessage(SOCKET_EVENTS.roomLeave)
  // 让后台客户端退出某个业务房间，避免继续接收该业务范围内的广播消息。
  handleLeaveRoom(
    @ConnectedSocket() client: AuthenticatedSocket,
    @MessageBody() payload: JoinBizRoomPayload,
  ) {
    const room = this.ensureBizRoomPayload(payload);
    client.leave(room);
    return {
      room,
      joined: false,
    };
  }

  // 校验业务房间参数是否合法，并统一生成标准房间名 `biz:{bizType}:{bizId}`。
  private ensureBizRoomPayload(payload: JoinBizRoomPayload) {
    if (!payload?.bizType || !payload?.bizId) {
      throw new WsException('bizType 和 bizId 不能为空');
    }

    return buildBizRoom(payload.bizType, payload.bizId);
  }
}
