<template>
  <div>
    <div class="flex items-center gap-[12px] flex-wrap">
      <el-tag
        v-for="(item, index) in selectedList"
        :key="item[idKey] ?? index"
        size="large"
      >
        <div class="flex items-center">
          <span>{{ item[nameKey] }}</span>
          <el-icon class="ml-[4px]" style="cursor:pointer" @click="remove(index)">
            <RemoveFilled />
          </el-icon>
        </div>
      </el-tag>

      <el-button :loading="initialLoading" @click="showDialog = true">
        {{ placeholder || `请选择${title ?? ''}` }}
      </el-button>
    </div>

    <el-dialog title="选择" v-model="showDialog" :width="multiple ? 1140 : 750">
      <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />
      <div class="flex mt-[20px] w-full">
        <qa-table
          ref="qaTableRef"
          style="width: 100%;"
          :action="action!"
          :columns="columns"
          :row-key="idKey"
          :selection-data="pendingSelection"
          :reserve-selection="true"
          selection
          border
          :multiple="multiple"
          :page-size="pageSize"
          :query-form-param="queryForm"
          @selection-change="handleSelectionChange"
        />

        <el-table :data="pendingSelection" border v-if="multiple" class="ml-[20px]" style="width:386px;flex:0 0 auto">
          <qa-table-column align="center" :width="250" v-for="(col, index) in renderSelectData" :key="index" :label="col.title" :prop="col.key" />
          <el-table-column align="center" fixed="right">
            <template #header>操作</template>
            <template #default="scope">
              <el-button type="danger" @click="removePending(scope.$index)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <template #footer>
        <div class="dialog-footer flex justify-end">
          <el-button type="primary" @click="onConfirmDialog">确定</el-button>
          <el-button @click="showDialog = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { RemoveFilled } from '@element-plus/icons-vue'
import http from '@/utils/axios'
import type { QueryColumns } from '../table/qaTableQuery.vue'
import type { Columns } from '../table/qaTable.vue'

const props = withDefaults(
  defineProps<{
    modelValue?: any
    action?: string
    columns?: Columns[]
    queryColumns?: QueryColumns[]
    formData?: Record<string, any>
    multiple?: boolean
    pageSize?: number
    placeholder?: string
    title?: string
  }>(),
  {
    columns: () => [],
    queryColumns: () => [],
    formData: () => ({}),
    multiple: false,
    pageSize: 10,
  }
)

const emit = defineEmits<{
  (e: 'update:modelValue', val: any): void
}>()

/* ---------- 从 columns 推断 key ---------- */
const nameKey = computed(() =>
  props.columns.find((c) => c.nameKey)?.key ?? '_id'
)
const idKey = computed(() =>
  props.columns.find((c) => c.idKey)?.key ?? '_id'
)

/* ---------- 弹窗 ---------- */
const showDialog = ref(false)
const qaTableRef = ref()

const queryForm = ref({
  formData: props.formData,
  columns: props.queryColumns,
})

const search = () => {
  qaTableRef.value?.search()
}

const renderSelectData = computed(() =>
  props.columns.filter((item) => item.nameKey)
)

/* ---------- 弹窗内待确认选中项 ---------- */
const pendingSelection = ref<any[]>([])

watch(showDialog, (open) => {
  if (open) {
    const arr = Array.isArray(selectedList.value) ? selectedList.value : []
    try {
      pendingSelection.value = JSON.parse(JSON.stringify(arr))
    } catch {
      pendingSelection.value = arr.map((item: any) => ({ ...item }))
    }
  }
})

const handleSelectionChange = (selection: any[]) => {
  pendingSelection.value = Array.isArray(selection) ? selection : []
}

const removePending = (index: number) => {
  pendingSelection.value = pendingSelection.value.filter((_, i) => i !== index)
}

const onConfirmDialog = () => {
  const rows = pendingSelection.value ?? []
  selectedList.value = rows
  loaded.value = true
  emit('update:modelValue', rows.map((r: any) => r[idKey.value]))
  showDialog.value = false
}

/* ---------- 已选列表（完整行数据） ---------- */
const selectedList = ref<any[]>([])

/* ---------- 编辑回填：value 变化时拉取行数据 ---------- */
const initialLoading = ref(false)
const loaded = ref(false)

watch(
  () => props.modelValue,
  async (val) => {
    const ids: any[] = Array.isArray(val) ? val : val != null ? [val] : []

    if (ids.length === 0) {
      selectedList.value = []
      loaded.value = false
      return
    }

    if (loaded.value) return
    if (!props.action) return

    loaded.value = true
    initialLoading.value = true
    try {
      const res = await http.request({
        method: 'POST',
        url: props.action,
        data: { pageIndex: 1, pageSize: ids.length, formData: { [idKey.value]: val },  columns: props.queryColumns },
      
      })
      selectedList.value = res.data?.data?.rows ?? []
      emit('update:modelValue', selectedList.value.map((r) => r[idKey.value]))
    } finally {
      initialLoading.value = false
    }
  },
  { immediate: true }
)

/* ---------- 操作 ---------- */
const remove = (index: number) => {
  selectedList.value = selectedList.value.filter((_, i) => i !== index)
  emit('update:modelValue', selectedList.value.map((r) => r[idKey.value]))
}
</script>
