<template>
  <div>
    <!-- 已选预览 + 添加按钮 -->
    <div class="qa-fs-preview-wrap">
      <div
        v-for="(url, index) in currentUrls"
        :key="index"
        class="qa-fs-preview-item"
      >
        <el-image v-if="fileType === 'image'" :src="url" fit="cover" class="qa-fs-preview-media" />
        <video v-else :src="url" class="qa-fs-preview-media" muted preload="metadata" />
        <div class="qa-fs-preview-remove" @click="handleRemove(index)">
          <el-icon :size="12"><CircleClose /></el-icon>
        </div>
      </div>
      <div
        v-if="multiple || currentUrls.length === 0"
        class="qa-fs-add-btn"
        @click="handleOpen"
      >
        <el-icon :size="22"><Plus /></el-icon>
      </div>
    </div>

    <!-- 选择对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="`选择${fileType === 'image' ? '图片' : '视频'}`"
      width="920px"
    >
      <div class="qa-fs-layout">
        <!-- 分类侧栏 -->
        <div v-loading="categoryLoading" class="qa-fs-sidebar">
          <!-- 添加分组 -->
          <el-popover
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
                :accept="fileType === 'image' ? 'image/*' : 'video/*'"
                multiple
                class="qa-fs-hidden-input"
                @change="handleUpload"
              />
              <el-button type="primary" :loading="uploadLoading" @click="uploadInputRef?.click()" :icon="Plus">
                上传到此分组
              </el-button>
            </div>
            <div class="flex items-center gap-[12px]"> 
              <el-input
              v-model="searchName"
              placeholder="搜索名称"
              clearable
              class="qa-fs-search"
              @keyup.enter="handleSearch"
              @clear="handleSearch"
            >
            <template #append>
              <el-button type="primary" plain :icon="Search" @click="handleSearch" />
            </template>
          </el-input>
            </div>
          </div>

          <!-- 文件网格 -->
          <div v-loading="fileLoading" class="qa-fs-grid-wrap">
            <el-empty v-if="!fileLoading && fileList.length === 0" description="此分组为空" :image-size="80" />
            <div v-else class="qa-fs-grid">
              <div
                v-for="item in fileList"
                :key="item._id"
                class="qa-fs-card"
                :class="{ 'is-selected': tempSelectedIds.includes(item._id) }"
                @click="toggleSelect(item)"
              >
                <div class="qa-fs-card-preview">
                  <el-image v-if="fileType === 'image'" :src="item.url" fit="cover" class="qa-fs-card-media" />
                  <video v-else :src="item.url" class="qa-fs-card-media" muted preload="metadata" />
                </div>
                <div class="qa-fs-card-name" :title="item.original_name || item.display_name || '未命名'">
                  {{ item.original_name || item.display_name || '未命名' }}
                </div>
              </div>
            </div>
          </div>

          <!-- 分页 -->
          <div class="qa-fs-pagination">
            <el-pagination
              :current-page="query.pageIndex"
              :page-size="query.pageSize"
              :total="total"
              background
              layout="total, prev, pager, next"
              @current-change="(page) => { query.pageIndex = page; loadFileList() }"
            />
          </div>
        </div>
      </div>

      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleConfirm">
          确认{{ tempSelectedIds.length > 0 ? `（已选 ${tempSelectedIds.length} 个）` : '' }}
        </el-button>
      </template>
    </el-dialog>

    <!-- 上传进度弹窗 -->
    <el-dialog
      v-model="uploadProgressVisible"
      title="上传进度"
      width="560"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
      :show-close="!uploadLoading"
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
          <div
            v-for="task in uploadTasks"
            :key="task.id"
            class="qa-fs-progress-item"
          >
            <div class="qa-fs-progress-item-inner">
              <div class="qa-fs-progress-item-preview">
                <el-image
                  v-if="task.previewUrl && task.isImage"
                  :src="task.previewUrl"
                  fit="cover"
                  class="qa-fs-progress-item-media"
                />
                <video
                  v-else-if="task.previewUrl"
                  :src="task.previewUrl"
                  class="qa-fs-progress-item-media"
                  muted
                  playsinline
                  preload="metadata"
                />
                <div v-else class="qa-fs-progress-item-empty">
                  <el-icon><Plus /></el-icon>
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
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { CircleClose, Plus, Search } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import http from '@/utils/axios'

interface FileItem {
  _id: string
  url: string
  original_name?: string
  display_name?: string
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
  progress: number
  loaded: number
  total: number
  status: 'uploading' | 'success' | 'error'
  statusText: string
}

const props = withDefaults(defineProps<{
  modelValue?: string | string[] | null
  fileType?: 'image' | 'video'
  multiple?: boolean
}>(), {
  modelValue: null,
  fileType: 'image',
  multiple: false,
})

const emit = defineEmits<{
  'update:modelValue': [val: string | string[] | null]
}>()

const CATEGORY_ALL = 'all'
const CATEGORY_UNGROUPED = 'null'

const currentUrls = computed<string[]>(() => {
  const v = props.modelValue
  if (Array.isArray(v)) return v
  return v ? [v] : []
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
    const res = await http.request({
      url: '/app/admin/system/systemFile/systemFile/files/getList',
      method: 'post',
      data: {
        formData: {
          type: props.fileType,
          category_id: getCategoryFilter(),
          original_name: searchName.value,
        },
        columns: [
          { key: 'type', mode: '=' },
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
    const taskTotal = t.total > 0 ? t.total : 1
    if (t.status === 'success' || t.status === 'error') return sum + taskTotal
    return sum + Math.min(t.loaded, taskTotal)
  }, 0)
  return totalBytes > 0 ? Math.min(100, Math.round((loadedBytes / totalBytes) * 100)) : 0
})

const totalUploadCountProgress = computed(() => {
  const total = uploadTasks.value.length
  const done = uploadTasks.value.filter(t => t.status === 'success' || t.status === 'error' || t.progress >= 100).length
  return `${done}/${total}`
})

const updateUploadTask = (taskId: string, patch: Partial<UploadTaskItem>) => {
  uploadTasks.value = uploadTasks.value.map(t => t.id === taskId ? { ...t, ...patch } : t)
}

const clearUploadTaskPreviews = () => {
  uploadTasks.value.forEach(t => { if (t.previewUrl) URL.revokeObjectURL(t.previewUrl) })
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
    onUploadProgress: (progressEvent: any) => {
      const total = progressEvent.total || file.size || 0
      const loaded = progressEvent.loaded || 0
      const progress = total > 0 ? Math.min(100, Math.round((loaded / total) * 100)) : 0
      updateUploadTask(taskId, { total, loaded, progress, status: 'uploading', statusText: `${progress}%` })
    },
  })
}

const handleUpload = async (event: Event) => {
  const input = event.target as HTMLInputElement
  const files = Array.from(input.files || [])
  if (!files.length) return

  uploadLoading.value = true
  uploadProgressVisible.value = true
  clearUploadTaskPreviews()
  uploadTasks.value = files.map((file, index) => ({
    id: `${Date.now()}-${index}`,
    name: file.name,
    previewUrl: URL.createObjectURL(file),
    isImage: file.type.startsWith('image/'),
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
  if (props.multiple) {
    if (tempSelectedIds.value.includes(item._id)) {
      tempSelectedIds.value = tempSelectedIds.value.filter(i => i !== item._id)
      tempSelectedFiles.value = tempSelectedFiles.value.filter(f => f._id !== item._id)
    } else {
      tempSelectedIds.value = [...tempSelectedIds.value, item._id]
      tempSelectedFiles.value = [...tempSelectedFiles.value, item]
    }
  } else {
    const already = tempSelectedIds.value.includes(item._id)
    tempSelectedIds.value = already ? [] : [item._id]
    tempSelectedFiles.value = already ? [] : [item]
  }
}

const handleConfirm = () => {
  const urls = tempSelectedFiles.value.map(f => f.url)
  emit('update:modelValue', props.multiple ? urls : (urls[0] ?? null))
  dialogVisible.value = false
}

// ---- 已选预览操作 ----
const handleRemove = (index: number) => {
  const newUrls = currentUrls.value.filter((_, i) => i !== index)
  emit('update:modelValue', props.multiple ? newUrls : (newUrls[0] ?? null))
}

// ---- 打开对话框 ----
const handleOpen = async () => {
  dialogVisible.value = true
  activeCategory.value = CATEGORY_ALL
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

/* ---- 选择对话框布局 ---- */
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
  justify-content: space-between;
  gap: 12px;
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

.qa-fs-card-name {
  padding: 4px 6px;
  font-size: 11px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  color: var(--el-text-color-primary);
  line-height: 1.3;
}

.qa-fs-pagination {
  display: flex;
  justify-content: flex-end;
  flex-shrink: 0;
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
  justify-content: space-between;
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
