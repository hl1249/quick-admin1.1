<script setup lang="ts">
import { nextTick, ref } from 'vue'

type InputType = 'text' | 'number' | 'money' | 'percentage' | 'discount'

const props = withDefaults(defineProps<{
  modelValue?: (string | number)[]
  disabled?: boolean
  /** 最大可输入项数 */
  limit?: number
  /** 输入框类型 */
  inputType?: InputType
  /** 数值精度（小数点位数），inputType 为数值类时生效 */
  precision?: number
  /** 是否可删除标签 */
  closable?: boolean
  /** 是否显示添加按钮 */
  showAdd?: boolean
  /** 添加按钮文字 */
  addButtonText?: string
  /** 字符串最大长度（text 类型生效） */
  maxlength?: number
  placeholder?: string
}>(), {
  modelValue: () => [],
  disabled: false,
  inputType: 'text',
  precision: 2,
  closable: true,
  showAdd: true,
  addButtonText: '+ 添加',
})

const emit = defineEmits<{
  'update:modelValue': [val: (string | number)[]]
}>()

const inputVisible = ref(false)
const rawInput = ref('')
const inputRef = ref<HTMLInputElement | null>(null)

const tags = computed(() => props.modelValue ?? [])

const isNumeric = computed(() =>
  ['number', 'money', 'percentage', 'discount'].includes(props.inputType)
)

const canAdd = computed(() =>
  props.limit == null || tags.value.length < props.limit
)

/* ---------------- 格式化显示 ---------------- */
function formatTag(val: string | number): string {
  const num = Number(val)
  if (isNaN(num)) return String(val)
  switch (props.inputType) {
    case 'money':
      return '¥' + num.toLocaleString('zh-CN', {
        minimumFractionDigits: props.precision,
        maximumFractionDigits: props.precision,
      })
    case 'percentage':
      return num.toFixed(props.precision) + '%'
    case 'discount':
      return num.toFixed(props.precision) + '折'
    case 'number':
      return num.toFixed(props.precision)
    default:
      return String(val)
  }
}

/* ---------------- 输入校验 ---------------- */
function parseInput(raw: string): string | number | null {
  const trimmed = raw.trim()
  if (!trimmed) return null

  if (!isNumeric.value) return trimmed

  const num = Number(trimmed)
  if (isNaN(num)) return null
  if (props.inputType === 'discount' && (num < 0 || num > 10)) return null
  if (props.inputType === 'percentage' && (num < 0 || num > 100)) return null
  return num
}

/* ---------------- 操作 ---------------- */
function removeTag(index: number) {
  const next = [...tags.value]
  next.splice(index, 1)
  emit('update:modelValue', next)
}

function confirmTag() {
  const val = parseInput(rawInput.value)
  if (val !== null && !tags.value.includes(val)) {
    emit('update:modelValue', [...tags.value, val])
  }
  inputVisible.value = false
  rawInput.value = ''
}

function showInput() {
  if (!canAdd.value) return
  inputVisible.value = true
  nextTick(() => inputRef.value?.focus())
}

function onKeyup(e: KeyboardEvent) {
  if (e.key === 'Enter') confirmTag()
}
</script>

<template>
  <div class="qa-tag" :class="{ 'is-disabled': disabled }">
    <el-tag
      v-for="(tag, index) in tags"
      :key="index"
      :closable="closable && !disabled"
      @close="removeTag(index)"
    >
      {{ formatTag(tag) }}
    </el-tag>

    <el-input
      v-if="inputVisible"
      ref="inputRef"
      v-model="rawInput"
      :type="isNumeric ? 'number' : 'text'"
      :maxlength="!isNumeric ? maxlength : undefined"
      :placeholder="placeholder"
      class="qa-tag__input"
      @keyup="onKeyup"
      @blur="confirmTag"
    />

    <el-button
      v-else-if="showAdd && !disabled && canAdd"
      @click="showInput"
    >
      {{ addButtonText }}
    </el-button>
  </div>
</template>

<style scoped>
.qa-tag {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  align-items: center;
  min-height: 32px;
}

.qa-tag__input {
  width: 90px;
}

.qa-tag.is-disabled {
  cursor: not-allowed;
  opacity: 0.6;
}
</style>
