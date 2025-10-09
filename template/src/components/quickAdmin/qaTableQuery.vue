<template>
  <div class="qa-table-query">
    <el-form v-model="model" label-width="auto" class="flex flex-wrap gap-x-1">
      <qa-form-item v-model="model" v-for="item in columns"
        v-bind="{ ...item, key: item.key, itemKey: item.key, label: item.title }"
        @search="emit('search')"
        />
      <el-button type="primary" @click="emit('search')" :icon="Search">
        搜索
      </el-button>
    </el-form>

  </div>
</template>

<script setup lang="ts">
const emit = defineEmits(['search', 'update:modelValue'])
import { Search } from '@element-plus/icons-vue'
import qaFormItem from './qaFormItems.vue'
import { useVModel } from "@vueuse/core"
import { realUnitConversion } from '@/utils/qaUtils'

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



// 通过 useVModel 直接拿到响应式 formData（相当于 computed + emit）
const model = useVModel(props, "modelValue", emit)

</script>

<style scoped></style>
