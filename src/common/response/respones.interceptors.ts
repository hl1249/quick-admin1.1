// 全局响应封装
import { Injectable } from '@nestjs/common';
import { map } from 'rxjs/operators';

@Injectable()
export class ResponseInterceptor {
  intercept(context: any, next: any) {
    return next.handle().pipe(
      map(data => {
        return {
          code: 0,
          message: '成功!',
          data: data,
        };
      }),
    );
  }
}