<script setup lang="ts">
import { onLaunch, onShow, onHide } from "@dcloudio/uni-app";
import { getAppInfo } from "@/api/appid";
import { useAppInfoStore } from "@/store/appInfo";

const appInfoStore = useAppInfoStore();

onLaunch(() => {
  const appid = import.meta.env.VITE_WX_APPID;
  if (appid) {
    getAppInfo({ appid }).then((res) => {
      const data = (res.data as { data?: unknown })?.data;
      if (data) {
        appInfoStore.setAppInfo(data as Record<string, unknown>);
      }
    });
  }
});

onShow(() => {
  console.log("App Show");
});

onHide(() => {
  console.log("App Hide");
});
</script>
<style>
@import "./app.css";
</style>
