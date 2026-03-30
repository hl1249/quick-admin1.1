import axios from 'axios'
import type { AxiosInstance, AxiosRequestConfig } from 'axios'
import { ElMessage } from 'element-plus'
import { useStore } from '@/store'
import { AUTHORIZATION } from '@/config'
import router from '@/router'

export const getUrl = (): string => {
  const value: string = import.meta.env.VITE_AXIOS_BASE_URL as string
  return value == 'getCurrentDomain' ? window.location.protocol + '//' + window.location.host + '/api' : value
}

class HttpRequest {
  private baseURL: string
  private queue: { [key: string]: boolean } = {} // 存储请求队列
  constructor(baseURL = getUrl()) {
    this.baseURL = baseURL!
    this.queue = {}
  }

  destroy(url = '') {
    delete this.queue[url]
  }

  getInsidConfig() {
    return {
      baseURL: this.baseURL,
      withCredentials: true,
    }
  }

  errorCode(code: number, res?: any, openMessage = true) {
    if (!openMessage) return
    const errorCodeMap: { [key: number]: (res: any) => void } = {
      10: res => {
        this.errorMessag(res.data.message || 'token过期，请重新登录', openMessage)
      },
      100: res => {
        this.errorMessag(res.data.message || '这个接口无权限', openMessage)
      }
    }

    errorCodeMap[code] && errorCodeMap[code](res)
  }

  httpErrorCode(code: number, res?: any, openMessage = true) {

    const httpErrorMap: { [key: number]: (res: any) => void } = {
      404: (res: any) => {
        this.errorMessag(res.data.message || '请求资源不存在', openMessage)
      },
      500: (res: any) => {
        this.errorMessag(res.data.message || '服务器内部错误')
      },
      400: (res: any) => {
        this.errorMessag(res.data.message || '请求错误', openMessage)
      },
      401: (res: any) => {
        this.errorMessag(res.data.message || '身份认证已过期', openMessage)
        router.push('/login')
      },
      403: (res: any) => {
        this.errorMessag(res.data.message || '没有权限访问该接口', openMessage)
      }
    }

    httpErrorMap[code] && httpErrorMap[code](res)
  }

  interceptors(instance: AxiosInstance, url: string, openMessage: boolean) {

    instance.interceptors.request.use(
      config => {
        // 在发送请求之前做些什么
        this.queue[url] = true

        const { authStore } = useStore()

        const { token, expired, logout } = authStore
        if (token && expired) {
          if (expired < new Date().getTime()) {
            logout()
            return Promise.reject('token已过期')
          }
        }
        config.headers[AUTHORIZATION] = `Bearer ${token}`;
        const hasContentType = Boolean(config.headers['Content-Type'] || config.headers['content-type'])
        if (!hasContentType && !(config.data instanceof FormData)) {
          config.headers['Content-Type'] = 'application/json';
        }
        return config
      },
      error => {
        // 对请求错误做些什么
        return Promise.reject(error)
      },
    )

    instance.interceptors.response.use(
      response => {
        // 对响应数据做点什么
        this.destroy(url)
        const { data: { code, message } } = response
        this.errorCode(code, message, openMessage)
        return response
      },
      error => {
        this.destroy(url)
        if (!error.response) {
          if (!openMessage) {
            ElMessage({
              message: "本地请求失败，请检查网络连接",
              type: 'error',
            })
          }

          return Promise.reject(error)
        }
        const { status } = error.response

        this.httpErrorCode(status, error.response, openMessage)
        return Promise.reject(error)

      },
    )
  }

  errorMessag(message: string, openMessage = true) {
    if (openMessage) ElMessage.error(message)
  }

  request(options: AxiosRequestConfig & { openMessage?: boolean }) {
    const instance = axios.create()
    const { openMessage = true } = options
    options = Object.assign(this.getInsidConfig(), options)
    this.interceptors(instance, options.url!, openMessage)
    return instance(options)
  }
}

export default new HttpRequest()