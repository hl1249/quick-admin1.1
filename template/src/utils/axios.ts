import axios from 'axios'
import type { AxiosInstance, InternalAxiosRequestConfig,AxiosResponse,AxiosRequestConfig } from 'axios'
import { ElMessage } from 'element-plus'
import { useStore } from '@/store'
import { AUTHORIZATION } from '@/config'

export const getUrl = (): string => {
    const value: string = import.meta.env.VITE_AXIOS_BASE_URL as string
    return value == 'getCurrentDomain' ? window.location.protocol + '//' + window.location.host : value
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
    const config = {
      baseURL: this.baseURL,
      withCredentials: true,
    }
    return config
  }

  errorCode(code: number, res?: any) {
    const errorCodeMap: { [key: number]: (res: any) => void } = {
      10: res => {
        ElMessage.error(res.data.message || 'token过期，请重新登录')
      },
      100: res => {
        ElMessage.error(res.data.message || '这个接口无权限')
      }
    }

     errorCodeMap[code] && errorCodeMap[code](res)
  }

  httpErrorCode(code: number, res?: any) {
    const httpErrorMap: { [key: number]: (res: any) => void } = {
      404: (res: any) => {
        ElMessage.error(res.data.message || '请求资源不存在')
      },
      500: (res: any) => {
        ElMessage.error(res.data.message || '服务器内部错误')
      },
      400: (res: any) => {
        ElMessage.error(res.data.message || '请求错误')
      },
      401: (res: any) => {
        ElMessage.error(res.data.message || '身份认证已过期')
      },
      403: (res: any) => {
        ElMessage.error(res.data.message || '没有权限访问该接口')
      }
    }

    httpErrorMap[code] && httpErrorMap[code](res)
  }

  interceptors(instance: AxiosInstance, url: string) {

    instance.interceptors.request.use(
      config => {
        // 在发送请求之前做些什么
        this.queue[url] = true

        const { userStore } = useStore()
        
        const { token, expired, logout } = userStore
        if (token && expired) {
          if (expired < new Date().getTime()) {
            userStore.logout()
            return Promise.reject('token已过期')
          }
        }
        config.headers[AUTHORIZATION] = token;
        config.headers['Content-Type'] = 'application/json';
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
        this.errorCode(code,message)
        return response
      },
      error => {
        this.destroy(url)
        if (!error.response) {
          ElMessage({
            message: "本地请求失败，请检查网络连接",
            type: 'error',
          })
          return Promise.reject(error)
        }
        const { status } = error.response

        this.httpErrorCode(status, error.response)

        return Promise.reject(error)

      },
    )
  }

  request(options: AxiosRequestConfig) {
    const instance = axios.create()
    options = Object.assign(this.getInsidConfig(), options)
    this.interceptors(instance, options.url!)
    return instance(options)
  }
}

export default new HttpRequest()