import { Injectable, NestInterceptor, ExecutionContext, CallHandler } from '@nestjs/common';
import { Observable, from } from 'rxjs';
import { mergeMap, tap, catchError } from 'rxjs/operators';
import { AsyncStorageService } from './asyncStorage.service';
import { LOG_DB_NAME } from '@/config';
import { _ } from '@/common/utils/fieldQueryTemp';
import { DbService } from '@/common/utils/db.service';

@Injectable()
export class LogInterceptor implements NestInterceptor {
    constructor(
        private readonly asyncStorageService: AsyncStorageService,
        private readonly dbService: DbService,
    ) { }

    intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
        const req = context.switchToHttp().getRequest();
        const res = context.switchToHttp().getResponse();
        const headers = req.headers;
        const method = req.method;
        const url = req.url;
        const body = req.body;

        console.log(`[Log] Incoming Request: ${method} ${url}`);

        // 在 AsyncLocalStorage 里创建上下文
        return new Observable(observer => {
            this.asyncStorageService.run(async () => {
                const requestId = this.asyncStorageService.getRequestId();
                req.requestId = requestId;

                await this.dbService.add({
                    dbName: LOG_DB_NAME,
                    dataJson: {
                        url,
                        method,
                        statusCode: 0,
                        headers,
                        body,
                        requestId,
                    }
                })

                // 确认响应码
                res.on('finish', async () => {
                    const statusCode = res.statusCode;
                    await this.dbService.update({
                        dbName: LOG_DB_NAME,
                        whereJson: {
                            requestId
                        },
                        dataJson: {
                            statusCode
                        }
                    })

                });

                next.handle().pipe(
                    mergeMap((data) => {
                        // 返回值分支做异步记录
                        return from(saveDb(requestId, data)).pipe(
                            tap(() => console.log('日志入库完成')),
                            mergeMap(() => [data]) // 继续传递返回值
                        );
                    }),
                    catchError(async (err) => {
                        console.log('异步记录异常', JSON.stringify(err));
                        await saveDb(requestId, err); // 异步记录异常
                        throw err; // 继续抛出异常
                    })
                ).subscribe({
                    next: (data) => {
                        observer.next(data)
                    },
                    error: (err) => {
                        observer.error(err)
                    },
                    complete: () => {
                        console.log(`[${requestId}] Request ${method} ${url} completed`);
                        observer.complete();
                    }
                });

                const saveDb = (requestId, data) => {
                    return this.dbService.update({
                        dbName: LOG_DB_NAME,
                        whereJson: {
                            requestId: requestId
                        },
                        dataJson: {
                            response: data,
                        }
                    })
                }
            });
        });
    }
}
