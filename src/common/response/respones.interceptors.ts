import { Injectable, NestInterceptor, ExecutionContext, CallHandler } from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable()
export class ResponseInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const httpContext = context.switchToHttp();
    const request = httpContext.getRequest<Request>();
    const response = httpContext.getResponse();

    return next.handle().pipe(
      map(data => {
        if (response.statusCode === 201) {
          response.statusCode = 200;
        }

        return {
          code: 0,
          message: '成功!',
          data,
          requestId: (request as any).requestId || null,
        };
      }),
    );
  }
}
