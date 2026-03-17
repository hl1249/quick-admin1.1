<template>
  <div>
    <el-dialog title="选择" v-model="visible" :width="1150">
      <qa-table-query :columns="queryColumns" v-model="formData" />
      modelValue{{ modelValue }}<br/>
      idKey：{{idKey}}<br/>
      selectionData:{{ selectionData }}
      <div class="flex  gap-[20px] mt-[20px]">
      <qa-table
        style="flex: 0 0 auto;width: 700px;"
        :action="action"
        :columns="columns"
        :row-key="idKey"
        :selection-data="selectionData"
        :reserve-selection="true"
        selection
        border
        :multiple="multiple"
        :page-size="pageSize"
        @selection-change="handleSelectionChange"
      />

      <el-table :data="selectionData" border>
        <qa-table-column :width="200" v-for="item,index in renderSelectData" :key="index" :label="item.title" :prop="item.key" />
        <el-table-column align="center" fixed="right">
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
      defaultProps: () => ({
        children: 'children',
        label: 'label'
      })
    }
)

const renderSelectData = computed(() => {
  return props.columns.filter((item) => item.nameKey)
})
const tableSelectConfirm = () => {
  emit('tableSelectConfirm', tableSelectData.value)
  visible.value = false
}

const visible = useVModel(props, 'show', emit)
const formData = useVModel(props, 'formData', emit)

// 打开弹窗时用 modelValue 初始化右侧已选列表
watch(visible, (open) => {
  if (open && props.modelValue != null) {
    // if (props.multiple && Array.isArray(props.modelValue)) {
    //   tableSelectData.value = props.modelValue.map((row: any) =>
    //     typeof structuredClone === 'function' ? structuredClone(row) : JSON.parse(JSON.stringify(row)),
    //   )
    // } else if (!props.multiple && !Array.isArray(props.modelValue)) {
    //   const row = props.modelValue
    //   tableSelectData.value = typeof structuredClone === 'function' ? structuredClone(row) : JSON.parse(JSON.stringify(row))
    // }
    
  }
})

watch(()=> props.modelValue,()=>{
  if(!list.value) return
  const findData = props.modelValue ? list.value.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
  if(findData) emit('tableSelectConfirm', findData)
})

const data = ref([])
const list = ref([])
const getData = async () => {
  // const res = await http.request({
  //   url: props.action,
  //   method: 'post',
  // })
  //
  // console.log('res',res)
  // data.value = res.data.data.rows
  // list.value = res.data.data.list
  // const findData = props.modelValue ? res.data.data.list.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
  // if(findData) emit('tableSelectConfirm', findData)
}

const tableSelectData = ref<any>(props.multiple ? [] : null)

const handleSelectionChange = (selection: any[]) => {
  console.log('selection',selection)
  if (props.multiple) {
    // tableSelectData.value = selection
  } else {
    // tableSelectData.value = selection.length ? selection[0] : null
  }
}

const removeSelect = (row: any, index: number) => {
  if (props.multiple && Array.isArray(tableSelectData.value)) {
    tableSelectData.value = tableSelectData.value.filter((_, i) => _._id !== row._id)
    emit('update:modelValue', tableSelectData.value)
  } else {
    tableSelectData.value = null
    emit('update:modelValue', null)
  }
}

getData()

// 暴露方法给父组件
defineExpose({
  open: () => visible.value = true,
  close: () => visible.value = false
})

</script>

<style scoped></style>
