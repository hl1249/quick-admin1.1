<template>
  <qa-dialog v-model="visible" title="选择图标" :width="680" top="5vh">
    <!-- 搜索框 -->
    <el-input
      v-model="keyword"
      placeholder="搜索图标名称..."
      clearable
      class="mb-[16px]"
    />

    <!-- 图标网格 -->
    <el-scrollbar height="420px">
      <div class="grid grid-cols-6 gap-[8px] p-[4px]">
        <div
          v-for="name in filteredIcons"
          :key="name"
          class="flex flex-col items-center justify-center gap-[6px] p-[10px] rounded-[6px] cursor-pointer border border-transparent transition-all"
          :class="
            selected === name
              ? 'border-[var(--el-color-primary)] bg-[var(--el-color-primary-light-9)]'
              : 'hover:border-[var(--el-border-color)] hover:bg-[var(--el-fill-color-light)]'
          "
          @click="selected = name"
        >
          <el-icon :size="22">
            <component :is="icons[name]" />
          </el-icon>
          <span class="text-[10px] text-[var(--el-text-color-secondary)] text-center leading-tight break-all">
            {{ name }}
          </span>
        </div>
      </div>
      <div v-if="filteredIcons.length === 0" class="flex items-center justify-center h-[200px] text-[var(--el-text-color-secondary)]">
        未找到匹配的图标
      </div>
    </el-scrollbar>

    <template #footer>
      <div class="flex justify-between items-center">
        <span class="text-[12px] text-[var(--el-text-color-secondary)]">
          共 {{ filteredIcons.length }} 个图标{{ selected ? `，已选：${selected}` : '' }}
        </span>
        <div class="flex gap-[8px]">
          <el-button @click="handleClear">清除</el-button>
          <el-button @click="visible = false">取消</el-button>
          <el-button type="primary" :disabled="!selected" @click="handleConfirm">确定</el-button>
        </div>
      </div>
    </template>
  </qa-dialog>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useVModel } from '@vueuse/core'
import * as icons from '@element-plus/icons-vue'

const iconNames = Object.keys(icons) as (keyof typeof icons)[]

const props = withDefaults(
  defineProps<{
    show: boolean
    modelValue?: string
  }>(),
  {
    show: false,
    modelValue: '',
  }
)

const emit = defineEmits<{
  'update:show': [value: boolean]
  'update:modelValue': [value: string]
  'confirm': [name: string]
}>()

const visible = useVModel(props, 'show', emit)

const keyword = ref('')
const selected = ref(props.modelValue ?? '')

watch(
  () => props.modelValue,
  (val) => { selected.value = val ?? '' }
)

watch(visible, (val) => {
  if (val) {
    keyword.value = ''
    selected.value = props.modelValue ?? ''
  }
})

const filteredIcons = computed(() => {
  const kw = keyword.value.trim().toLowerCase()
  if (!kw) return iconNames
  return iconNames.filter((name) => name.toLowerCase().includes(kw))
})

const handleConfirm = () => {
  emit('update:modelValue', selected.value)
  emit('confirm', selected.value)
  visible.value = false
}

const handleClear = () => {
  selected.value = ''
  emit('update:modelValue', '')
  emit('confirm', '')
  visible.value = false
}

defineExpose({
  open: () => (visible.value = true),
  close: () => (visible.value = false),
})
</script>
