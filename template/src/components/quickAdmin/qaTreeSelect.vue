<template>
  <div>
    <el-dialog title="选择" v-model="visible" :width="720">
      <el-divider />
      <el-tree
        style="max-width: 600px"
        :data="data"
        :props="defaultProps"
        @node-click="handleNodeClick"
      >
      <template #default="{ data }">
        <span class="custom-tree-node">
          <span >{{ data[defaultProps.value] }}（{{ data[defaultProps.label] }}）</span>
        </span>
      </template>
    </el-tree>
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
import http from '@/utils/axios'
const emit = defineEmits(['treeSelectConfirm','update:show'])

const props = withDefaults(
  defineProps<{
    defaultProps?: any;
    action?: string;
    modelValue?: any;
    show?: boolean;  // 直接使用 boolean 类型
  }>(),
  {
    show: false,  // 默认值
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

watch(()=> props.modelValue,()=>{
  if(!list.value) return
  const findData = props.modelValue ? list.value.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
  if(findData) emit('treeSelectConfirm', findData)
})

const data = ref([])
const list = ref([])
const getData = async () => {
  const res = await http.request({
    url: props.action,
    method: 'post',
  })

  console.log('res',res)
  data.value = res.data.data.rows
  list.value = res.data.data.list
  const findData = props.modelValue ? res.data.data.list.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
  if(findData) emit('treeSelectConfirm', findData)
}

const treeData = ref(null)

const handleNodeClick = (data: any) => {
  treeData.value = data
}

getData()

// 暴露方法给父组件
defineExpose({
  open: () => visible.value = true,
  close: () => visible.value = false
})

</script>

<style scoped></style>
