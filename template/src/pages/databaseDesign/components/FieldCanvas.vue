<script setup lang="ts">
import { ArrowUp, ArrowDown } from '@element-plus/icons-vue'
import { getBsonTypeList, getTypeDef, type FieldDef } from '../types'

const props = defineProps<{
  fields: FieldDef[]
  selectedId: string | null
  draggingId: string | null
  canvasAddActive: boolean
}>()

const emit = defineEmits<{
  select: [string]
  delete: [string]
  duplicate: [string]
  moveUp: [number]
  moveDown: [number]
  canvasDragOver: [DragEvent]
  canvasDrop: [DragEvent]
  fieldDragStart: [DragEvent, number, string]
  fieldDragOver: [DragEvent, number]
  fieldDragEnd: []
  beforeLeave: [Element]
  leave: [Element, () => void]
  afterLeave: [Element]
}>()

const onBeforeLeave = (el: Element) => emit('beforeLeave', el)
const onLeave = (el: Element, done: () => void) => emit('leave', el, done)
const onAfterLeave = (el: Element) => emit('afterLeave', el)
</script>

<template>
  <div
    class="flex-1 flex flex-col overflow-hidden"
    @dragover="emit('canvasDragOver', $event)"
    @drop="emit('canvasDrop', $event)"
  >
    <!-- 字段列表头 -->
    <div v-if="fields.length" class="field-grid px-6 pr-11 py-2 bg-gray-100 border-b border-gray-200 text-xs text-gray-500 font-medium select-none flex-shrink-0">
      <span class="text-center">#</span>
      <span></span>
      <span>字段名 (key)</span>
      <span class="text-center">BSON 类型</span>
      <span class="text-center">表单类型</span>
      <span class="text-center">必填</span>
      <span class="text-center">操作</span>
    </div>

    <!-- 拖放区域 -->
    <div class="canvas-scroll flex-1 overflow-y-auto relative">
      <!-- 空状态提示 -->
      <div
        v-if="!fields.length"
        class="absolute inset-0 flex flex-col items-center justify-center pointer-events-none transition-all duration-200"
        :class="canvasAddActive ? 'opacity-100' : 'opacity-60'"
      >
        <div
          class="w-64 h-40 rounded-2xl border-2 border-dashed flex flex-col items-center justify-center gap-3 transition-colors duration-200"
          :class="canvasAddActive ? 'border-blue-400 bg-blue-50' : 'border-gray-300 bg-white'"
        >
          <span class="text-4xl">📋</span>
          <p class="text-sm font-medium" :class="canvasAddActive ? 'text-blue-500' : 'text-gray-400'">
            {{ canvasAddActive ? '松开鼠标添加字段' : '从左侧拖入字段类型' }}
          </p>
        </div>
      </div>

      <!-- 字段列表 -->
      <TransitionGroup
        tag="div"
        name="field-list"
        class="relative overflow-hidden py-2 px-3 flex flex-col gap-1"
        @before-leave="onBeforeLeave"
        @leave="onLeave"
        @after-leave="onAfterLeave"
      >
        <div
          v-for="(field, index) in fields"
          :key="field.id"
          draggable="true"
          @dragstart="emit('fieldDragStart', $event, index, field.id)"
          @dragover.stop="emit('fieldDragOver', $event, index)"
          @dragend="emit('fieldDragEnd')"
          class="field-row field-grid px-3 py-2 rounded-xl border transition-colors duration-150 cursor-pointer select-none"
          :class="[
            selectedId === field.id
              ? 'border-blue-400 bg-blue-50 shadow-sm'
              : 'border-gray-200 bg-white hover:border-blue-200 hover:bg-gray-50',
            draggingId === field.id ? 'opacity-40 scale-[0.98]' : ''
          ]"
          @click="emit('select', field.id)"
        >
          <span class="text-xs text-gray-400 text-center">{{ index + 1 }}</span>
          <span class="text-gray-300 cursor-grab active:cursor-grabbing text-center">⠿</span>

          <div class="min-w-0" @click.stop>
            <input
              :id="`key-input-${field.id}`"
              v-model="field.key"
              placeholder="字段名（必填）"
              class="w-full text-sm bg-transparent border-none outline-none text-gray-800 placeholder-gray-300"
              @focus="emit('select', field.id)"
            />
          </div>

          <div class="min-w-0 flex justify-center overflow-hidden">
            <div class="flex flex-nowrap justify-center gap-1 max-w-full overflow-hidden">
              <span
                v-for="bsonType in getBsonTypeList(field.bsonType)"
                :key="bsonType"
                class="px-2 py-0.5 rounded-full text-xs text-white font-medium shrink-0 whitespace-nowrap"
                :style="{ backgroundColor: getTypeDef(bsonType).color }"
                :title="getTypeDef(bsonType).desc"
              >{{ getTypeDef(bsonType).label }}</span>
            </div>
          </div>

          <div class="min-w-0 flex justify-center">
            <span
              v-if="field.formType"
              class="px-2 py-0.5 rounded-full text-xs font-medium border border-blue-200 bg-blue-50 text-blue-600 truncate max-w-full"
              :title="field.formType"
            >{{ field.formType }}</span>
            <span v-else class="text-xs text-gray-300">—</span>
          </div>

          <div class="flex justify-center" @click.stop>
            <el-checkbox v-model="field.required" />
          </div>

          <div class="flex items-center justify-end gap-1" @click.stop>
            <button
              class="p-1 text-gray-400 hover:text-blue-500 disabled:opacity-30 transition-colors"
              :disabled="index === 0"
              @click="emit('moveUp', index)"
            >
              <el-icon><ArrowUp /></el-icon>
            </button>
            <button
              class="p-1 text-gray-400 hover:text-blue-500 disabled:opacity-30 transition-colors"
              :disabled="index === fields.length - 1"
              @click="emit('moveDown', index)"
            >
              <el-icon><ArrowDown /></el-icon>
            </button>
            <button
              class="p-1 text-gray-400 hover:text-green-500 transition-colors"
              @click="emit('duplicate', field.id)"
            >⧉</button>
            <button
              class="p-1 text-gray-400 hover:text-red-500 transition-colors"
              @click="emit('delete', field.id)"
            >✕</button>
          </div>
        </div>
      </TransitionGroup>

      <!-- 底部拖入提示 -->
      <div
        v-if="fields.length"
        class="mx-3 mb-2 flex items-center justify-center h-12 rounded-xl border-2 border-dashed transition-colors duration-200"
        :class="canvasAddActive ? 'border-blue-400 bg-blue-50' : 'border-gray-200'"
      >
        <span class="text-xs" :class="canvasAddActive ? 'text-blue-500' : 'text-gray-400'">
          {{ canvasAddActive ? '松开以添加字段' : '拖入新字段' }}
        </span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.field-row {
  user-select: none;
}

.field-grid {
  display: grid;
  grid-template-columns: 1.25rem 1.25rem minmax(0, 1fr) 45rem 6rem 3.5rem 7rem;
  align-items: center;
  column-gap: 0.5rem;
}

.canvas-scroll {
  scrollbar-gutter: stable;
}

.field-list-move {
  transition: transform 220ms cubic-bezier(0.25, 0.8, 0.25, 1);
}
.field-list-enter-active {
  transition: all 220ms cubic-bezier(0.25, 0.8, 0.25, 1);
}
.field-list-enter-from {
  opacity: 0;
  transform: translateX(-16px);
}
.field-list-leave-active {
  pointer-events: none;
  transition:
    opacity 180ms cubic-bezier(0.4, 0, 1, 1),
    transform 180ms cubic-bezier(0.25, 0.8, 0.25, 1);
}
.field-list-leave-to {
  opacity: 0;
  transform: translateX(32px);
}
</style>
