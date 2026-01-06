import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
  Logger,
  BadRequestException,
} from '@nestjs/common';
import { Request, Response } from 'express';

import { DEBUG } from '@/config';

interface HttpExceptionResponse {
  message?: string | string[];
  errors?: string[];
  [key: string]: any;
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
    let data: any = null;
    let customCode = 1; // 默认错误code

    // 打印错误日志
    this.logger.error('错误拦截', exception);

    if (exception instanceof HttpException) {
      status = exception.getStatus();
      const res = exception.getResponse() as HttpExceptionResponse;

      if (res) {
        // 检查是否有自定义的code（从自定义异常中）
        if (res.code !== undefined) {
          customCode = res.code;
        }

        // 检查是否有自定义的msg
        if (res.msg !== undefined) {
          message = res.msg;
        } else if (res.message !== undefined) {
          // 兼容原始的message字段
          message = typeof res.message === 'string' ? res.message : '请求错误';
        }

        // 处理错误详情
        if (res.errors && Array.isArray(res.errors)) {
          errors = res.errors;
          data = { errors };
        } else if (res.data) {
          data = res.data;
        } else if (Array.isArray(res.message)) {
          errors = res.message;
          message = errors.join(', ');
          data = { errors };
        }
      }

      // 关键修改：如果是400错误（通常是字段校验），强制返回200状态码
      if (status === HttpStatus.BAD_REQUEST) {
        status = HttpStatus.OK; // 改为200
      }
    }

    // 为了安全，保证 exception 是 Error 类型
    const err = exception instanceof Error ? exception : null;

    const responseData = {
      success: false,
      code: customCode,
      msg: message,
      data: data || null,
      time: Date.now(),
      path: request.url,
      requestId: (request as any).requestId || null,
      ...(DEBUG
        ? {
            err: {
              message: err?.message || JSON.stringify(exception),
              stack: err?.stack,
            },
          }
        : {}),
    };

    response.status(status).json(responseData);
  }
}
