<template>
  <div class="flex flex-col h-full">
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search"/>
      <qa-table
        ref="qaTableRef"
        :action="table.action"
        :columns="table.columns"
        :custom-right-btns="table.customRightBtns"
        :query-form-param="queryForm.formData"
        :row-key="'socketId'"
        :row-no="true"
        height="100%"
      />
  </div>
</template>

<script setup lang="ts">
import { markRaw, onUnmounted, ref } from 'vue'
import {
  SOCKET_EVENTS,
  useAdminSocket,
  type SocketNotifyPayload,
} from '@/composables/useSocket'

import qaTable from '@/components/quickAdmin/table/qaTable.vue'
import type {
  Columns,
  CustomRightBtn,
} from '@/components/quickAdmin/table/qaTable.vue'
import http from '@/utils/axios'
import {ElMessage, ElMessageBox, ElNotification} from 'element-plus'
import { Connection } from '@element-plus/icons-vue'

interface SocketRow {
  namespace: string
  socketId: string
  userId: string
  username: string
  nickname: string
  rooms: string[]
  connectedAtText: string
  ageText: string
  [key: string]: any
}

const adminSocket = useAdminSocket()

const stopNotifyListener = adminSocket.on<SocketNotifyPayload>(SOCKET_EVENTS.notify, payload => {
  ElNotification({
    title: payload.title || '系统通知',
    message: payload.message || '收到一条新的后台通知',
    type: payload.type || 'info',
  })
})

const qaTableRef = ref<InstanceType<typeof qaTable> | null>(null)

const queryForm = ref({
  formData: {
    socketId: '',
    userId: '',
    username: '',
    nickname: '',
  },
  columns: [
    {
      key: 'socketId',
      title: '连接ID',
      type: 'text',
    },
    {
      key: 'userId',
      title: '用户ID',
      type: 'text',
    },
    {
      key: 'username',
      title: '用户名',
      type: 'text',
    },
    {
      key: 'nickname',
      title: '昵称',
      type: 'text',
    },
  ],
})

const table = ref<{
  action: string
  columns: Columns[]
  customRightBtns: CustomRightBtn[]
}>({
  action: '/app/admin/system/sysSocketPool/sysSocketPool/getList',
  columns: [
    {
      key: 'namespace',
      title: '命名空间',
      type: 'text',
    },
    {
      key: 'socketId',
      title: '连接ID',
      type: 'text',
      width: 260,
    },
    {
      key: 'userId',
      title: '用户ID',
      type: 'text',
      minWidth: 220,
    },
    {
      key: 'username',
      title: '用户名',
      type: 'text',
      width: 140,
    },
    {
      key: 'nickname',
      title: '昵称',
      type: 'text',
      width: 140,
    },
    {
      key: 'rooms',
      title: '房间',
      type: 'text',
      minWidth: 260,
      formatter: (value: string[]) => value?.join(', ') || '-',
    },
    {
      key: 'connectedAtText',
      title: '连接时间',
      type: 'text',
      width: 180,
    },
    {
      key: 'ageText',
      title: '距离现在',
      type: 'text',
      width: 140,
    },
  ],
  customRightBtns: [
    {
      title: '断开连接',
      type: 'danger',
      icon: markRaw(Connection),
      disabled: (row: SocketRow) => !row.socketId,
      onClick: (row: SocketRow) => {
        handleDisconnect(row)
      },
    },
  ],
})

const search = () => {
  qaTableRef.value?.search()
}

const refreshTable = () => {
  qaTableRef.value?.refresh()
}

const stopPondListener = adminSocket.on(SOCKET_EVENTS.pondUpdate, () => {
  refreshTable()
})

onUnmounted(() => {
  stopNotifyListener()
  stopPondListener()
})

const handleDisconnect = async (row: SocketRow) => {
  if (!row.socketId) return

  try {
    await ElMessageBox.confirm(
      `确定断开连接 ${row.socketId} 吗？`,
      '断开连接',
      {
        type: 'warning',
        confirmButtonText: '确定',
        cancelButtonText: '取消',
      },
    )

    await http.request({
      url: '/app/admin/system/sysSocketPool/sysSocketPool/disconnect',
      method: 'post',
      data: {
        socketId: row.socketId,
      },
    })

    ElMessage.success('连接已断开')
    refreshTable()
  } catch (error: any) {
    if (error === 'cancel') return
    ElMessage.error(error?.message || '断开连接失败')
  }
}
</script>
