import { defineStore } from "pinia";
import { ref, computed } from "vue";

export interface UserInfo {
  _id?: string;
  username?: string;
  avatar?: string;
  [key: string]: unknown;
}

export const useUserStore = defineStore(
  "user",
  () => {
    const token = ref<string>("");
    const userInfo = ref<UserInfo>({});

    const isLoggedIn = computed(() => Boolean(token.value));

    function setToken(val: string) {
      token.value = val;
    }

    function setUserInfo(val: UserInfo) {
      userInfo.value = val;
    }

    function logout() {
      token.value = "";
      userInfo.value = {};
    }

    return {
      token,
      userInfo,
      isLoggedIn,
      setToken,
      setUserInfo,
      logout,
    };
  },
  {
    persist: {
      key: "user",
      paths: ["token", "userInfo"],
    },
  },
);
