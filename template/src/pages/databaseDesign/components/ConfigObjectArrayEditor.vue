<script setup lang="ts">
import { computed } from 'vue'
import type { ConfigArrayField } from '../types'

const props = defineProps<{
  modelValue?: Record<string, any>[]
  itemFields?: ConfigArrayField[]
  addText?: string
}>()

const emit = defineEmits<{
  'update:modelValue': [value: Record<string, any>[]]
}>()

const items = computed(() => Array.isArray(props.modelValue) ? props.modelValue : [])
const visibleFields = computed(() => props.itemFields ?? [])

const rowGridStyle = computed(() => ({
  gridTemplateColumns: [
    ...visibleFields.value.map((field) => {
      if (field.type === 'switch') return '72px'
      if (field.type === 'number') return '120px'
      if (field.type === 'select') return '220px'
      return 'minmax(120px, 1fr)'
    }),
    '56px',
  ].join(' '),
}))

function getDefaultValue(field: ConfigArrayField) {
  if (field.default !== undefined) return field.default
  if (field.type === 'switch') return false
  return ''
}

function updateItem(index: number, key: string, value: any) {
  const targetField = (props.itemFields ?? []).find(field => field.key === key)
  emit('update:modelValue', items.value.map((item, idx) => {
    if (idx === index) return { ...item, [key]: value }
    if (targetField?.uniqueTrue && value === true) return { ...item, [key]: false }
    return item
  }))
}

function addItem() {
  const nextItem = (props.itemFields ?? []).reduce<Record<string, any>>((acc, field) => {
    acc[field.key] = getDefaultValue(field)
    return acc
  }, {})
  emit('update:modelValue', [...items.value, nextItem])
}

function removeItem(index: number) {
  emit('update:modelValue', items.value.filter((_, idx) => idx !== index))
}
</script>

<template>
  <div class="flex flex-col gap-2">
    <div class="editor-table-wrap">
      <div v-if="visibleFields.length" class="editor-row editor-header" :style="rowGridStyle">
        <div
          v-for="field in visibleFields"
          :key="field.key"
          class="editor-head-cell"
        >
          {{ field.label }}
        </div>
        <div class="editor-head-cell text-center">操作</div>
      </div>

      <div v-if="items.length" class="flex flex-col gap-1.5">
        <div
          v-for="(item, idx) in items"
          :key="idx"
          class="editor-row"
          :style="rowGridStyle"
        >
          <div v-for="field in visibleFields" :key="field.key" class="editor-cell">
            <el-input
              v-if="field.type === 'text'"
              :model-value="item[field.key]"
              :placeholder="field.placeholder || field.label"
              clearable
              @update:model-value="updateItem(Number(idx), field.key, $event)"
            />

            <el-input-number
              v-else-if="field.type === 'number'"
              :model-value="item[field.key]"
              class="w-full"
              controls-position="right"
              @update:model-value="updateItem(Number(idx), field.key, $event)"
            />

            <div v-else-if="field.type === 'switch'" class="flex items-center justify-center">
              <el-switch
                :model-value="item[field.key]"
                @update:model-value="updateItem(Number(idx), field.key, $event)"
              />
            </div>

            <el-select
              v-else-if="field.type === 'select'"
              :model-value="item[field.key]"
              clearable
              class="w-full"
              @update:model-value="updateItem(Number(idx), field.key, $event)"
            >
              <el-option
                v-for="opt in field.options"
                :key="opt.value"
                :label="opt.label"
                :value="opt.value"
              />
            </el-select>
          </div>

          <div class="editor-cell flex items-center justify-center">
            <el-button type="danger" text @click="removeItem(Number(idx))">删</el-button>
          </div>
        </div>
      </div>
    </div>

    <el-button type="primary" plain class="w-full" @click="addItem">
      {{ addText || '添加一项' }}
    </el-button>
  </div>
</template>

<style scoped>
.editor-table-wrap {
  overflow-x: auto;
}

.editor-row {
  display: grid;
  gap: 0.5rem;
  align-items: center;
  min-width: max-content;
}

.editor-header {
  margin-bottom: 0.25rem;
}

.editor-head-cell {
  font-size: 12px;
  color: #6b7280;
  font-weight: 500;
  white-space: nowrap;
}

.editor-cell {
  min-width: 0;
}

:deep(.el-input-number) {
  width: 100%;
}

:deep(.el-input-number .el-input__wrapper) {
  width: 100%;
}

:deep(.el-input__wrapper),
:deep(.el-select__wrapper) {
  min-height: 30px;
}
</style>
