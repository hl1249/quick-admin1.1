import http from '@/utils/http';

export interface GetAppInfoParams {
  [key: string]: unknown;
}

export interface LoginByWeixinParams {
  appid: string;
  code: string;
}

export interface WeixinUserInfo {
  appid?: string;
  appname?: string;
  openid?: string;
  unionid?: string;
  nickname?: string;
  avatar?: string;
  [key: string]: unknown;
}

export interface LoginByWeixinResult {
  token?: string;
  expired?: number | null;
  userInfo?: WeixinUserInfo;
}

export const getAppInfo = (data?: GetAppInfoParams) => {
  return http.request({
    url: '/app/client/appid/appid/getAppInfo',
    method: 'POST',
    data,
  });
};

export const loginByWeixin = (data: LoginByWeixinParams) => {
  return http.request<LoginByWeixinResult>({
    url: '/app/client/user/user/loginByWeixin',
    method: 'POST',
    data,
  });
};
