<template>
  <div class="qa-table-query">
    <el-form :model="modelValue" label-width="auto" class="flex flex-wrap gap-x-1">
      <qa-form-item v-for="item, index in columns" v-bind="item"
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
import qaFormItem from './qaFormItem.vue'


interface QueryColumnsItem {
  key: string;
  itemKey: string
  title: string;
  type: 'text'
  width?: number; // 可选字段
  minWidth?: number;
  labelWidth?: number;
  align?: string;
  mode?: string;
  data?: any[]; // select类型时，需要传入数据
}


const props = withDefaults(
  defineProps<{
    columns: QueryColumnsItem[];
    modelValue: any
  }>(),
  {
  }
)

</script>

<style scoped></style>
