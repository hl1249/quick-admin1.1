import { Controller, Get,Post } from '@nestjs/common';
@Controller()
export class SystemController {
  constructor(
  ) {
  }

  @Get('/system')
  info(): string {   
    return 'system info';
  }
}