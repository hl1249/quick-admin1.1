<template>
  <div>
    <el-dialog title="选择" v-model="visible" :width="multiple ? 1140 : 750">
      <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />
      <div class="flex mt-[20px] w-full">
      <qa-table
        ref="qaTableRef"
        style="width: 100%;"
        :action="action"
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
        <qa-table-column align="center" :width="250" v-for="item,index in renderSelectData" :key="index" :label="item.title" :prop="item.key" />
        <el-table-column  align="center" fixed="right">
          <template #header>
            操作
          </template>
          <template #default="scope">
            <el-button type="danger" @click="removeSelect(scope.row, scope.$index)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      </div>
      <template #footer>
        <div class="dialog-footer flex justify-end">
          <el-button type="primary" @click="tableSelectConfirm">确定</el-button>
          <el-button @click="visible = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { useVModel } from "@vueuse/core"
import type { QueryColumns } from './qaTableQuery.vue'
import type { Columns } from './qaTable.vue'
const emit = defineEmits(['tableSelectConfirm','update:show','update:formData','update:modelValue'])

const props = withDefaults(
    defineProps<{
      defaultProps?: any;
      action: string;
      modelValue?: any;
      show?: boolean;

      columns: Columns[]
      enable?: boolean
      formData?: Record<string, any>
      queryColumns?: QueryColumns[]
      multiple?: boolean
      pageSize?: number;

      idKey?: string;
      nameKey?: string;

      selectionData?: any[]
    }>(),
    {
      show: false,
      enable: false,
      formData: () => ({}),
      queryColumns: () => [],
      multiple: false,
      pageSize: 10,
      idKey: '_id',
      nameKey: 'name',
      selectionData: () => [],
      defaultProps: () => ({
        children: 'children',
        label: 'label'
      })
    }
)

const queryForm = ref({
  formData: props.formData,
  columns:props.queryColumns
})

const qaTableRef = ref()

/** 弹窗内待确认的选中项，仅点击「确定」时才同步到父组件 */
const pendingSelection = ref<any[]>([])

const search = () => {
  if (qaTableRef.value) {
    qaTableRef.value.search()
  }
}

const renderSelectData = computed(() => {
  return props.columns.filter((item) => item.nameKey)
})
const tableSelectConfirm = () => {
  const raw = pendingSelection.value ?? []
  try {
    emit('tableSelectConfirm', JSON.parse(JSON.stringify(raw)))
  } catch {
    emit('tableSelectConfirm', raw.map((item: any) => ({ ...item })))
  }
  visible.value = false
}

const visible = useVModel(props, 'show', emit)
const formData = useVModel(props, 'formData', emit)

// 打开弹窗时用父组件当前已选（selectionData）初始化待确认列表（用 JSON 克隆避免 structuredClone 对代理/函数等报错）
watch(visible, (open) => {
  if (open) {
    const raw = props.selectionData
    const arr = Array.isArray(raw) ? raw : raw != null ? [raw] : []
    try {
      pendingSelection.value = JSON.parse(JSON.stringify(arr))
    } catch {
      pendingSelection.value = arr.map((item: any) => ({ ...item }))
    }
  }
})

watch(()=> props.modelValue,()=>{
  if(!list.value) return
  const findData = props.modelValue ? list.value.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
  if(findData) emit('tableSelectConfirm', findData)
})

const list = ref([])
/** 左侧表格 selection-change：只更新弹窗内待确认列表，不通知父组件；点击「确定」时才通过 tableSelectConfirm 同步 */
const handleSelectionChange = (selection: any[]) => {
  pendingSelection.value = Array.isArray(selection) ? selection : []
}

const removeSelect = (_row: any, index: number) => {
  pendingSelection.value = pendingSelection.value.filter((_: any, i: number) => i !== index)
}
// 暴露方法给父组件
defineExpose({
  open: () => visible.value = true,
  close: () => visible.value = false
})

</script>

<style scoped></style>
