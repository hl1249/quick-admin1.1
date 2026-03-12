<template>
  <div>
    <el-dialog title="选择" v-model="visible" :width="720">
      <qa-table-query :columns="queryColumns" v-model="formData" />
      <qa-table :action="props.action" :columns="props.columns" selection border :multiple="props.multiple" @selection-change="handleSelectionChange" />


      <template #footer>
        <div class="dialog-footer flex justify-end">
          <el-button type="primary" @click="treeSelectConfirm">确定</el-button>
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
const emit = defineEmits(['treeSelectConfirm','update:show','update:formData'])

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

const treeSelectConfirm = () => {
  emit('treeSelectConfirm', treeData.value)
  visible.value = false
}

const visible = useVModel(props, 'show', emit)
const formData = useVModel(props, 'formData', emit)

watch(()=> props.modelValue,()=>{
  if(!list.value) return
  const findData = props.modelValue ? list.value.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
  if(findData) emit('treeSelectConfirm', findData)
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
  // if(findData) emit('treeSelectConfirm', findData)
}

const treeData = ref<any>(props.multiple ? [] : null)

const handleSelectionChange = (selection: any[]) => {
  if (props.multiple) {
    treeData.value = selection
  } else {
    treeData.value = selection.length ? selection[0] : null
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
