<template>
  <div class="qa-table-query">
    <el-form :model="modelValue" label-width="auto" class="flex flex-wrap gap-x-1">
      <qa-form-item v-for="item, index in columns" :label="item.title" :type="item.type" :key="item.key"
        :width="item.width" :min-width="item.minWidth" :labelWidth="item.labelWidth" :data="item.data"
        v-model="modelValue[item.key]" @search="emit('search')" />
      <el-button type="primary" @click="emit('search')" :icon="Search">
        搜索
      </el-button>
    </el-form>
    
  </div>
</template>

<script setup lang="ts">
const emit = defineEmits(['search', 'update:modelValue'])
import { Search } from '@element-plus/icons-vue'
import qaFormItem from './qaFormItem.tsx'


interface QueryColumns {
  key: string;
  title: string;
  type: string;
  width?: number; // 可选字段
  minWidth?: number;
  labelWidth?: number;
  align?: string;
  mode?: string;
  data?: any[]; // select类型时，需要传入数据
}


const props = withDefaults(
  defineProps<{
    columns: QueryColumns[];
    modelValue: any
  }>(),
  {
  }
)

</script>

<style scoped></style>
