<script lang="tsx" setup>
import { ref, watch } from 'vue'
import { UploadFilled } from '@element-plus/icons-vue'
import http from '@/utils/axios'

type SizeUnit = 'KB' | 'MB' | 'GB'

const props = withDefaults(defineProps<{
  modelValue?: string | string[] | null
  limit?: number
  multiple?: boolean
  fileSize?: number
  sizeUnit?: SizeUnit
  buttonText?: string
  categoryId?: string
  needSave?: boolean
  autoUpload?: boolean
  tempFileType?: 'tempPath' | 'base64'
  httpRequest?: (file: File) => Promise<string>
  drag?: boolean
  uploadProps?: Record<string, any>
  disabled?: boolean
}>(), {
  modelValue: null,
  limit: undefined,
  multiple: false,
  fileSize: undefined,
  sizeUnit: 'MB',
  buttonText: '上传文件',
  categoryId: undefined,
  needSave: undefined,
  autoUpload: true,
  tempFileType: 'tempPath',
  httpRequest: undefined,
  drag: false,
  uploadProps: undefined,
  disabled: false,
})

const emit = defineEmits<{
  (e: 'update:modelValue', val: string | string[] | null): void
}>()

const isSingle = computed(() => props.limit === 1)

const fileUploadList = ref<any[]>([])
const fileUidUrlMap = new Map<number, string>()

const getFileUrls = () => Array.from(fileUidUrlMap.values())

const emitValue = () => {
  const urls = getFileUrls()
  emit('update:modelValue', isSingle.value ? (urls[0] ?? null) : urls)
}

// 外部值回填
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

// 提示
const fileExceedTip = ref('')
const fileSizeTip = ref('')
let fileExceedTimer: ReturnType<typeof setTimeout> | null = null
let fileSizeTimer: ReturnType<typeof setTimeout> | null = null

const showTip = (tipRef: typeof fileExceedTip, timerRef: { value: ReturnType<typeof setTimeout> | null }, msg: string) => {
  tipRef.value = msg
  if (timerRef.value) clearTimeout(timerRef.value)
  timerRef.value = setTimeout(() => { tipRef.value = '' }, 3000)
}

const beforeUpload = (file: File) => {
  if (props.fileSize) {
    const unitMap: Record<SizeUnit, number> = { KB: 1024, MB: 1024 ** 2, GB: 1024 ** 3 }
    if (file.size > props.fileSize * unitMap[props.sizeUnit ?? 'MB']) {
      showTip(fileSizeTip, { value: fileSizeTimer }, `文件大小不能超过 ${props.fileSize}${props.sizeUnit}`)
      return false
    }
  }
  return true
}

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

const updateFileList = (v: any[]) => { fileUploadList.value = v }
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
      :drag="drag"
      @update:file-list="updateFileList"
    >
      <template v-if="drag">
        <el-icon class="el-icon--upload"><upload-filled /></el-icon>
        <div class="el-upload__text">拖拽文件到此处，或<em>点击上传</em></div>
      </template>
      <el-button v-else type="primary" :disabled="disabled">{{ buttonText }}</el-button>
    </el-upload>
    <div v-if="fileExceedTip" class="text-[#f56c6c] text-[12px] mt-[4px]">{{ fileExceedTip }}</div>
    <div v-if="fileSizeTip" class="text-[#f56c6c] text-[12px] mt-[4px]">{{ fileSizeTip }}</div>
  </div>
</template>
