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
  errors?: string[];
  [key: string]: any;  // 允许有其它字段
}

@Catch()
export class ExceptionsFilter implements ExceptionFilter {
  private readonly logger = new Logger(ExceptionsFilter.name);

  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    let status = HttpStatus.INTERNAL_SERVER_ERROR;
    let message = 'Internal server error';
    let errors: string[] = [];

    // 打印错误日志
    this.logger.error('错误拦截', exception);

    if (exception instanceof HttpException) {
      status = exception.getStatus();
      const res = exception.getResponse() as HttpExceptionResponse;

      if (res) {
        // 如果是 ValidationPipe 抛出的 BadRequestException
        if (res.errors && Array.isArray(res.errors)) {
          errors = res.errors;
          message = errors.join(', ');
        } else if (Array.isArray(res.message)) {
          errors = res.message;
          message = errors.join(', ');
        } else if (typeof res.message === 'string') {
          message = res.message;
        }
      }
    }

    // 为了安全，保证 exception 是 Error 类型
    const err = exception instanceof Error ? exception : null;

    const responseData = {
      code: 1,
      time: Date.now(),
      status,
      message,
      path: request.url,
      requestId: (request as any).requestId || null,
      ...(DEBUG ? {
        err: {
          message: err?.message || JSON.stringify(exception),
          stack: err?.stack,
        },
      }:[]),
    };

    response.status(status).json(responseData);
  }
}
