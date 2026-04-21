import { defineStore } from 'pinia';
import { computed, ref } from 'vue';
import {
  loginByWeixin as loginByWeixinApi,
  type LoginByWeixinResult,
} from '@/api/appid';
import { useAppInfoStore } from '@/store/appInfo';

export interface UserInfo {
  _id?: string;
  username?: string;
  avatar?: string;
  appid?: string;
  appname?: string;
  openid?: string;
  unionid?: string;
  [key: string]: unknown;
}

export const useUserStore = defineStore(
  'user',
  () => {
    const appInfoStore = useAppInfoStore();
    const token = ref<string>('');
    const openid = ref<string>('');
    const userInfo = ref<UserInfo>({});
    const loginLoading = ref(false);

    const isLoggedIn = computed(() =>
      Boolean(token.value || openid.value || userInfo.value.openid),
    );

    function setToken(val: string) {
      token.value = val;
    }

    function setOpenid(val: string) {
      openid.value = val;
    }

    function setUserInfo(val: UserInfo) {
      userInfo.value = val;
      openid.value = typeof val.openid === 'string' ? val.openid : '';
    }

    function logout() {
      token.value = '';
      openid.value = '';
      userInfo.value = {};
    }

    async function getWeixinLoginCode() {
      return new Promise<string>((resolve, reject) => {
        uni.login({
          success: (res) => {
            if (!res.code) {
              reject(new Error('微信登录失败，未获取到 code'));
              return;
            }
            resolve(res.code);
          },
          fail: (err: { errMsg?: string } | undefined) => {
            const message =
              typeof err?.errMsg === 'string' ? err.errMsg : '微信登录失败';
            reject(new Error(message));
          },
        });
      });
    }

    async function loginByWeixin(appid?: string) {
      const currentAppid = appid || String(appInfoStore.appInfo.appid || '');
      if (!currentAppid) {
        throw new Error('未获取到小程序 appid 配置');
      }

      loginLoading.value = true;
      try {
        const code = await getWeixinLoginCode();
        const response = await loginByWeixinApi({
          appid: currentAppid,
          code,
        });
        const loginResult = response.data as LoginByWeixinResult;
        const nextToken =
          typeof loginResult.token === 'string' ? loginResult.token : '';
        const nextLoginUserInfo = loginResult.userInfo || {};
        const nextUserInfo = {
          ...userInfo.value,
          ...nextLoginUserInfo,
        };
        setToken(nextToken);
        setUserInfo(nextUserInfo);
        return loginResult;
      } finally {
        loginLoading.value = false;
      }
    }

    return {
      token,
      openid,
      userInfo,
      loginLoading,
      isLoggedIn,
      setToken,
      setOpenid,
      setUserInfo,
      loginByWeixin,
      logout,
    };
  },
  {
    persist: {
      key: 'user',
      paths: ['token', 'openid', 'userInfo'],
    },
  },
);
