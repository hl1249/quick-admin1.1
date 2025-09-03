import { Controller, Get,Post,Body } from '@nestjs/common';
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
  async login(@Body() userDto: UserDto): Promise <Document | null> {  
    console.log('userDto',userDto) 
    return await this.authService.login(userDto);
  }
}