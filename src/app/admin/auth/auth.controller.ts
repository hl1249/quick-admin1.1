import { Controller, Get, Post, Body, Req, SetMetadata, Ip } from '@nestjs/common';
import { Document } from 'mongodb'
import { AuthService } from './auth.service';
import { UserDto, RegisterDto } from './auth.dto';
@Controller()
export class AuthController {
  constructor(
    private readonly authService: AuthService,
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

  @SetMetadata('skipPermission', true)
  @SetMetadata('skipAuth', true)
  @Post('/register')
  async register(
    @Body() registerDto: RegisterDto,
    @Ip() ipAddress: string,
  ): Promise<Document | null> {
    return await this.authService.register(registerDto, ipAddress);
  }


  @Get('/checkLogin')
  async checkLogin(@Req() req) {
    const { userInfo } = req;
    // 无用户信息或权限缓存版本不一致（已失效）时视为未登录，返回 false
    const cacheValid = userInfo
      ? await this.authService.isUserPermissionCacheValid(userInfo)
      : false;
    // return {
    //   isLogin:,
    // };
    return  !!userInfo && cacheValid;
  }

  // @SetMetadata("skipPermission", true) // 设置该路由不需要权限验证
  @Get('/getUserInfo')
  getUserInfo(@Req() req) {
    const { userInfo } = req;
    return userInfo
  }

  @SetMetadata("skipPermission", true) // 设置该路由不需要权限验证
  @Get('/getDynamicMenu')
  async getDynamicMenu(@Req() req) {
    return this.authService.getMenu(req)
  }
}