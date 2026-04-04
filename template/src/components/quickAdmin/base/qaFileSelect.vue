<template>
  <div>
    <!-- 已选预览 + 添加按钮 -->
    <div class="qa-fs-preview-wrap">
      <div
        v-for="(item, index) in previewFiles"
        :key="item.id"
        class="qa-fs-preview-item"
      >
        <el-image v-if="fileType === 'image'" :src="item.url" :fit="imageFit" class="qa-fs-preview-media" />
        <video v-else-if="fileType === 'video'" :src="item.url" class="qa-fs-preview-media" muted preload="metadata" />
        <div v-else class="qa-fs-preview-other">
          <el-icon :size="22"><Document /></el-icon>
          <span class="qa-fs-preview-other-name">{{ item.name || '文件' }}</span>
        </div>
        <div class="qa-fs-preview-remove" @click="handleRemove(index)">
          <el-icon :size="12"><CircleClose /></el-icon>
        </div>
      </div>
      <div v-if="canAddMore" class="qa-fs-add-btn" @click="handleOpen">
        <el-icon :size="22"><Plus /></el-icon>
      </div>
    </div>

    <!-- 选择对话框 -->
    <qa-dialog v-model="dialogVisible" :title="dialogTitle" width="920px">
      <div class="qa-fs-layout">
        <!-- 分类侧栏 -->
        <div v-loading="categoryLoading" class="qa-fs-sidebar">
          <!-- 添加分组 -->
          <el-popover
            v-if="updateCategory"
            :visible="addCategoryVisible"
            @update:visible="addCategoryVisible = $event"
            trigger="click"
            :width="220"
            placement="right-start"
          >
            <template #reference>
              <div class="qa-fs-add-category-btn">添加分组</div>
            </template>
            <div class="qa-fs-add-category-form">
              <el-input
                v-model="categoryInputName"
                placeholder="请输入分组名称"
                size="small"
                @keyup.enter="handleAddCategory"
              />
              <div class="qa-fs-add-category-footer">
                <el-button type="primary" size="small" :loading="addCategoryLoading" @click="handleAddCategory">
                  确认
                </el-button>
              </div>
            </div>
          </el-popover>

          <!-- 分类列表 -->
          <div class="qa-fs-category-list">
            <div
              v-for="cat in allCategories"
              :key="cat.value"
              class="qa-fs-category-item"
              :class="{ 'is-active': activeCategory === cat.value }"
              @click="handleCategorySelect(cat.value)"
            >
              {{ cat.label }}
            </div>
          </div>
        </div>

        <!-- 右侧内容区 -->
        <div class="qa-fs-content">
          <!-- 工具栏 -->
          <div class="qa-fs-toolbar">
            <div>
              <input
                ref="uploadInputRef"
                type="file"
                :accept="uploadAccept"
                multiple
                class="qa-fs-hidden-input"
                @change="handleUpload"
              />
              <el-button v-if="upload" type="primary" :loading="uploadLoading" :icon="Plus" @click="uploadInputRef?.click()">
                上传到此分组
              </el-button>
            </div>
            <el-input
              v-model="searchName"
              placeholder="搜索名称"
              clearable
              class="qa-fs-search"
              @keyup.enter="handleSearch"
              @clear="handleSearch"
            />
          </div>

          <!-- 文件网格 -->
          <div v-loading="fileLoading" class="qa-fs-grid-wrap">
            <el-empty v-if="!fileLoading && fileList.length === 0" description="此分组为空" :image-size="80" />
            <div v-else class="qa-fs-grid">
              <div
                v-for="item in fileList"
                :key="item._id"
                class="qa-fs-card"
                :class="{
                  'is-selected': tempSelectedIds.includes(item._id),
                  'is-disabled': !tempSelectedIds.includes(item._id) && isMultiple && multipleLimit > 0 && tempSelectedIds.length >= multipleLimit,
                }"
                @click="toggleSelect(item)"
              >
                <div class="qa-fs-card-preview">
                  <el-image v-if="fileType === 'image'" :src="item.url" :fit="imageFit" class="qa-fs-card-media" />
                  <video v-else-if="fileType === 'video'" :src="item.url" class="qa-fs-card-media" muted preload="metadata" />
                  <div v-else class="qa-fs-card-other">
                    <el-icon :size="28"><Document /></el-icon>
                  </div>
                </div>
                <div class="qa-fs-card-name" :title="item.original_name || item.display_name || '未命名'">
                  {{ item.original_name || item.display_name || '未命名' }}
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>

      <template #footer>
        <div class="qa-fs-footer">
          <el-pagination
            :current-page="query.pageIndex"
            :page-size="query.pageSize"
            :total="total"
            background
            layout="total, prev, pager, next"
            @current-change="(page) => { query.pageIndex = page; loadFileList() }"
          />
          <el-button type="primary" @click="handleConfirm">
            {{ `选中 ${tempSelectedIds.length}/${multipleLimit}` }}
          </el-button>
        </div>
      </template>
    </qa-dialog>

    <!-- 上传进度弹窗 -->
    <qa-dialog
      v-model="uploadProgressVisible"
      title="上传进度"
      width="560"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
      :show-close-button="!uploadLoading"
      :show-fullscreen-button="false"
    >
      <div class="qa-fs-progress-dialog">
        <div class="qa-fs-progress-summary">
          <div class="qa-fs-progress-summary-top">
            <div class="qa-fs-progress-summary-title-wrap">
              <span class="qa-fs-progress-summary-title">总进度</span>
              <span class="qa-fs-progress-summary-desc">
                {{ uploadLoading ? '正在上传文件...' : '上传完成' }}
              </span>
            </div>
            <span class="qa-fs-progress-summary-value">{{ totalUploadCountProgress }}</span>
          </div>
          <el-progress :percentage="totalUploadProgress" :stroke-width="12" />
        </div>

        <div class="qa-fs-progress-list">
          <div v-for="task in uploadTasks" :key="task.id" class="qa-fs-progress-item">
            <div class="qa-fs-progress-item-inner">
              <div class="qa-fs-progress-item-preview">
                <el-image v-if="task.previewUrl && task.isImage" :src="task.previewUrl" fit="cover" class="qa-fs-progress-item-media" />
                <video v-else-if="task.previewUrl && task.isVideo" :src="task.previewUrl" class="qa-fs-progress-item-media" muted playsinline preload="metadata" />
                <div v-else class="qa-fs-progress-item-empty">
                  <el-icon><Document /></el-icon>
                </div>
              </div>
              <div class="qa-fs-progress-item-main">
                <div class="qa-fs-progress-item-top">
                  <span class="qa-fs-progress-item-name" :title="task.name">{{ task.name }}</span>
                </div>
                <el-progress
                  :percentage="task.progress"
                  :status="task.status === 'error' ? 'exception' : task.status === 'success' ? 'success' : undefined"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </qa-dialog>
  </div>
</template>

<script setup lang="ts">
import { CircleClose, Plus, Document } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import http from '@/utils/axios'

interface FileItem {
  _id: string
  url: string
  original_name?: string
  display_name?: string
}

interface PreviewItem {
  id: string
  url: string
  name?: string
}

interface CategoryItem {
  label: string
  value: string
}

interface UploadTaskItem {
  id: string
  name: string
  previewUrl: string
  isImage: boolean
  isVideo: boolean
  progress: number
  loaded: number
  total: number
  status: 'uploading' | 'success' | 'error'
  statusText: string
}

const props = withDefaults(defineProps<{
  modelValue?: string | string[] | null
  fileType?: 'image' | 'video' | 'other'
  multiple?: boolean | number
  multipleLimit?: number
  defaultCategory?: string
  upload?: boolean
  updateCategory?: boolean
  imageFit?: 'fill' | 'contain' | 'cover' | 'none' | 'scale-down'
  fileSize?: number
  sizeUnit?: 'KB' | 'MB' | 'GB'
  returnType?: 'url' | 'id'
}>(), {
  modelValue: null,
  fileType: 'image',
  multiple: false,
  multipleLimit: 1,
  defaultCategory: '',
  upload: true,
  updateCategory: true,
  imageFit: 'cover',
  sizeUnit: 'MB',
  returnType: 'url',
})

const emit = defineEmits<{
  'update:modelValue': [val: string | string[] | null]
}>()

const CATEGORY_ALL = 'all'
const CATEGORY_UNGROUPED = 'null'

const isMultiple = computed(() => Boolean(props.multiple))

// 有效上传 accept
const uploadAccept = computed(() => {
  if (props.fileType === 'image') return 'image/*'
  if (props.fileType === 'video') return 'video/*'
  return '*/*'
})

// 对话框标题
const dialogTitle = computed(() => {
  const map = { image: '图片', video: '视频', other: '文件' }
  return `选择${map[props.fileType] ?? '文件'}`
})

// ---- 预览文件列表（供外部预览区显示） ----
const previewFiles = ref<PreviewItem[]>([])

// 从 modelValue 解析/加载预览项
const syncPreviewFiles = async (val: string | string[] | null | undefined) => {
  const rawIds: string[] = Array.isArray(val) ? val : (val ? [val] : [])
  if (!rawIds.length) {
    previewFiles.value = []
    return
  }

  if (props.returnType === 'url') {
    previewFiles.value = rawIds.map(url => ({ id: url, url, name: url.split('/').pop() || '' }))
    return
  }

  // returnType === 'id'：已有缓存的直接复用，缺失的批量拉取
  const cached = previewFiles.value
  const missingIds = rawIds.filter(id => !cached.some(f => f.id === id))
  let allItems = [...cached]

  if (missingIds.length) {
    try {
      const res = await http.request({
        url: '/app/admin/system/systemFile/systemFile/files/getList',
        method: 'post',
        data: {
          formData: { _id: missingIds },
          columns: [{ key: '_id', mode: 'in' }],
          pageIndex: 1,
          pageSize: missingIds.length,
        },
      })
      const rows: any[] = res?.data?.data?.rows || []
      allItems = [
        ...allItems,
        ...rows.map(item => ({
          id: String(item._id),
          url: item.url,
          name: item.original_name || item.display_name || '',
        })),
      ]
    } catch { /* 拉取失败时降级显示 ID */ }
  }

  previewFiles.value = rawIds.map(id => allItems.find(f => f.id === id) ?? { id, url: '', name: id })
}

watch(() => props.modelValue, syncPreviewFiles, { immediate: true })

// 是否还能继续添加
const canAddMore = computed(() => {
  if (!isMultiple.value) return previewFiles.value.length === 0
  if (props.multipleLimit > 0) return previewFiles.value.length < props.multipleLimit
  return true
})

// ---- 选择对话框 ----
const dialogVisible = ref(false)

// ---- 分类 ----
const activeCategory = ref(CATEGORY_ALL)
const categories = ref<CategoryItem[]>([])
const categoryLoading = ref(false)
const addCategoryVisible = ref(false)
const categoryInputName = ref('')
const addCategoryLoading = ref(false)

const allCategories = computed<CategoryItem[]>(() => [
  { label: '全部', value: CATEGORY_ALL },
  { label: '未分组', value: CATEGORY_UNGROUPED },
  ...categories.value,
])

const getCategoryFilter = () => {
  if (activeCategory.value === CATEGORY_ALL) return undefined
  if (activeCategory.value === CATEGORY_UNGROUPED) return null
  return activeCategory.value
}

const loadCategories = async () => {
  categoryLoading.value = true
  try {
    const res = await http.request({
      url: '/app/admin/system/systemFile/systemCategories/getList',
      method: 'post',
      data: { type: props.fileType },
    })
    const rows: any[] = res?.data?.data?.rows || []
    categories.value = rows.map((item, i) => ({
      label: item.name || item.title || item.label || `分类${i + 1}`,
      value: String(item._id || item.id || i),
    }))
  } finally {
    categoryLoading.value = false
  }
}

const handleAddCategory = async () => {
  if (!categoryInputName.value.trim()) {
    ElMessage.warning('请输入分类名称')
    return
  }
  addCategoryLoading.value = true
  try {
    await http.request({
      url: '/app/admin/system/systemFile/systemCategories/add',
      method: 'post',
      data: { name: categoryInputName.value.trim(), type: props.fileType },
    })
    ElMessage.success('添加成功')
    categoryInputName.value = ''
    addCategoryVisible.value = false
    await loadCategories()
  } finally {
    addCategoryLoading.value = false
  }
}

const handleCategorySelect = async (value: string) => {
  activeCategory.value = value
  query.pageIndex = 1
  await loadFileList()
}

// ---- 文件列表 ----
const fileList = ref<FileItem[]>([])
const total = ref(0)
const fileLoading = ref(false)
const query = reactive({ pageIndex: 1, pageSize: 20 })
const searchName = ref('')

const loadFileList = async () => {
  fileLoading.value = true
  try {
    const formData: Record<string, any> = {
      category_id: getCategoryFilter(),
      original_name: searchName.value,
    }
    if (props.fileType !== 'other') formData.type = props.fileType

    const res = await http.request({
      url: '/app/admin/system/systemFile/systemFile/files/getList',
      method: 'post',
      data: {
        formData,
        columns: [
          ...(props.fileType !== 'other' ? [{ key: 'type', mode: '=' }] : []),
          { key: 'category_id', mode: '=' },
          { key: 'original_name', mode: '%%' },
        ],
        pageIndex: query.pageIndex,
        pageSize: query.pageSize,
      },
    })
    const data = res?.data?.data || {}
    fileList.value = data.rows || []
    total.value = data.total || 0
  } finally {
    fileLoading.value = false
  }
}

const handleSearch = () => {
  query.pageIndex = 1
  loadFileList()
}

// ---- 上传（含进度） ----
const uploadInputRef = ref<HTMLInputElement | null>(null)
const uploadLoading = ref(false)
const uploadProgressVisible = ref(false)
const uploadTasks = ref<UploadTaskItem[]>([])

const totalUploadProgress = computed(() => {
  if (!uploadTasks.value.length) return 0
  const totalBytes = uploadTasks.value.reduce((sum, t) => sum + (t.total > 0 ? t.total : 1), 0)
  const loadedBytes = uploadTasks.value.reduce((sum, t) => {
    const tt = t.total > 0 ? t.total : 1
    if (t.status === 'success' || t.status === 'error') return sum + tt
    return sum + Math.min(t.loaded, tt)
  }, 0)
  return totalBytes > 0 ? Math.min(100, Math.round((loadedBytes / totalBytes) * 100)) : 0
})

const totalUploadCountProgress = computed(() => {
  const tot = uploadTasks.value.length
  const done = uploadTasks.value.filter(t => t.status === 'success' || t.status === 'error' || t.progress >= 100).length
  return `${done}/${tot}`
})

const updateUploadTask = (taskId: string, patch: Partial<UploadTaskItem>) => {
  uploadTasks.value = uploadTasks.value.map(t => t.id === taskId ? { ...t, ...patch } : t)
}

const clearUploadTaskPreviews = () => {
  uploadTasks.value.forEach(t => { if (t.previewUrl) URL.revokeObjectURL(t.previewUrl) })
}

const checkFileSize = (file: File): boolean => {
  if (!props.fileSize) return true
  const unitMap: Record<string, number> = { KB: 1024, MB: 1024 ** 2, GB: 1024 ** 3 }
  const limit = props.fileSize * (unitMap[props.sizeUnit] ?? unitMap.MB)
  if (file.size > limit) {
    ElMessage.warning(`文件"${file.name}"超过大小限制（${props.fileSize}${props.sizeUnit}）`)
    return false
  }
  return true
}

const uploadSingleFile = (file: File, taskId: string) => {
  const formData = new FormData()
  formData.append('file', file)
  const cat = getCategoryFilter()
  if (cat !== undefined) formData.append('category_id', cat === null ? 'null' : cat)
  return http.request({
    url: '/app/admin/system/systemFile/systemFile/upload',
    method: 'post',
    data: formData,
    openMessage: false,
    onUploadProgress: (e: any) => {
      const total = e.total || file.size || 0
      const loaded = e.loaded || 0
      const progress = total > 0 ? Math.min(100, Math.round((loaded / total) * 100)) : 0
      updateUploadTask(taskId, { total, loaded, progress, status: 'uploading', statusText: `${progress}%` })
    },
  })
}

const handleUpload = async (event: Event) => {
  const input = event.target as HTMLInputElement
  const allFiles = Array.from(input.files || [])
  if (!allFiles.length) return

  // 过滤超出大小限制的文件
  const files = allFiles.filter(checkFileSize)
  if (!files.length) {
    if (input) input.value = ''
    return
  }

  uploadLoading.value = true
  uploadProgressVisible.value = true
  clearUploadTaskPreviews()
  uploadTasks.value = files.map((file, index) => ({
    id: `${Date.now()}-${index}`,
    name: file.name,
    previewUrl: file.type.startsWith('image/') || file.type.startsWith('video/')
      ? URL.createObjectURL(file)
      : '',
    isImage: file.type.startsWith('image/'),
    isVideo: file.type.startsWith('video/'),
    progress: 0,
    loaded: 0,
    total: file.size || 0,
    status: 'uploading',
    statusText: '等待上传',
  }))

  try {
    const results = await Promise.allSettled(
      files.map((file, index) => uploadSingleFile(file, uploadTasks.value[index].id))
    )

    results.forEach((result, index) => {
      const taskId = uploadTasks.value[index]?.id
      if (!taskId) return
      if (result.status === 'fulfilled') {
        updateUploadTask(taskId, { progress: 100, loaded: uploadTasks.value[index].total, status: 'success', statusText: '上传成功' })
      } else {
        updateUploadTask(taskId, { progress: 100, loaded: uploadTasks.value[index].total || 1, status: 'error', statusText: '上传失败' })
      }
    })

    const successCount = results.filter(r => r.status === 'fulfilled').length
    const failCount = results.length - successCount
    if (successCount > 0) await loadFileList()

    if (failCount === 0) {
      ElMessage.success(`上传成功，共 ${successCount} 个文件`)
    } else if (successCount === 0) {
      ElMessage.error('上传失败')
    } else {
      ElMessage.warning(`上传完成，成功 ${successCount} 个，失败 ${failCount} 个`)
    }
  } finally {
    uploadLoading.value = false
    uploadProgressVisible.value = false
    clearUploadTaskPreviews()
    if (input) input.value = ''
  }
}

// ---- 选择 ----
const tempSelectedIds = ref<string[]>([])
const tempSelectedFiles = ref<FileItem[]>([])

const toggleSelect = (item: FileItem) => {
  const alreadySelected = tempSelectedIds.value.includes(item._id)

  if (!isMultiple.value) {
    tempSelectedIds.value = alreadySelected ? [] : [item._id]
    tempSelectedFiles.value = alreadySelected ? [] : [item]
    return
  }

  if (alreadySelected) {
    tempSelectedIds.value = tempSelectedIds.value.filter(i => i !== item._id)
    tempSelectedFiles.value = tempSelectedFiles.value.filter(f => f._id !== item._id)
  } else {
    if (props.multipleLimit > 0 && tempSelectedIds.value.length >= props.multipleLimit) {
      ElMessage.warning(`最多只能选择 ${props.multipleLimit} 个文件`)
      return
    }
    tempSelectedIds.value = [...tempSelectedIds.value, item._id]
    tempSelectedFiles.value = [...tempSelectedFiles.value, item]
  }
}

const handleConfirm = () => {
  const newItems: PreviewItem[] = tempSelectedFiles.value.map(f => ({
    id: f._id,
    url: f.url,
    name: f.original_name || f.display_name || '',
  }))

  // 合并已有预览（追加模式）
  const existingIds = previewFiles.value.map(f => f.id)
  const toAdd = newItems.filter(f => !existingIds.includes(f.id))
  previewFiles.value = [...previewFiles.value, ...toAdd]

  // 计算返回值
  const emitValue = (item: PreviewItem) => props.returnType === 'id' ? item.id : item.url
  const result = previewFiles.value.map(emitValue)
  emit('update:modelValue', isMultiple.value ? result : (result[0] ?? null))

  dialogVisible.value = false
}

// ---- 已选预览操作 ----
const handleRemove = (index: number) => {
  const newItems = previewFiles.value.filter((_, i) => i !== index)
  previewFiles.value = newItems
  const emitValue = (item: PreviewItem) => props.returnType === 'id' ? item.id : item.url
  const result = newItems.map(emitValue)
  emit('update:modelValue', isMultiple.value ? result : (result[0] ?? null))
}

// ---- 打开对话框 ----
const handleOpen = async () => {
  dialogVisible.value = true
  activeCategory.value = props.defaultCategory || CATEGORY_ALL
  query.pageIndex = 1
  searchName.value = ''
  tempSelectedIds.value = []
  tempSelectedFiles.value = []
  await Promise.all([loadCategories(), loadFileList()])
}
</script>

<style scoped lang="scss">
/* ---- 外部预览区 ---- */
.qa-fs-preview-wrap {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  align-items: flex-start;
}

.qa-fs-preview-item {
  position: relative;
  width: 80px;
  height: 80px;
  border-radius: 6px;
  overflow: hidden;
  border: 1px solid var(--el-border-color);
}

.qa-fs-preview-media {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.qa-fs-preview-other {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 4px;
  background: var(--el-fill-color-light);
  color: var(--el-text-color-secondary);
}

.qa-fs-preview-other-name {
  font-size: 10px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 72px;
  text-align: center;
}

.qa-fs-preview-remove {
  position: absolute;
  top: 2px;
  right: 2px;
  cursor: pointer;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 18px;
  height: 18px;
  color: #fff;
}

.qa-fs-add-btn {
  width: 80px;
  height: 80px;
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: var(--el-text-color-secondary);
  background: var(--el-fill-color-lighter);
  transition: all 0.2s;

  &:hover {
    border-color: var(--el-color-primary);
    color: var(--el-color-primary);
    background: var(--el-color-primary-light-9);
  }
}

/* ---- 对话框布局 ---- */
.qa-fs-layout {
  display: flex;
  height: 520px;
  min-height: 0;
}

/* ---- 分类侧栏 ---- */
.qa-fs-sidebar {
  width: 200px;
  min-width: 200px;
  border: 1px solid var(--el-border-color-light);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.qa-fs-add-category-btn {
  margin: 8px auto 12px;
  width: 60%;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border: 1px dashed var(--el-color-primary-light-5);
  color: var(--el-color-primary);
  font-size: 13px;
  font-weight: 500;
  flex-shrink: 0;
  transition: all 0.2s;

  &:hover {
    border-color: var(--el-color-primary);
    box-shadow: 0 0 12px rgba(64, 158, 255, 0.16);
  }
}

.qa-fs-add-category-form {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.qa-fs-add-category-footer {
  display: flex;
  justify-content: flex-end;
}

.qa-fs-category-list {
  flex: 1;
  overflow-y: auto;
}

.qa-fs-category-item {
  @apply flex cursor-pointer items-center justify-between gap-2 border-b px-3 py-2.5 text-sm transition-all duration-200 ease-in-out;
 

  &:hover {
    background-color: var(--el-fill-color-light);
  }

  &.is-active {
    color: var(--el-color-primary);
    background-color: var(--el-color-primary-light-9);
  }
}

/* ---- 右侧内容区 ---- */
.qa-fs-content {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 0 0 0 12px;
}

.qa-fs-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  flex-shrink: 0;
}

.qa-fs-search {
  width: 200px;
}

.qa-fs-hidden-input {
  display: none;
}

.qa-fs-grid-wrap {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
}

.qa-fs-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, 115px);
  gap: 12px;
  justify-content: space-between;
  padding: 2px;
}

/* 与 uploadManage.vue 的 .media-card 对齐 */
.qa-fs-card {
  width: 115px;
  cursor: pointer;
  border-radius: 8px;
  border: 1px solid var(--el-border-color-light);
  overflow: hidden;
  transition: all 0.2s ease-in-out;

  &:hover {
    border-color: var(--el-color-primary-light-5);
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
  }

  &.is-selected {
    border-color: var(--el-color-primary);
    box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.12);
  }

  &.is-disabled {
    opacity: 0.45;
    cursor: not-allowed;
    pointer-events: none;
  }
}

.qa-fs-card-preview {
  height: 120px;
  background: var(--el-fill-color-light);
  overflow: hidden;
}

.qa-fs-card-media {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.qa-fs-card-other {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--el-text-color-secondary);
}

.qa-fs-card-name {
  padding: 4px 6px;
  font-size: 11px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  color: var(--el-text-color-primary);
  line-height: 1.3;
}


/* ---- 对话框 footer ---- */
.qa-fs-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  gap: 12px;
}

/* ---- 上传进度弹窗 ---- */
.qa-fs-progress-dialog {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.qa-fs-progress-summary {
  padding: 12px 14px;
  border: 1px solid var(--el-border-color-light);
  border-radius: 8px;
  background-color: var(--el-fill-color-lighter);
}

.qa-fs-progress-summary-top {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 12px;
}

.qa-fs-progress-summary-title-wrap {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.qa-fs-progress-summary-title {
  font-size: 15px;
  font-weight: 600;
  color: var(--el-text-color-primary);
}

.qa-fs-progress-summary-desc {
  font-size: 12px;
  color: var(--el-text-color-secondary);
}

.qa-fs-progress-summary-value {
  flex-shrink: 0;
  font-size: 20px;
  line-height: 1;
  color: var(--el-color-primary);
}

.qa-fs-progress-list {
  max-height: 320px;
  overflow: auto;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.qa-fs-progress-item {
  padding: 10px 12px;
  border: 1px solid var(--el-border-color-lighter);
  border-radius: 8px;
}

.qa-fs-progress-item-inner {
  display: flex;
  align-items: center;
  gap: 12px;
}

.qa-fs-progress-item-preview {
  width: 56px;
  height: 56px;
  flex-shrink: 0;
  border-radius: 6px;
  overflow: hidden;
  background-color: var(--el-fill-color-light);
}

.qa-fs-progress-item-media {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.qa-fs-progress-item-empty {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--el-text-color-secondary);
}

.qa-fs-progress-item-main {
  flex: 1;
  min-width: 0;
}

.qa-fs-progress-item-top {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 8px;
}

.qa-fs-progress-item-name {
  flex: 1;
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 13px;
  color: var(--el-text-color-primary);
}
</style>
