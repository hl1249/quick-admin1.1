import { UseInterceptors } from '@nestjs/common';
import { LogInterceptor } from './logger.interceptor';

export function Log() {
  return UseInterceptors(LogInterceptor);
}
