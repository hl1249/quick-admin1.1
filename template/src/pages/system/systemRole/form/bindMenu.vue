<template>
  <el-dialog 
    v-model="visible" 
    :title="title"
    :before-close="handleBeforeClose"
    @close="handleClose"
  >
    <div class="dialog-content">
      <!-- 你的弹窗内容 -->
       <qa-form v-model="selectItem" :columns="form.props.columns" :action="form.props.action"
       >
        <!-- <template v-slot:menuList>
				<el-input placeholder="输入关键字进行搜索" v-model="tree.filterText"> </el-input>
				
				<view class="tree-box">
					<el-tree
						ref="tree"
						:data="data.treeData"
						:node-key="data.nodeKey"
						:default-checked-keys="data.checkedKeys"
						:props="{
							children: 'children',
							label: 'label'
						}"
						show-checkbox
						expand-on-click-node
						:default-expand-all="false"
						:filter-node-method="filterNode"
					></el-tree>
				</view>
			</template> -->
      </qa-form>
    </div>
  </el-dialog>
</template>

<script setup lang="ts">
import qaForm from '@/components/quickAdmin/qaForm.vue'
import { useVModel } from "@vueuse/core"


interface Props {
  modelValue?: boolean
  title?: string
  selectItem?: object
}

const props = withDefaults(defineProps<Props>(), {
  modelValue: false,
  title: '默认标题',
})

const emit = defineEmits<{
  'update:modelValue': [value: boolean]
  'close': []
  'confirm': []
  'cancel': []
}>()

// 通过 useVModel 直接拿到响应式 formData（相当于 computed + emit）
const selectItem = useVModel(props, "selectItem", emit)

const form = ref({
    props:{
        beforeAction:(postData: any)=>{
          console.log('postData',postData)
          
          postData.menuList = [1,2,3]
        },
        action:"",
        columns:[{
            key:"menuList",
            title:"菜单",
            type:"text"
        }]
    }
})

const tree = {
				filterText: "",
				expandAll: false,
				checkAll: false
			}

// 使用计算属性控制显示状态
const visible = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

// 控制方法
const handleConfirm = () => {
  emit('confirm')
  visible.value = false
}

const handleCancel = () => {
  emit('cancel')
  visible.value = false
}

const handleClose = () => {
  emit('close')
}

const handleBeforeClose = (done: () => void) => {
  // 可以在这里添加关闭前的验证逻辑
  done()
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