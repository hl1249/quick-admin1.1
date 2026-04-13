<script setup lang="ts">
import { ref, watch, type Ref } from 'vue'
import http from '@/utils/axios'

const props = withDefaults(defineProps<{
  modelValue?: string | string[] | null
  multiple?: boolean
  limit?: number
  autoUpload?: boolean
  tempFileType?: 'tempPath' | 'base64'
  fileSize?: number
  sizeUnit?: 'KB' | 'MB' | 'GB'
  httpRequest?: (file: File) => Promise<string>
  categoryId?: string
  needSave?: boolean
  buttonText?: string
  disabled?: boolean
  uploadProps?: Record<string, any>
}>(), {
  multiple: false,
  autoUpload: true,
  sizeUnit: 'MB',
  disabled: false,
})

const emit = defineEmits<{
  'update:modelValue': [val: string | string[] | null]
}>()

const isSingle = computed(() => props.limit === 1)

/* ---------------- 文件列表状态 ---------------- */
const fileUploadList = ref<any[]>([])
const fileUidUrlMap = new Map<number, string>()
const getFileUrls = () => Array.from(fileUidUrlMap.values())

const emitValue = () => {
  const urls = getFileUrls()
  emit('update:modelValue', isSingle.value ? (urls[0] ?? null) : urls)
}

// 外部值变化时（编辑回填 / 表单重置）同步列表
watch(
  () => props.modelValue,
  (newVal) => {
    const newUrls: string[] = Array.isArray(newVal) ? newVal : newVal ? [newVal] : []
    if (JSON.stringify(getFileUrls().sort()) === JSON.stringify([...newUrls].sort())) return
    fileUidUrlMap.clear()
    fileUploadList.value = newUrls.map((url, i) => {
      const uid = Date.now() + i
      fileUidUrlMap.set(uid, url)
      return { name: url.split('/').pop() || `file-${i + 1}`, url, uid, status: 'success' }
    })
  },
  { immediate: true }
)

/* ---------------- 提示 ---------------- */
const fileExceedTip = ref('')
const fileSizeTip = ref('')
let fileExceedTimer: ReturnType<typeof setTimeout> | null = null
let fileSizeTimer: ReturnType<typeof setTimeout> | null = null

const showTip = (tipRef: Ref<string>, timerRef: { value: ReturnType<typeof setTimeout> | null }, msg: string) => {
  tipRef.value = msg
  if (timerRef.value) clearTimeout(timerRef.value)
  timerRef.value = setTimeout(() => { tipRef.value = '' }, 3000)
}

/* ---------------- 上传逻辑 ---------------- */
const convertLocalFile = (file: File, uid: number): Promise<void> =>
  new Promise((resolve) => {
    if (props.tempFileType === 'base64') {
      const reader = new FileReader()
      reader.onload = (e) => {
        fileUidUrlMap.set(uid, e.target?.result as string)
        emitValue()
        resolve()
      }
      reader.readAsDataURL(file)
    } else {
      fileUidUrlMap.set(uid, URL.createObjectURL(file))
      emitValue()
      resolve()
    }
  })

const beforeUpload = (file: File) => {
  if (props.fileSize) {
    const unitMap = { KB: 1024, MB: 1024 ** 2, GB: 1024 ** 3 }
    const unit = props.sizeUnit ?? 'MB'
    if (file.size > props.fileSize * unitMap[unit]) {
      showTip(fileSizeTip, { value: fileSizeTimer }, `文件大小不能超过 ${props.fileSize}${unit}`)
      return false
    }
  }
  return true
}

const handleUpload = async (options: any) => {
  if (!props.autoUpload) {
    await convertLocalFile(options.file, options.file.uid)
    options.onSuccess({})
    return
  }

  if (props.httpRequest) {
    try {
      const url = await props.httpRequest(options.file)
      fileUidUrlMap.set(options.file.uid, url)
      emitValue()
      options.onSuccess({ url })
    } catch (err) {
      options.onError(err)
    }
    return
  }

  const formData = new FormData()
  formData.append('file', options.file)
  if (props.categoryId) formData.append('category_id', props.categoryId)
  if (props.needSave === false) formData.append('needSave', 'false')
  try {
    const res = await http.request({
      url: '/app/admin/system/systemFile/systemFile/upload',
      method: 'post',
      data: formData,
      openMessage: false,
    })
    fileUidUrlMap.set(options.file.uid, res.data?.data?.url)
    emitValue()
    options.onSuccess(res.data?.data)
  } catch (err) {
    options.onError(err)
  }
}

const handleExceed = () => {
  if (!props.limit) return
  showTip(fileExceedTip, { value: fileExceedTimer }, `最多只能上传 ${props.limit} 个文件`)
}

const handleRemove = (file: any) => {
  fileUidUrlMap.delete(file.uid)
  emitValue()
}
</script>

<template>
  <div>
    <el-upload
      v-bind="uploadProps"
      :file-list="fileUploadList"
      :http-request="handleUpload"
      :before-upload="beforeUpload"
      :on-remove="handleRemove"
      :on-exceed="handleExceed"
      :multiple="multiple"
      :limit="limit"
      :disabled="disabled"
      @update:file-list="(v: any[]) => { fileUploadList = v }"
    >
      <el-button type="primary" :disabled="disabled">
        {{ buttonText ?? '上传文件' }}
      </el-button>
    </el-upload>
    <div v-if="fileExceedTip" class="text-[#f56c6c] text-[12px] mt-[4px]">{{ fileExceedTip }}</div>
    <div v-if="fileSizeTip" class="text-[#f56c6c] text-[12px] mt-[4px]">{{ fileSizeTip }}</div>
  </div>
</template>
