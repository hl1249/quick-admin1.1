<template>
  <div class="socket-page">
    <el-card shadow="never">
      <template #header>
        <div class="header-row">
          <span>Socket 通知测试</span>
          <el-tag :type="isConnected ? 'success' : isConnecting ? 'warning' : 'info'">
            {{ isConnected ? '已连接' : isConnecting ? '连接中' : '未连接' }}
          </el-tag>
        </div>
      </template>

      <div class="notify-panel">
        <div class="notify-panel__intro">
          <el-alert
            type="info"
            :closable="false"
            title="连接由全局 Socket 单例统一管理，这里只保留通知测试和事件日志。"
          />

          <el-descriptions :column="1" border class="notify-panel__meta">
            <el-descriptions-item label="命名空间">{{ namespacePath }}</el-descriptions-item>
            <el-descriptions-item label="连接地址">{{ namespaceUrl }}</el-descriptions-item>
            <el-descriptions-item label="Socket ID">{{ connectionId || '-' }}</el-descriptions-item>
            <el-descriptions-item label="最近错误">
              <span class="error-text">{{ lastError || '-' }}</span>
            </el-descriptions-item>
          </el-descriptions>
        </div>

        <div class="notify-panel__form">
          <el-form label-width="96px" class="notify-form">
            <el-form-item label="发送范围">
              <el-radio-group v-model="notifyForm.targetType">
                <el-radio-button value="broadcast">广播</el-radio-button>
                <el-radio-button value="user">指定用户</el-radio-button>
                <el-radio-button value="group">指定群组</el-radio-button>
              </el-radio-group>
            </el-form-item>

            <el-form-item v-if="notifyForm.targetType === 'user'" label="用户 ID">
              <el-input v-model="notifyForm.userId" placeholder="输入后台用户 ID" />
            </el-form-item>

            <template v-if="notifyForm.targetType === 'group'">
              <el-form-item label="bizType">
                <el-input v-model="notifyForm.bizType" placeholder="例如 custom" />
              </el-form-item>
              <el-form-item label="bizId">
                <el-input v-model="notifyForm.bizId" placeholder="例如 记录 ID 或群组 ID" />
              </el-form-item>
            </template>

            <el-form-item label="标题">
              <el-input v-model="notifyForm.title" placeholder="默认 Socket 测试通知" />
            </el-form-item>

            <el-form-item label="内容">
              <el-input
                v-model="notifyForm.message"
                type="textarea"
                :rows="3"
                placeholder="输入通知内容"
              />
            </el-form-item>

            <el-form-item label="附加数据">
              <el-input
                v-model="notifyForm.dataText"
                type="textarea"
                :rows="4"
                placeholder='可选，填写 JSON，例如 {"source":"socket-test"}'
              />
            </el-form-item>

            <el-form-item>
              <el-button type="primary" @click="handleSendNotify">发送通知</el-button>
              <el-button @click="clearLogs">清空日志</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>

      <el-divider>群组房间测试</el-divider>

      <el-form :inline="true" class="room-form">
        <el-form-item label="bizType">
          <el-input v-model="notifyForm.bizType" placeholder="例如 custom" />
        </el-form-item>
        <el-form-item label="bizId">
          <el-input v-model="notifyForm.bizId" placeholder="例如 记录ID" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" plain @click="handleJoinRoom">加入房间</el-button>
          <el-button plain @click="handleLeaveRoom">退出房间</el-button>
        </el-form-item>
      </el-form>

      <el-divider>事件日志</el-divider>

      <div class="log-list">
        <div v-for="item in logs" :key="item.id" class="log-item">
          <div class="log-title">
            <el-tag size="small">{{ item.event }}</el-tag>
            <span>{{ item.time }}</span>
          </div>
          <pre class="json-block">{{ formatJson(item.payload) }}</pre>
        </div>
        <el-empty v-if="logs.length === 0" description="暂无日志" />
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ElMessage } from 'element-plus'
import http from '@/utils/axios'
import {
  SOCKET_EVENTS,
  useAdminSocket,
  type SocketExceptionPayload,
  type SocketNotifyPayload,
} from '@/composables/useSocket'

interface LogItem {
  id: number
  event: string
  time: string
  payload: any
}

type NotifyTargetType = 'broadcast' | 'user' | 'group'

const adminSocket = useAdminSocket()

const {
  namespacePath,
  namespaceUrl,
  isConnected,
  isConnecting,
  lastError,
  connectionId,
  joinRoom,
  leaveRoom,
  on,
} = adminSocket

const notifyForm = reactive({
  targetType: 'broadcast' as NotifyTargetType,
  userId: '',
  bizType: 'custom',
  bizId: '',
  title: '',
  message: '',
  dataText: '',
})

const logs = ref<LogItem[]>([])

const formatTime = () => new Date().toLocaleTimeString()

const formatJson = (value: unknown) => {
  if (value == null || value === '') return '-'
  try {
    return JSON.stringify(value, null, 2)
  } catch {
    return String(value)
  }
}

const pushLog = (event: string, payload: unknown) => {
  logs.value.unshift({
    id: Date.now() + Math.random(),
    event,
    time: formatTime(),
    payload,
  })
}

const validateGroupTarget = () => {
  if (!notifyForm.bizType || !notifyForm.bizId) {
    ElMessage.warning('请先填写 bizType 和 bizId')
    return false
  }
  return true
}

const parseNotifyData = () => {
  if (!notifyForm.dataText.trim()) return undefined

  try {
    return JSON.parse(notifyForm.dataText)
  } catch {
    ElMessage.error('附加数据不是合法 JSON')
    return null
  }
}

const handleSendNotify = async () => {
  if (!notifyForm.message.trim()) {
    ElMessage.warning('请先填写通知内容')
    return
  }

  if (notifyForm.targetType === 'user' && !notifyForm.userId.trim()) {
    ElMessage.warning('请先填写用户 ID')
    return
  }

  if (notifyForm.targetType === 'group' && !validateGroupTarget()) {
    return
  }

  const parsedData = parseNotifyData()
  if (parsedData === null) return

  const requestPayload = {
    targetType: notifyForm.targetType,
    userId: notifyForm.userId.trim() || undefined,
    bizType: notifyForm.bizType.trim() || undefined,
    bizId: notifyForm.bizId.trim() || undefined,
    title: notifyForm.title.trim() || undefined,
    message: notifyForm.message.trim(),
    data: parsedData,
  }

  try {
    await http.request({
      url: '/app/admin/template/socket/notify/send',
      method: 'post',
      data: requestPayload,
    })

    pushLog('notify:send', requestPayload)
    ElMessage.success('通知已发送')
  } catch (error: any) {
    pushLog('notify:send:error', {
      message: error?.message || '通知发送失败',
      payload: requestPayload,
    })
    ElMessage.error(error?.message || '通知发送失败')
  }
}

const handleJoinRoom = async () => {
  if (!validateGroupTarget()) return

  try {
    const payload = await joinRoom({
      bizType: notifyForm.bizType,
      bizId: notifyForm.bizId,
    })
    pushLog(SOCKET_EVENTS.roomJoin, payload)
    ElMessage.success('加入房间成功')
  } catch (error: any) {
    pushLog('room:join:error', {
      message: error?.message || '加入房间失败',
    })
    ElMessage.error(error?.message || '加入房间失败')
  }
}

const handleLeaveRoom = async () => {
  if (!validateGroupTarget()) return

  try {
    const payload = await leaveRoom({
      bizType: notifyForm.bizType,
      bizId: notifyForm.bizId,
    })
    pushLog(SOCKET_EVENTS.roomLeave, payload)
    ElMessage.success('退出房间成功')
  } catch (error: any) {
    pushLog('room:leave:error', {
      message: error?.message || '退出房间失败',
    })
    ElMessage.error(error?.message || '退出房间失败')
  }
}

const clearLogs = () => {
  logs.value = []
}

const stopConnectListener = on('connect', () => {
  pushLog('connect', {
    socketId: connectionId.value,
  })
})

const stopDisconnectListener = on('disconnect', reason => {
  pushLog('disconnect', { reason })
})

const stopNotifyListener = on<SocketNotifyPayload>(SOCKET_EVENTS.notify, payload => {
  pushLog(SOCKET_EVENTS.notify, payload)
})

const stopExceptionListener = on<SocketExceptionPayload>(SOCKET_EVENTS.exception, payload => {
  pushLog(SOCKET_EVENTS.exception, payload)
})

onBeforeUnmount(() => {
  stopConnectListener()
  stopDisconnectListener()
  stopNotifyListener()
  stopExceptionListener()
})
</script>

<style scoped lang="scss">
.socket-page {
  padding: 16px;
}

.header-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.notify-form {
  padding-top: 2px;
}

.notify-panel {
  display: grid;
  grid-template-columns: 320px minmax(0, 1fr);
  gap: 16px;
  align-items: start;
  margin-top: 16px;
}

.notify-panel__intro {
  position: sticky;
  top: 0;
}

.notify-panel__meta {
  margin-top: 12px;
}

.room-form {
  margin-top: 12px;
}

.log-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.log-item {
  padding: 12px;
  border: 1px solid var(--el-border-color-light);
  border-radius: 8px;
  background: var(--el-fill-color-extra-light);
}

.log-title {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
  font-size: 12px;
  color: var(--el-text-color-secondary);
}

.json-block {
  margin: 0;
  white-space: pre-wrap;
  word-break: break-all;
  font-size: 12px;
}

.error-text {
  color: var(--el-color-danger);
}

@media (max-width: 1200px) {
  .notify-panel {
    grid-template-columns: 1fr;
  }

  .notify-panel__intro {
    position: static;
  }
}
</style>
