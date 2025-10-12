<template>
  <div class="qa-table-query">
    <el-form :model="localModel" label-width="auto" class="flex flex-wrap gap-x-1">
      <qa-form-item v-model="localModel" v-for="item in columns"
        v-bind="{ ...item, key: item.key, itemKey: item.key, label: item.title }"
        form-type="query" 
        />
      <el-button type="primary" @click="handleSearch" :icon="Search">
        搜索
      </el-button>
      <el-button @click="handleReset" :icon="Refresh">
        重置
      </el-button>
    </el-form>
  </div>
</template>

<script setup lang="ts">
const emit = defineEmits(['search', 'update:modelValue'])
import { Search,Refresh } from '@element-plus/icons-vue'
import qaFormItem from './qaFormItems.vue'
import { ref, watch } from 'vue'

interface QueryColumns {
  key: string;
  title: string;
  type: string;
  width?: number | string ; // 可选字段
  minWidth?: number;
  labelWidth?: number;
  align?: string;
  mode?: string;
  data?: any[]; // select类型时，需要传入数据
}

const props = withDefaults(
  defineProps<{
    columns: QueryColumns[];
    modelValue: any,
  }>(),
  {
  }
)

// 创建本地响应式数据
const localModel = ref({ ...props.modelValue })

// 监听父组件的 modelValue 变化，同步到本地
watch(() => props.modelValue, (newValue) => {
  localModel.value = { ...newValue }
}, { deep: true })

// 搜索处理函数
const handleSearch = () => {
  // 提交数据给父组件
  emit('update:modelValue', { ...localModel.value })
  // 触发搜索事件
  emit('search')
}

const handleReset = () => {
  emit('update:modelValue', {})
  emit('search')
}
</script>