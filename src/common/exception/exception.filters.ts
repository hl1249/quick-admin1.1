import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
  Logger
} from '@nestjs/common';
import { Request, Response } from 'express';

import { DEBUG } from '@/config';

interface HttpExceptionResponse {
  message?: string | string[];
  [key: string]: any;  // 允许有其它字段
}

@Catch()
export class ExceptionsFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    let logger = new Logger(ExceptionsFilter.name);

    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    let status = HttpStatus.INTERNAL_SERVER_ERROR;
    let message = 'Internal server error';

    logger.error('错误拦截', exception);

    if (exception instanceof HttpException) {
      status = exception.getStatus();
      const res = exception.getResponse() as HttpExceptionResponse;;

      if (typeof res === 'string') {
        message = res;
      } else if (res && typeof res === 'object') {
        // res 可能是 { message: string | string[]; ... }
        if (Array.isArray(res.message)) {
          message = res.message.join(', ');
        } else if (typeof res.message === 'string') {
          message = res.message;
        }
      }
    }

    // 为了安全，断言 exception 是 Error 类型（否则 message 和 stack 可能不存在）
    const err = exception instanceof Error ? exception : null;

    const responseData = {
      code: 1,
      time: Date.now(),
      status,
      message,
      path: request.url,
      requestId: (request as any).requestId || null,
      ...(DEBUG && {
        err: {
          message: err?.message || JSON.stringify(exception),
          stack: err?.stack,
        },
      }),
    };

    response.status(status).json(responseData);
  }
}
