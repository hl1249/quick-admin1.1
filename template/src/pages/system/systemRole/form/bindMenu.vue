<template>
  <el-dialog v-model="visible" :title="title" width="800" :before-close="handleBeforeClose" @open="getAllMenu" @close="handleClose">
    <div class="dialog-content">
      <!-- 你的弹窗内容 -->
      <qa-form v-model="selectItem" :columns="form.props.columns" :action="form.props.action" @success="visible = false"
        @closeForm="visible = false" :before-action="form.props.beforeAction">
        <template v-slot:menuList>
          <el-input placeholder="输入关键字进行搜索" v-model="filterText"> </el-input>
          <div>
            <el-checkbox v-model="isExpandAll">展开/折叠</el-checkbox>
            <el-checkbox v-model="isCheckAll">全选/全不选</el-checkbox>
          </div>
          <el-tree ref="treeRefs" :data="treeData" node-key="menu_id" :default-checked-keys="localSelectItem.menu"
            :props="{
              children: 'children',
              label: 'title'
            }" show-checkbox expand-on-click-node :default-expand-all="isExpandAll"
            :filter-node-method="filterNode"></el-tree>
        </template>
      </qa-form>
    </div>
  </el-dialog>
</template>

<script setup lang="ts">
import qaForm from '@/components/quickAdmin/qaForm.vue'
import { useVModel } from "@vueuse/core"
import http from '@/utils/axios'
import { arrayToTree } from '@/utils'


type selectItem = {
  _id: String
  role_id:String,
  role_name: String
}

interface Props {
  modelValue?: boolean
  selectItem?: selectItem
}

const props = withDefaults(defineProps<Props>(), {
  modelValue: false,
})

const emit = defineEmits<{
  'update:modelValue': [value: boolean]
  'close': []
  'confirm': []
  'cancel': []
}>()

const filterNode = (value: any, data: any) => {
  console.log('data', data)
  if (!value) return true;
  return data.title.indexOf(value) !== -1;
}

const title = ref('默认标题')

const isExpandAll = ref(false)
watch(isExpandAll, (newValue) => {
  expandAll(treeData.value, newValue)
})
const expandAll = (nodes: any[], open: boolean) => {
  nodes.forEach(node => {
    treeRefs.value!.store.nodesMap[node.menu_id].expanded = open
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
  // nodes.forEach(node => {
    // treeRefs.value!.store.nodesMap[node.menu_id].expanded = open
    // if (node.children) expandAll(node.children, open)
  // })
}


const treeRefs = ref()
// 点击按钮时获取
const getChecked = () => {
  return treeRefs.value.getCheckedKeys()
}

// 通过 useVModel 直接拿到响应式 formData（相当于 computed + emit）
const selectItem = useVModel(props, "selectItem", emit)

// 本地副本，用于 el-tree 渲染
const localSelectItem = ref<any>({ ...selectItem.value })

// 当外部 selectItem 变化时，同步到本地副本
watch(selectItem, (val) => {
  localSelectItem.value = { ...val }
})

const form = ref({
  props: {
    beforeAction: (postData: any) => {
      postData.menu = getChecked()
      return postData
    },
    action: "/app/admin/system/systemRole/systemRole/bindMenu",
    columns: [{
      key: "menuList",
      title: "菜单",
      type: "text"
    }]
  }
})



// 使用计算属性控制显示状态
const visible = ref(true)

watch(visible, val => {
  if (!val) emit('close')
})

// 获取全部菜单
onMounted(() => {
  getAllMenu()
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
// 渲染的树形数据
const treeData = ref()
const getAllMenu = async () => {
  console.log("我有没有执行")
  const { data: { data } } = await http.request({
    method: "POST",
    url: "/app/admin/system/systemRole/systemRole/getAllMenu",
  })

  let treeProps = {
    id: "name",
    parent_id: "parent_id",
    children: "children"
  };
  treeData.value = arrayToTree(data, treeProps)
  console.log('treeData', treeData.value)
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