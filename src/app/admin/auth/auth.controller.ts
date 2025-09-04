import { Controller, Get, Post, Body, Req, SetMetadata, Ip } from '@nestjs/common';
import { Document } from 'mongodb'
import { authService } from './auth.service';
import { UserDto } from './auth.dto';
@Controller()
export class AuthController {
  constructor(
    private readonly authService: authService,
  ) {
  }

  @SetMetadata('isNoAuth', true) // 设置该路由不需要验证
  @Post('/login')
  async login(
    @Body() userDto: UserDto, 
    @Ip() ipAddress: string,
  ): Promise<Document | null> {
    console.log('userDto', userDto)
    return await this.authService.login(userDto, ipAddress);
  }

  @Get('/getUserInfo')
  getUserInfo(@Req() req) {
    const { userInfo } = req;
    return userInfo
  }
}