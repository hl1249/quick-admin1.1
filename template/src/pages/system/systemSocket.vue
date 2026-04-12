<template>
  <div class="flex flex-col h-full">
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />

    <div class="min-h-0 flex-1 overflow-hidden rounded-[8px] bg-white p-[12px] dark:bg-[var(--el-bg-color-overlay)]">
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
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import qaTable from '@/components/quickAdmin/table/qaTable.vue'
import type {
  Columns,
  CustomRightBtn,
} from '@/components/quickAdmin/table/qaTable.vue'
import http from '@/utils/axios'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Connection, Refresh } from '@element-plus/icons-vue'

interface SocketRow {
  topic: string
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

const qaTableRef = ref<InstanceType<typeof qaTable> | null>(null)

const queryForm = ref({
  formData: {},
  columns: [
    {
      key: 'topic',
      title: '主题',
      type: 'text',
    },
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
      key: 'topic',
      title: '主题',
      type: 'text',
      minWidth: 220,
    },
    {
      key: 'namespace',
      title: '命名空间',
      type: 'text',
      width: 120,
    },
    {
      key: 'socketId',
      title: '连接ID',
      type: 'text',
      minWidth: 220,
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
      minWidth: 240,
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
      icon: Connection,
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
