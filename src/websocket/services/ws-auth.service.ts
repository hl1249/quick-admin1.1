import {
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Socket } from 'socket.io';
import { AppConfigService } from '@/config/app-config.service';
import { JwtService } from '@/common/jwt/jwt.service';
import { DbService } from '@/common/db/db.service';
import { filterObject } from '@/common/utils/utils';
import {
  AuthenticatedSocket,
  SocketNamespaceKey,
  SocketUserInfo,
} from '../types/socket.types';

@Injectable()
export class WsAuthService {
  constructor(
    private readonly jwtService: JwtService,
    private readonly dbService: DbService,
    private readonly appConfig: AppConfigService,
  ) {}

  // 对 socket 握手信息做鉴权，并把安全后的用户信息挂到连接上下文中。
  async authenticate(
    client: Socket,
    namespace: SocketNamespaceKey,
  ): Promise<AuthenticatedSocket> {
    const token = this.extractToken(client);
    if (!token) {
      throw new UnauthorizedException('缺少身份认证信息');
    }

    const payload = this.jwtService.verifyToken(token);
    if (!payload?.userId) {
      throw new UnauthorizedException('身份认证已过期');
    }

    const userInfo = await this.dbService.findById({
      dbName: 'qa-users',
      id: payload.userId,
    });

    if (!userInfo?.token?.includes(token)) {
      throw new UnauthorizedException('身份认证已过期');
    }

    const safeUserInfo = filterObject(
      userInfo as Record<string, any>,
      ['password', 'token'],
      false,
    ) as SocketUserInfo;

    safeUserInfo._id =
      typeof userInfo._id?.toHexString === 'function'
        ? userInfo._id.toHexString()
        : String(userInfo._id);

    const authClient = client as AuthenticatedSocket;
    authClient.data = {
      namespace,
      token,
      userInfo: safeUserInfo,
    };

    return authClient;
  }

  // 按优先级从握手参数和请求头中提取 token，兼容多种前端传参方式。
  private extractToken(client: Socket): string | null {
    const handshakeAuth = client.handshake.auth as
      | { token?: unknown }
      | undefined;

    const authToken =
      typeof handshakeAuth?.token === 'string'
        ? handshakeAuth.token
        : null;

    if (authToken) {
      return this.normalizeToken(authToken);
    }

    const headerName = this.appConfig.authorizationHeader.toLowerCase();
    const headerValue = client.handshake.headers[headerName];
    if (typeof headerValue === 'string') {
      return this.normalizeToken(headerValue);
    }

    return null;
  }

  // 统一清洗 token 字符串，兼容裸 token 和 Bearer token 两种格式。
  private normalizeToken(source: string): string | null {
    const value = source.trim();
    if (!value) {
      return null;
    }

    if (!value.startsWith('Bearer ')) {
      return value;
    }

    const [, token] = value.split(' ');
    return token || null;
  }
}
