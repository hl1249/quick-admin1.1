<template>
  <div>
    <div class="flex items-center gap-[12px] flex-wrap">
      <el-button :loading="loading" @click="visible = true">
        {{ currentLabel || placeholder || `请选择${title ?? ''}` || '选择' }}
      </el-button>
      <el-icon
        v-if="modelValue !== undefined && modelValue !== null && modelValue !== ''"
        style="cursor:pointer;color:var(--el-text-color-placeholder);"
        @click="clearSelection"
      >
        <CircleClose />
      </el-icon>
    </div>

    <qa-dialog title="选择" v-model="visible" :width="720" append-to-body>
      <el-divider />
      <el-tree
        style="max-width: 600px"
        :data="data"
        :props="defaultProps"
        @node-click="handleNodeClick"
      >
        <template #default="{ data }">
          <span class="custom-tree-node">
            <span>{{ data[defaultProps.value] }}（{{ data[defaultProps.label] }}）</span>
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
import { CircleClose } from '@element-plus/icons-vue'
import http from '@/utils/axios'
const emit = defineEmits(['treeSelectConfirm', 'update:modelValue'])

const props = withDefaults(
  defineProps<{
    defaultProps?: any;
    action?: string;
    modelValue?: any;
    placeholder?: string;
    title?: string;
  }>(),
  {
    defaultProps: () => ({
      list: 'rows',
      children: 'children',
      label: 'label',
      value: 'value'
    })
  }
)

const treeSelectConfirm = () => {
  confirmedData.value = treeData.value
  emit('update:modelValue', treeData.value ? treeData.value[props.defaultProps.value] : null)
  emit('treeSelectConfirm', treeData.value)
  visible.value = false
}

const visible = ref(false)
const loading = ref(false)

watch(()=> props.modelValue,()=>{
  if(!list.value) return
  const findData = props.modelValue ? list.value.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
  if(findData) {
    treeData.value = findData
    confirmedData.value = findData
  } else if (!props.modelValue) {
    treeData.value = null
    confirmedData.value = null
  }
})

watch(visible, (open) => {
  if (!open) return
  treeData.value = confirmedData.value
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
  if (!props.action) return
  loading.value = true
  try {
    const res = await http.request({
      url: props.action,
      method: 'post',
    })

    const responseData = res.data?.data ?? {}
    const listKey = props.defaultProps?.list || 'rows'
    const childrenKey = props.defaultProps?.children || 'children'
    const treeRows = responseData?.[listKey] ?? []
    const flatList = Array.isArray(responseData?.list)
      ? responseData.list
      : flattenTree(Array.isArray(treeRows) ? treeRows : [], childrenKey)

    data.value = Array.isArray(treeRows) ? treeRows : []
    list.value = flatList
    const findData = props.modelValue ? flatList.find((item:any) => item[props.defaultProps.value] === props.modelValue) : null;
    if(findData) {
      treeData.value = findData
      confirmedData.value = findData
    } else if (!props.modelValue) {
      treeData.value = null
      confirmedData.value = null
    }
  } finally {
    loading.value = false
  }
}

const treeData = ref<any>(null)
const confirmedData = ref<any>(null)
const currentLabel = computed(() => {
  if (!confirmedData.value) return ''
  const labelKey = props.defaultProps?.label ?? 'label'
  const valueKey = props.defaultProps?.value ?? 'value'
  const label = confirmedData.value[labelKey]
  const value = confirmedData.value[valueKey]
  if (label !== undefined && value !== undefined && label !== value) {
    return `${label}（${value}）`
  }
  return label ?? value ?? ''
})

const handleNodeClick = (data: any) => {
  treeData.value = data
}

const clearSelection = () => {
  treeData.value = null
  confirmedData.value = null
  emit('update:modelValue', null)
}

getData()

// 暴露方法给父组件
defineExpose({
  open: () => visible.value = true,
  close: () => visible.value = false
})

</script>

<style scoped></style>
