import type { App, InjectionKey } from 'vue'
import { inject } from 'vue'
import type { AxiosRequestConfig, AxiosResponse } from 'axios'

export type QaRequest = (
  options: AxiosRequestConfig & { openMessage?: boolean },
) => Promise<AxiosResponse<any, any>>

export const qaRequestKey: InjectionKey<QaRequest> = Symbol('qa-request')

export const provideQaRequest = (app: App, request?: QaRequest) => {
  if (request) {
    app.provide(qaRequestKey, request)
  }
}

export const useQaRequest = () => {
  const request = inject(qaRequestKey)

  if (!request) {
    throw new Error('quickAdmin request is not provided. Use app.use(quickAdmin, { request }).')
  }

  return request
}
