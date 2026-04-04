<template>
  <el-dialog
    v-bind="$attrs"
    :model-value="modelValue"
    :title="title"
    :width="width"
    :fullscreen="isFullscreen"
    :close-on-click-modal="closeOnClickModal"
    :show-close="false"
    @update:model-value="onUpdateVisible"
  >
    <template #header>
      <div class="qa-dialog-header flex items-center gap-3 w-full min-w-0 -mr-2">
        <span class="flex-1 min-w-0 text-base font-medium leading-6 text-[var(--el-text-color-primary)] truncate">
          <slot name="title">{{ title }}</slot>
        </span>
        <div v-if="showFullscreenButton || showCloseButton" class="flex items-center shrink-0">
          <el-tooltip v-if="showFullscreenButton" :content="isFullscreen ? '退出全屏' : '全屏'" placement="bottom">
            <el-button text circle class="!p-2" @click="toggleFullscreen">
              <el-icon :size="18">
                <ScaleToOriginal v-if="isFullscreen" />
                <FullScreen v-else />
              </el-icon>
            </el-button>
          </el-tooltip>
          <el-tooltip v-if="showCloseButton" content="关闭" placement="bottom">
            <el-button text circle class="!p-2" @click="close">
              <el-icon :size="18">
                <Close />
              </el-icon>
            </el-button>
          </el-tooltip>
        </div>
      </div>
    </template>
    <slot />
    <template v-if="$slots.footer" #footer>
      <slot name="footer" />
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import { Close, FullScreen, ScaleToOriginal } from '@element-plus/icons-vue'

defineOptions({ inheritAttrs: false })

const props = withDefaults(
  defineProps<{
    modelValue: boolean
    title?: string
    width?: string | number
    closeOnClickModal?: boolean
    /** 头部是否显示关闭按钮（上传中等场景可设为 false） */
    showCloseButton?: boolean
    /** 头部是否显示全屏切换 */
    showFullscreenButton?: boolean
  }>(),
  {
    title: '',
    width: '700',
    closeOnClickModal: false,
    showCloseButton: true,
    showFullscreenButton: true,
  }
)

const emit = defineEmits<{
  'update:modelValue': [value: boolean]
}>()

const isFullscreen = ref(false)


function toggleFullscreen() {
  isFullscreen.value = !isFullscreen.value
}

function close() {
  emit('update:modelValue', false)
}

function onUpdateVisible(value: boolean) {
  emit('update:modelValue', value)
}
</script>
