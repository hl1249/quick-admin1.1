import { Module } from '@nestjs/common';
import { JwtModule } from '@/common/jwt/jwt.module';
import { AdminGateway } from './gateways/admin.gateway';
import { ClientGateway } from './gateways/client.gateway';
import { WsAuthService } from './services/ws-auth.service';
import { AdminSocketService } from './services/admin-socket.service';
import { ClientSocketService } from './services/client-socket.service';

@Module({
  imports: [JwtModule],
  providers: [
    WsAuthService,
    AdminGateway,
    ClientGateway,
    AdminSocketService,
    ClientSocketService,
  ],
  exports: [AdminSocketService, ClientSocketService],
})
export class WebsocketModule {}
