import { Controller, Get,Post } from '@nestjs/common';
import { Document } from 'mongodb'
import { authService } from './auth.service';
import { UserDto } from './auth.dto';
@Controller()
export class AuthController {
  constructor(
    private readonly authService: authService,
  ) {
  }

  @Post('/login')
  async login(userDto: UserDto): Promise <Document | null> {   
    return await this.authService.login();
  }
}