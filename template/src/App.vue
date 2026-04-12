<template>
    
  <el-config-provider :locale="locale" :size="size">
    <router-view />
  </el-config-provider>
</template>

<script setup lang="ts">
import { onBeforeUnmount } from 'vue'
import { RouterView } from 'vue-router'
import { useDark, useLocalStorage } from '@vueuse/core'
import { ElConfigProvider, ElNotification } from 'element-plus'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import {
  SOCKET_EVENTS,
  useAdminSocket,
  type AdminOrderUpdatedPayload,
  type SocketNotifyPayload,
} from '@/composables/useSocket'

const isDark = useDark()
document.documentElement.classList.toggle('dark', isDark.value)

const locale = ref(zhCn)
const size = useLocalStorage('element-size', 'default') as unknown as
  | ''
  | 'small'
  | 'default'
  | 'large'

const adminSocket = useAdminSocket()

const stopNotifyListener = adminSocket.on<SocketNotifyPayload>(SOCKET_EVENTS.notify, payload => {
  ElNotification({
    title: payload.title || '系统通知',
    message: payload.message || '收到一条新的后台通知',
    type: payload.type || 'info',
  })
})

const stopOrderUpdatedListener = adminSocket.on<AdminOrderUpdatedPayload>(
  SOCKET_EVENTS.orderUpdated,
  payload => {
    ElNotification({
      title: payload.title || '订单更新',
      message: payload.message,
      type: payload.level === 'urgent' ? 'error' : payload.level === 'warning' ? 'warning' : 'info',
    })
  },
)

onBeforeUnmount(() => {
  stopNotifyListener()
  stopOrderUpdatedListener()
})
</script>

<style lang="less" scoped>
</style>