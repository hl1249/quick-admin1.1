import { createSSRApp } from "vue";
import { createPinia } from "pinia";
import { piniaPluginUniPersist } from "@/store/persist";
import App from "./App.vue";

export function createApp() {
  const app = createSSRApp(App);
  const pinia = createPinia();
  pinia.use(piniaPluginUniPersist);
  app.use(pinia);
  return {
    app,
  };
}
