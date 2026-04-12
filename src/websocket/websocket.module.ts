import { Module } from '@nestjs/common';
import { JwtModule } from '@/common/jwt/jwt.module';
import { AdminGateway } from './admin.gateway';
import { ClientGateway } from './client.gateway';
import { WsAuthService } from './ws-auth.service';
import { AdminSocketService } from './admin-socket.service';
import { ClientSocketService } from './client-socket.service';

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
