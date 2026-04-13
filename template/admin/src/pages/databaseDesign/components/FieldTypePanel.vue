<script setup lang="ts">
import { Plus } from '@element-plus/icons-vue'
import { TYPE_DEFS, type BsonType } from '../types'

const emit = defineEmits<{
  dragStart: [e: DragEvent, bsonType: BsonType]
  dragEnd: []
  add: [bsonType: BsonType]
}>()
</script>

<template>
  <div class="left-panel w-44 bg-[var(--el-bg-color)] border-r border-[var(--el-border-color)] flex flex-col overflow-y-auto flex-shrink-0">
    <div class="px-3 py-2 text-xs font-semibold text-[var(--el-text-color-secondary)] uppercase tracking-wider border-b border-[var(--el-border-color-lighter)] select-none">
      字段类型
    </div>
    <div class="p-2 flex flex-col gap-1">
      <div
        v-for="t in TYPE_DEFS"
        :key="t.bsonType"
        draggable="true"
        @dragstart="emit('dragStart', $event, t.bsonType)"
        @dragend="emit('dragEnd')"
        class="type-card flex items-center gap-2 px-2 py-2 rounded-lg cursor-grab
               border border-transparent hover:border-[var(--el-color-primary-light-5)] hover:bg-[var(--el-color-primary-light-9)]
               active:cursor-grabbing select-none transition-all duration-150 group"
      >
        <span
          class="w-7 h-7 rounded-md flex items-center justify-center text-white text-xs font-bold flex-shrink-0"
          :style="{ backgroundColor: t.color }"
        >{{ t.icon }}</span>
        <div class="min-w-0">
          <div class="text-sm font-medium text-[var(--el-text-color-primary)] leading-tight">{{ t.label }}</div>
          <div class="text-xs text-[var(--el-text-color-secondary)] leading-tight truncate">{{ t.desc }}</div>
        </div>
        <el-button
          type="primary"
          text
          bg
          size="small"
          draggable="false"
          class="type-add-btn ml-auto"
          :icon="Plus"
          title="直接添加字段"
          @mousedown.stop
          @click.stop="emit('add', t.bsonType)"
        />
      </div>
    </div>
    <div class="mt-auto px-3 py-3 text-xs text-[var(--el-text-color-secondary)] border-t border-[var(--el-border-color-lighter)]">
      ← 拖拽到中间添加字段
    </div>
  </div>
</template>

<style scoped>
.left-panel::-webkit-scrollbar {
  width: 4px;
}
.left-panel::-webkit-scrollbar-thumb {
  background: var(--el-fill-color-darker);
  border-radius: 4px;
}

.type-card {
  transition: transform 0.1s ease;
}
.type-card:active {
  transform: scale(0.97);
}

:deep(.type-add-btn) {
  width: 24px;
  height: 24px;
  padding: 0;
  border-radius: 0.375rem;
  color: var(--el-color-primary) !important;
  background: var(--el-color-primary-light-9) !important;
  border: 1px solid var(--el-color-primary-light-5) !important;
  box-shadow: 0 1px 2px color-mix(in srgb, var(--el-color-primary) 12%, transparent);
}

:deep(.type-add-btn:hover) {
  color: var(--el-color-primary-dark-2) !important;
  background: var(--el-color-primary-light-8) !important;
  border-color: var(--el-color-primary-light-3) !important;
  transform: scale(1.05);
}
</style>
