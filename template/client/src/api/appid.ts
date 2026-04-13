import http from "@/utils/http";

export interface GetAppInfoParams {
  [key: string]: unknown;
}

export const getAppInfo = (data?: GetAppInfoParams) => {
  return http.request({
    url: "/app/client/appid/appid/getAppInfo",
    method: "POST",
    data,
  });
};
