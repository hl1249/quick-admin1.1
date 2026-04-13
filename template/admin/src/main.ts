import { createApp } from 'vue'
import App from './App.vue'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import 'element-plus/dist/index.css'
import '@/style/index.scss'

import { createPinia } from 'pinia'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'

import router from '@/router'

// 全局注册 quickAdmin 组件
import quickAdmin from '@/components/quickAdmin'

const app = createApp(App)

// 挂载 Pinia
app.use(createPinia().use(piniaPluginPersistedstate))
// 挂载路由
app.use(router)

// 全局注册 Element Plus 图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

app.use(quickAdmin)


// ✅ 最终挂载
app.mount('#app')
