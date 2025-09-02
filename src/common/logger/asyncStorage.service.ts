import { Injectable } from '@nestjs/common';
import { AsyncLocalStorage } from 'async_hooks';
import { v4 as uuidv4 } from 'uuid';

export interface RequestContext {
  requestId: string;
  [key: string]: any;
}

@Injectable()
export class AsyncStorageService {
  private readonly asyncLocalStorage = new AsyncLocalStorage<RequestContext>();

  run(callback: (...args: any[]) => any) {
    const context: RequestContext = { requestId: uuidv4() };
    this.asyncLocalStorage.run(context, callback);
  }

  getRequestId(): string {
    const store = this.asyncLocalStorage.getStore();
    return store?.requestId || '';
  }

  set(key: string, value: any) {
    const store = this.asyncLocalStorage.getStore();
    if (store) store[key] = value;
  }

  get<T = any>(key: string): T | undefined {
    const store = this.asyncLocalStorage.getStore();
    return store ? store[key] : undefined;
  }
}
