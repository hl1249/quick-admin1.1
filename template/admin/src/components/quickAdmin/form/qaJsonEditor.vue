<template>
  <div class="qa-json-editor" :style="{ width: width }">
    <v-ace-editor
      v-model:value="innerValue"
      lang="json"
      theme="chrome"
      :style="{ height: height }"
      :options="editorOptions"
      :readonly="readonly"
      @change="handleChange"
    />
    <div v-if="errorMsg" class="qa-json-editor__error">{{ errorMsg }}</div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, computed } from 'vue'
import { VAceEditor } from 'vue3-ace-editor'
import 'ace-builds/src-noconflict/mode-json'
import 'ace-builds/src-noconflict/theme-chrome'
import 'ace-builds/src-noconflict/ext-language_tools'

interface Props {
  modelValue?: any
  width?: string
  height?: string
  readonly?: boolean
  placeholder?: string
}

const props = withDefaults(defineProps<Props>(), {
  modelValue: null,
  width: '100%',
  height: '200px',
  readonly: false,
  placeholder: '请输入 JSON',
})

const emit = defineEmits<{
  'update:modelValue': [val: any]
}>()

const errorMsg = ref('')

const editorOptions = {
  enableBasicAutocompletion: true,
  enableLiveAutocompletion: true,
  enableSnippets: true,
  fontSize: 14,
  showPrintMargin: false,
  tabSize: 2,
  useSoftTabs: true,
}

const toEditorString = (val: any): string => {
  if (val === null || val === undefined) return ''
  if (typeof val === 'string') return val
  try {
    return JSON.stringify(val, null, 2)
  } catch {
    return String(val)
  }
}

const innerValue = ref(toEditorString(props.modelValue))

watch(
  () => props.modelValue,
  (val) => {
    const str = toEditorString(val)
    if (str !== innerValue.value) {
      innerValue.value = str
    }
  }
)

const handleChange = () => {
  const raw = innerValue.value
  if (!raw || !raw.trim()) {
    errorMsg.value = ''
    emit('update:modelValue', null)
    return
  }
  try {
    const parsed = JSON.parse(raw)
    errorMsg.value = ''
    emit('update:modelValue', parsed)
  } catch {
    errorMsg.value = 'JSON 格式错误'
  }
}
</script>

<style scoped>
.qa-json-editor {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.qa-json-editor__error {
  font-size: 12px;
  color: var(--el-color-danger);
  line-height: 1.4;
}
</style>
