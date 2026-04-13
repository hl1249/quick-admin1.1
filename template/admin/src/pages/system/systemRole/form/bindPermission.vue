<template>
  <qa-dialog v-model="visible" :title="title" width="800" :before-close="handleBeforeClose" @open="getAllPermissions" @close="handleClose">
    <div class="dialog-content">
      <!-- 你的弹窗内容 -->
      <qa-form v-model="selectItem" :columns="form.props.columns" :action="form.props.action"  @success="()=>{
        visible = false
        refresh()
      }"
        @closeForm="visible = false" :before-action="form.props.beforeAction">
        <template v-slot:permission>
          <el-input placeholder="输入关键字进行搜索" v-model="filterText"> </el-input>
          <div class="my-[10px]">
            <el-checkbox v-model="isExpandAll">展开/折叠</el-checkbox>
            <el-checkbox v-model="isCheckAll">全选/全不选</el-checkbox>
          </div>
          <div class="border border-gray-300 rounded-[4px] overflow-hidden p-[10px]">
            <el-tree ref="treeRefs"
            v-loading="isTreeLoading" 
            :data="treeData" 
            :node-key="nodeKey" 
            :default-checked-keys="defaultCheckedKeys"
            :props="{
              children: 'children',
              label: 'permission_name'
            }" show-checkbox expand-on-click-node :default-expand-all="isExpandAll"
            :filter-node-method="filterNode"></el-tree>
          </div>
        </template>
      </qa-form>
    </div>
  </qa-dialog>
</template>

<script setup lang="ts">
import { useVModel } from "@vueuse/core"
import http from '@/utils/axios'
import { arrayToTree } from '@/utils'


type selectItem = {
  _id: string
  role_id: string
  role_name: string
  permissionsList?: { permission_id: string; parent_id?: string; permission_name?: string; [key: string]: unknown }[]
  permission?: string[]
}

interface Props {
  show?: boolean
  selectItem?: selectItem,
  refresh?: () => void
}

const props = withDefaults(defineProps<Props>(), {
  show: false,
  refresh: () => {}
})

const emit = defineEmits<{
  'update:show': [value: boolean]
  'close': []
  'confirm': []
  'cancel': []
}>()

// qa-dialog 真正用的值
const visible = useVModel(props, 'show', emit)

const filterNode = (value: any, data: any) => {
  console.log('data', data)
  if (!value) return true;
  return data.permission_name.indexOf(value) !== -1;
}

const title = ref('权限赋予')

const isExpandAll = ref(false)
watch(isExpandAll, (newValue) => {
  expandAll(treeData.value, newValue)
})
const expandAll = (nodes: any[], open: boolean) => {
  nodes.forEach(node => {
    treeRefs.value!.store.nodesMap[node.permission_id].expanded = open
    if (node.children) expandAll(node.children, open)
  })
}

const isCheckAll = ref(false)
watch(isCheckAll, (newValue) => {
  checkAll(treeData.value, newValue)
})
const checkAll = (nodes: any[], isCheckAll: boolean) => {
  if(isCheckAll)
    treeRefs.value.setCheckedNodes(treeData.value);
  else
    treeRefs.value?.setCheckedKeys([])
}

const treeRefs = ref()
// 获取选中值
const getChecked = () => {
  return treeRefs.value.getCheckedKeys()
}
// 获取顶级选中值
const getHalfChecked = () => {
  return treeRefs.value.getHalfCheckedKeys()
}

// 通过 useVModel 直接拿到响应式 formData（相当于 computed + emit）
const selectItem = useVModel(props, "selectItem", emit)

// 本地副本，用于 el-tree 渲染
const defaultCheckedKeys = ref<Array<string>>([])
const initData = () => {
  const list = selectItem.value?.permissionsList ?? []
  defaultCheckedKeys.value = list
    .map((item: { permission_id: string; parent_id?: string }) =>
      selectItem.value?.permission?.includes(item.permission_id) && item.parent_id ? item.permission_id : null
    )
    .filter((id): id is string => id != null)
}

const form = ref({
  props: {
    beforeAction: (postData: any) => {
      console.log('getChecked',getChecked())
      console.log('getHalfChecked',getHalfChecked())
      postData.permission = Array.from(new Set([...getChecked(),...getHalfChecked()]))
      return postData
    },
    action: "/app/admin/system/systemRole/systemRole/bindPermissions",
    columns: [{
      key: "permission",
      title: "菜单",
      type: "text"
    }]
  }
})

// 获取全部菜单
onMounted(() => {
  getAllPermissions()
  title.value += `(${selectItem.value?.role_name})`
})

const handleClose = () => {
  emit('close')
}

const handleBeforeClose = (done: () => void) => {
  // 可以在这里添加关闭前的验证逻辑
  done()
}

// 数据过滤
const filterText = ref("")
watch(filterText, (val) => {
  treeRefs.value!.filter(val)
})
// 节点key
const nodeKey = "permission_id"
// 渲染的树形数据
const treeData = ref<any[]>([])
const isTreeLoading = ref(false)
const getAllPermissions = async () => {
  isTreeLoading.value = true
  try {
  const { data: { data } } = await http.request({
    method: "POST",
    url: "/app/admin/system/systemRole/systemRole/getAllPermissions",
  })

  let treeProps = {
    id: "permission_id",
    parent_id: "parent_id",
    children: "children"
  };
    treeData.value = arrayToTree(data, treeProps)
    console.log('treeData', treeData.value)
    initData()
  } finally {
    isTreeLoading.value = false
  }
}

// 暴露方法给父组件
defineExpose({
  open: () => visible.value = true,
  close: () => visible.value = false
})
</script>

<style scoped>
.dialog-content {
  padding: 20px;
}
</style>