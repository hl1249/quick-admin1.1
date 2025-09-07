import { Controller, Get, Post, Body, Req, SetMetadata, Ip } from '@nestjs/common';
import { Document } from 'mongodb'
import { authService } from './auth.service';
import { UserDto } from './auth.dto';
import { Log } from '@/common/logger/logger.decorator'
@Controller()
export class AuthController {
  constructor(
    private readonly authService: authService,
  ) {
  }

  // @Log() 是否对该接口记录日志
  @SetMetadata("skipPermission", true) // 设置该路由不需要权限验证
  @SetMetadata('skipAuth', true) // 设置该路由不需要验证token
  @Post('/login')
  async login(
    @Body() userDto: UserDto, 
    @Ip() ipAddress: string,
  ): Promise<Document | null> {
    return await this.authService.login(userDto, ipAddress);
  }

  @Get('/checkLogin')
  async checkLogin(@Req() req) {
      const {userInfo} = req
      return {
        isLogin:!!userInfo
      }
  }

  // @SetMetadata("skipPermission", true) // 设置该路由不需要权限验证
  @Get('/getUserInfo')
  getUserInfo(@Req() req) {
    const { userInfo } = req;
    return userInfo
  }

  @Get('/getDynamicMenu')
  async getDynamicMenu(@Req() req) {
        return this.authService.getMenu(req)
  }
}