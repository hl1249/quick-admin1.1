import { Controller, Get,Post } from '@nestjs/common';
import { Document } from 'mongodb'
import { authService } from './auth.service';
import { UserDto } from './auth.dto';
@Controller()
export class IndexController {
  constructor(
    private readonly authService: authService,
  ) {
  }

  @Post()
  login(userDto: UserDto): Promise<Document | null> {   
    return this.authService.login(userDto);
  }
}