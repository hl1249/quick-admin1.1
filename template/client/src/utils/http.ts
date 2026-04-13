const AUTHORIZATION = "Authorization";
const TOKEN_STORAGE_KEY = "token";
const DEFAULT_TIMEOUT = 10000;

type RequestMethod = NonNullable<UniApp.RequestOptions["method"]>;
type RequestData = UniApp.RequestOptions["data"];
type RequestHeader = UniApp.RequestOptions["header"];

export interface HttpRequestOptions extends UniApp.RequestOptions {
  baseURL?: string;
  openMessage?: boolean;
  params?: Record<string, string | number | boolean | null | undefined>;
}

export const getUrl = (): string => {
  const value = import.meta.env.VITE_SERVER_BASEURL as string | undefined;
  if (!value) return "";
  if (value === "getCurrentDomain" && typeof window !== "undefined") {
    return `${window.location.protocol}//${window.location.host}/api`;
  }
  return value;
};

class HttpRequest {
  private baseURL: string;

  private queue: Record<string, boolean>;

  constructor(baseURL = getUrl()) {
    this.baseURL = baseURL;
    this.queue = {};
  }

  destroy(url = "") {
    delete this.queue[url];
  }

  getInsideConfig() {
    return {
      baseURL: this.baseURL,
      timeout: DEFAULT_TIMEOUT,
      header: {},
    };
  }

  errorMessage(message: string, openMessage = true) {
    if (!openMessage) return;
    uni.showToast({
      title: message,
      icon: "none",
      duration: 2000,
    });
  }

  errorCode(code: number, response?: UniApp.RequestSuccessCallbackResult, openMessage = true) {
    const errorCodeMap: Record<number, () => void> = {
      10: () => {
        uni.removeStorageSync(TOKEN_STORAGE_KEY);
        this.errorMessage(this.getResponseMessage(response) || "token过期，请重新登录", openMessage);
      },
      100: () => {
        this.errorMessage(this.getResponseMessage(response) || "这个接口无权限", openMessage);
      },
    };

    errorCodeMap[code]?.();
  }

  httpErrorCode(code: number, response?: UniApp.RequestSuccessCallbackResult, openMessage = true) {
    const httpErrorMap: Record<number, () => void> = {
      400: () => {
        this.errorMessage(this.getResponseMessage(response) || "请求错误", openMessage);
      },
      401: () => {
        uni.removeStorageSync(TOKEN_STORAGE_KEY);
        this.errorMessage(this.getResponseMessage(response) || "身份认证已过期", openMessage);
      },
      403: () => {
        this.errorMessage(this.getResponseMessage(response) || "没有权限访问该接口", openMessage);
      },
      404: () => {
        this.errorMessage(this.getResponseMessage(response) || "请求资源不存在", openMessage);
      },
      500: () => {
        this.errorMessage(this.getResponseMessage(response) || "服务器内部错误", openMessage);
      },
    };

    httpErrorMap[code]?.();
  }

  private getToken() {
    const token = uni.getStorageSync(TOKEN_STORAGE_KEY) as string | undefined;
    if (!token) return "";
    return token.startsWith("Bearer ") ? token : `Bearer ${token}`;
  }

  private getResponseMessage(response?: UniApp.RequestSuccessCallbackResult) {
    const data = response?.data as { message?: string } | undefined;
    return data?.message;
  }

  private buildUrl(url: string, baseURL: string, params?: HttpRequestOptions["params"]) {
    const normalizedUrl = /^https?:\/\//.test(url) ? url : `${baseURL.replace(/\/$/, "")}/${url.replace(/^\//, "")}`;

    if (!params || Object.keys(params).length === 0) {
      return normalizedUrl;
    }

    const searchParams = Object.entries(params).reduce((result, [key, value]) => {
      if (value !== undefined && value !== null) {
        result.append(key, String(value));
      }
      return result;
    }, new URLSearchParams());

    const separator = normalizedUrl.includes("?") ? "&" : "?";
    return `${normalizedUrl}${separator}${searchParams.toString()}`;
  }

  private getRequestHeader(header?: RequestHeader, data?: RequestData) {
    const requestHeader: Record<string, string> = {
      ...(header as Record<string, string> | undefined),
    };

    const token = this.getToken();
    if (token) {
      requestHeader[AUTHORIZATION] = token;
    }

    const hasContentType = Boolean(requestHeader["Content-Type"] || requestHeader["content-type"]);
    const isFormData = typeof FormData !== "undefined" && data instanceof FormData;
    if (!hasContentType && !isFormData) {
      requestHeader["Content-Type"] = "application/json";
    }

    return requestHeader;
  }

  request<T = unknown>(options: HttpRequestOptions) {
    const mergedOptions = {
      ...this.getInsideConfig(),
      ...options,
    };
    const { openMessage = true, url = "", baseURL = this.baseURL, params, data, header, ...restOptions } = mergedOptions;
    const requestUrl = this.buildUrl(url, baseURL, params);
    const requestHeader = this.getRequestHeader(header, data);

    this.queue[requestUrl] = true;

    return new Promise<UniApp.RequestSuccessCallbackResult & { data: T }>((resolve, reject) => {
      uni.request({
        ...restOptions,
        url: requestUrl,
        data,
        header: requestHeader,
        success: response => {
          this.destroy(requestUrl);

          if (response.statusCode < 200 || response.statusCode >= 300) {
            this.httpErrorCode(response.statusCode, response, openMessage);
            reject(response);
            return;
          }

          if (restOptions.responseType !== "arraybuffer") {
            const responseData = response.data as { code?: number } | undefined;
            if (typeof responseData?.code === "number") {
              this.errorCode(responseData.code, response, openMessage);
            }
          }

          resolve(response as UniApp.RequestSuccessCallbackResult & { data: T });
        },
        fail: error => {
          this.destroy(requestUrl);
          this.errorMessage("本地请求失败，请检查网络连接", openMessage);
          reject(error);
        },
      });
    });
  }

  get<T = unknown>(url: string, options: Omit<HttpRequestOptions, "url" | "method"> = {}) {
    return this.request<T>({
      ...options,
      url,
      method: "GET" as RequestMethod,
    });
  }

  post<T = unknown>(url: string, data?: RequestData, options: Omit<HttpRequestOptions, "url" | "method" | "data"> = {}) {
    return this.request<T>({
      ...options,
      url,
      data,
      method: "POST" as RequestMethod,
    });
  }

  put<T = unknown>(url: string, data?: RequestData, options: Omit<HttpRequestOptions, "url" | "method" | "data"> = {}) {
    return this.request<T>({
      ...options,
      url,
      data,
      method: "PUT" as RequestMethod,
    });
  }

  delete<T = unknown>(url: string, options: Omit<HttpRequestOptions, "url" | "method"> = {}) {
    return this.request<T>({
      ...options,
      url,
      method: "DELETE" as RequestMethod,
    });
  }
}

export default new HttpRequest();
