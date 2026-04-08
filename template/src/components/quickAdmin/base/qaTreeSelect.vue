<template>
  <div>
    <qa-dialog title="选择" v-model="visible" :width="720">
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
    </qa-dialog>
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
      list: 'rows',
      children: 'children',
      label: 'label',
      value: 'value'
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

const data = ref<any[]>([])
const list = ref<any[]>([])

function flattenTree(nodes: any[], childrenKey: string, result: any[] = []) {
  for (const node of nodes) {
    result.push(node)
    const children = node?.[childrenKey]
    if (Array.isArray(children) && children.length) {
      flattenTree(children, childrenKey, result)
    }
  }
  return result
}

const getData = async () => {
  const res = await http.request({
    url: props.action,
    method: 'post',
  })

  console.log('res',res)
  const responseData = res.data?.data ?? {}
  const listKey = props.defaultProps?.list || 'rows'
  const childrenKey = props.defaultProps?.children || 'children'
  const treeData = responseData?.[listKey] ?? []
  const flatList = Array.isArray(responseData?.list)
    ? responseData.list
    : flattenTree(Array.isArray(treeData) ? treeData : [], childrenKey)

  data.value = Array.isArray(treeData) ? treeData : []
  list.value = flatList
  const findData = props.modelValue ? flatList.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
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
