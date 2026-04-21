import { defineStore } from "pinia";
import { ref } from "vue";

export interface AppInfo {
  appid?: string;
  appname?: string;
  [key: string]: unknown;
}

export const useAppInfoStore = defineStore(
  "appInfo",
  () => {
    const appInfo = ref<AppInfo>({});
    const loaded = ref(false);

    function setAppInfo(val: AppInfo) {
      appInfo.value = val;
      loaded.value = true;
    }

    function reset() {
      appInfo.value = {};
      loaded.value = false;
    }

    return {
      appInfo,
      loaded,
      setAppInfo,
      reset,
    };
  },
  {
    persist: {
      key: "appInfo",
      paths: ["appInfo"],
    },
  },
);
