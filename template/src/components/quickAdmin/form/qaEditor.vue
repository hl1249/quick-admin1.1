<script lang="ts" setup>
import '@wangeditor-next/editor/dist/css/style.css'
import { onBeforeUnmount, shallowRef, watch } from 'vue'
import { Editor, Toolbar } from '@wangeditor-next/editor-for-vue'
import type { IDomEditor, IEditorConfig, IToolbarConfig } from '@wangeditor-next/editor'
import http from '@/utils/axios'

interface Props {
  modelValue?: string
  placeholder?: string
  disabled?: boolean
  height?: string | number
  toolbarConfig?: Partial<IToolbarConfig>
  editorConfig?: Partial<IEditorConfig>
}

const props = withDefaults(defineProps<Props>(), {
  modelValue: '',
  placeholder: '请输入内容...',
  disabled: false,
  height: '320px',
})

const emit = defineEmits<{
  'update:modelValue': [val: string]
}>()

const editorRef = shallowRef<IDomEditor | null>(null)

async function uploadFile(file: File): Promise<string> {
  const formData = new FormData()
  formData.append('file', file)
  const res = await http.request({
    url: '/app/admin/system/systemFile/systemFile/upload',
    method: 'post',
    data: formData,
    openMessage: false,
  })
  return res.data?.data?.url as string
}

const toolbarConfig = computed<Partial<IToolbarConfig>>(() => ({
  ...props.toolbarConfig,
}))

const editorConfig = computed<Partial<IEditorConfig>>(() => ({
  placeholder: props.placeholder,
  readOnly: props.disabled,
  MENU_CONF: {
    uploadImage: {
      async customUpload(file: File, insertFn: (url: string, alt: string, href: string) => void) {
        const url = await uploadFile(file)
        insertFn(url, '', url)
      },
    },
    uploadVideo: {
      async customUpload(file: File, insertFn: (url: string, poster: string) => void) {
        const url = await uploadFile(file)
        insertFn(url, '')
      },
    },
    ...props.editorConfig?.MENU_CONF,
  },
  ...props.editorConfig,
}))

const editorHeight = computed(() =>
  typeof props.height === 'number' ? `${props.height}px` : props.height
)

function handleCreated(editor: any) {
  editorRef.value = editor
}

function handleChange(editor: any) {
  const html = editor.isEmpty() ? '' : editor.getHtml()
  emit('update:modelValue', html)
}

watch(
  () => props.modelValue,
  (val) => {
    const editor = editorRef.value as any
    if (!editor) return
    if (val === editor.getHtml()) return
    editor.setHtml(val ?? '')
  }
)

onBeforeUnmount(() => {
  const editor = editorRef.value as any
  editor?.destroy()
  editorRef.value = null
})
</script>

<template>
  <div class="qa-editor" :class="{ 'is-disabled': disabled }">
    <Toolbar
      class="qa-editor__toolbar"
      :editor="editorRef ?? undefined"
      :defaultConfig="toolbarConfig"
      mode="simple"
    />
    <Editor
      class="qa-editor__body"
      :style="{ height: editorHeight }"
      :defaultConfig="editorConfig"
      :defaultContent="[]"
      mode="simple"
      @onCreated="handleCreated"
      @onChange="handleChange"
    />
  </div>
</template>

<style scoped>
.qa-editor {
  border: 1px solid var(--el-border-color);
  border-radius: var(--el-border-radius-base);
  overflow: hidden;
  line-height: normal;
}

.qa-editor__toolbar {
  border-bottom: 1px solid var(--el-border-color);
}

.qa-editor__body {
  overflow-y: auto;
}

.qa-editor.is-disabled {
  background-color: var(--el-disabled-bg-color);
  cursor: not-allowed;
}
</style>
