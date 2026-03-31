<template>
  <el-cascader size="large" :options="options" v-model="selectedOptions" @change="onChang">
  </el-cascader>
</template>

<script setup lang="ts">
import { ref, computed, type Ref } from 'vue'
import type { CascaderOption } from 'element-plus'
import { regionData, CodeToText } from '@/utils/chinaAreaData'

const props = defineProps<{
  modelValue: AddrResult,
}>()

const emit = defineEmits(['confirm','update:modelValue'])
const onChang = () => {
  emit('confirm', selectedResult.value)
  emit('update:modelValue', selectedResult.value)
}
// Cascader 的选项
const options = regionData as unknown as CascaderOption[]

// 用户选择的 code 数组
const selectedOptions: Ref<string[]> = ref([])

watch(
  () => props.modelValue,
  (val) => {
    const arr: string[] = []
    if (val.province) arr.push(val.province.code)
    if (val.city) arr.push(val.city.code)
    if (val.area) arr.push(val.area.code)
    selectedOptions.value = arr
  },
  { immediate: true } // 初始化时就执行一次
)


// 计算选中的省市区对象
interface AddrItem {
  code: string
  name: string
}

export interface AddrResult {
  province?: AddrItem
  city?: AddrItem
  area?: AddrItem
}

const selectedResult = computed<AddrResult>(() => {
  const addr = selectedOptions.value
  const result: AddrResult = {}

  const len = addr.length
  if (!len) return result

  // area 永远是最后一个
  result.area = {
    code: addr[len - 1],
    name: CodeToText[addr[len - 1]] || ''
  }

  // 如果有两个及以上，倒数第二个是 city
  if (len >= 2) {
    result.city = {
      code: addr[len - 2],
      name: CodeToText[addr[len - 2]] || ''
    }
  }

  // 如果有三个，最前面是 province
  if (len === 3) {
    result.province = {
      code: addr[0],
      name: CodeToText[addr[0]] || ''
    }
  }

  return result
})
</script>
