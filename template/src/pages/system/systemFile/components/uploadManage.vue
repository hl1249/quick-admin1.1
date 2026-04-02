<template>
  <div class="upload-manage-wrap">
    <input
      ref="fileInputRef"
      type="file"
      class="hidden-file-input"
      :accept="activeUploadName === 'image' ? 'image/*' : 'video/*'"
      multiple
      @change="handleFileInputChange"
    />

    <el-tabs v-model="activeUploadName" class="upload-inner-tabs">
      <el-tab-pane v-for="tab in mediaTabs" :key="tab.value" :label="tab.label" :name="tab.value">
        <div class="image-manage-layout">
          <div v-loading="categoryLoading" class="image-category-panel">
            <div class="image-category-list">
              <div class="image-category-add-btn" @click="handleOpenAddCategory">添加分组</div>
              <div class="image-category-item" :class="{ 'is-active': activeImageCategory === CATEGORY_ALL }"
                @click="handleImageCategorySelect(CATEGORY_ALL)">
                全部
              </div>
              <div class="image-category-item" :class="{ 'is-active': activeImageCategory === CATEGORY_UNGROUPED }"
                @click="handleImageCategorySelect(CATEGORY_UNGROUPED)">
                未分组
              </div>
              <div v-for="item in imageCategories" :key="item.value" class="image-category-item"
                :class="{ 'is-active': activeImageCategory === item.value }"
                @click="handleImageCategorySelect(item.value)">
                <span class="image-category-item-label">{{ item.label }}</span>
                <div class="image-category-item-actions">
                  <span class="image-category-action-btn" @click.stop="handleEditCategory(item)">
                    <el-icon>
                      <Edit />
                    </el-icon>
                  </span>
                  <span class="image-category-action-btn is-danger" @click.stop="handleDeleteCategory(item)">
                    <el-icon>
                      <Delete />
                    </el-icon>
                  </span>
                </div>
              </div>
            </div>
          </div>

          <div class="image-content-panel">
            <div class="image-toolbar">
              <div class="image-toolbar-left">
              <el-dropdown split-button type="primary" @click="handleUploadImage">
                <span>{{ uploadLoading ? '上传中...' : '上传' }}</span>
                  <template #dropdown>
                    <el-dropdown-menu>
                      <el-dropdown-item @click="handleUploadImage">本地上传</el-dropdown-item>
                      <el-dropdown-item @click="handleOpenRemoteUpload">远程上传</el-dropdown-item>
                    </el-dropdown-menu>
                  </template>
                </el-dropdown>
                <el-button :disabled="!selectedImageIds.length" @click="handleDeleteImage">删除</el-button>
                <el-select
                  v-model="moveTargetCategoryId"
                  style="width: 200px"
                  placeholder="移动至分组"
                  clearable
                  :disabled="!selectedImageIds.length"
                  :loading="moveCategoryLoading"
                  @change="handleMoveToCategory"
                >
                  <el-option label="未分组" :value="CATEGORY_UNGROUPED" />
                  <el-option
                    v-for="item in imageCategories"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  />
                </el-select>
              </div>
              <div class="ml-auto flex items-cente gap-[12px]">
                <el-input v-model="queryForm.formData.original_name" class="!w-[220px] shrink-0" clearable placeholder="搜索名称" @clear="handleSearchImage"
                  @keyup.enter="handleSearchImage" :suffix-icon="Search" />
                <el-input v-model="queryForm.formData.url" class="!w-[220px] shrink-0" clearable placeholder="搜索URL" @clear="handleSearchImage"
                  @keyup.enter="handleSearchImage" :suffix-icon="Search" />
              </div>
            </div>

            <div v-loading="fileListLoading" class="image-content-body">
              <div class="media-grid">
                <div v-for="item in fileList" :key="item._id" class="media-card"
                  :class="{ 'is-selected': selectedImageIds.includes(item._id) }" @click="toggleSelectFile(item._id)">
                  <div class="media-preview">
                    <el-image v-if="activeUploadName === 'image'" :src="item.url" fit="cover"
                      lazy class="media-preview-image" />
                    <video v-else :src="item.url" class="media-preview-video" preload="metadata" muted playsinline />
                  </div>
                  <div class="media-card-info">
                    <div class="media-card-name" :title="item.display_name || item.original_name">
                      {{item.original_name || item.display_name ||  '未命名文件' }}
                    </div>
                    <!-- <div class="media-card-meta">
                    {{ formatFileMeta(item) }}
                  </div> -->
                  </div>
                  <div class="media-card-actions" @click.stop>
                    <el-button text size="small" @click="handleRenameFile(item)">改名</el-button>
                    <el-dropdown trigger="click">
    <span class="el-dropdown-link w-full">
                        <el-button text size="small">查看</el-button>
    </span>
                      <template #dropdown>
                        <el-dropdown-menu>
                          <el-dropdown-item @click.stop="handleCopyLink(item)">复制链接</el-dropdown-item>
                          <el-dropdown-item @click.stop="handleViewFile(item)">预览</el-dropdown-item>
                        </el-dropdown-menu>
                      </template>
                    </el-dropdown>
                    <el-button text size="small" type="danger" @click="handleDeleteSingleFile(item)">删除</el-button>


                  </div>
                </div>
                <div  class="image-upload-placeholder" @click="handleUploadImage">
                  <el-icon class="image-upload-placeholder-icon">
                    <Plus />
                  </el-icon>
                </div>
              </div>

             
            </div>

            <div class="media-pagination">
              <el-pagination :current-page="fileQuery.pageIndex" :page-size="fileQuery.pageSize"
                background
                layout="total, prev, pager, next" :total="fileTotal" @current-change="(page) => { fileQuery.pageIndex = page; loadFileList() }" />
            </div>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>

    <el-dialog v-model="categoryForm.props.show" :title="categoryForm.props.title" width="500"
      :close-on-click-modal="false">
      <qa-form v-model="categoryForm.data" ref="categoryFormRef" :rules="categoryForm.props.rules"
        :action="categoryForm.props.action" :form-type="categoryForm.props.formType"
        :columns="categoryForm.props.columns" :before-action="categoryForm.props.beforeAction" label-width="90px"
        @success="handleAddCategorySuccess" @closeForm="categoryForm.props.show = false" />
    </el-dialog>

    <el-dialog
      v-model="uploadProgressVisible"
      title="上传进度"
      width="560"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
      :show-close="!uploadLoading"
    >
      <div class="upload-progress-dialog">
        <div class="upload-progress-summary">
          <div class="upload-progress-summary-top">
            <div class="upload-progress-summary-title-wrap">
              <span class="upload-progress-summary-title">总进度</span>
              <span class="upload-progress-summary-desc">
                {{ uploadLoading ? '正在上传文件...' : '上传完成' }}
              </span>
            </div>
            <span class="upload-progress-summary-value">{{ totalUploadCountProgress }}</span>
          </div>
          <el-progress :percentage="totalUploadProgress" :stroke-width="12" />
        </div>

        <div class="upload-progress-list">
          <div
            v-for="task in uploadTasks"
            :key="task.id"
            class="upload-progress-item"
          >
            <div class="upload-progress-item-inner">
              <div class="upload-progress-item-preview">
                <el-image
                  v-if="task.previewUrl && task.isImage"
                  :src="task.previewUrl"
                  fit="cover"
                  class="upload-progress-item-preview-image"
                />
                <video
                  v-else-if="task.previewUrl"
                  :src="task.previewUrl"
                  class="upload-progress-item-preview-video"
                  muted
                  playsinline
                  preload="metadata"
                />
                <div v-else class="upload-progress-item-preview-empty">
                  <el-icon><Plus /></el-icon>
                </div>
              </div>

              <div class="upload-progress-item-main">
                <div class="upload-progress-item-top">
                  <span class="upload-progress-item-name" :title="task.name">{{ task.name }}</span>
                  <!-- <span class="upload-progress-item-status">{{ task.statusText }}</span> -->
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

    <el-dialog
      v-model="remoteUploadVisible"
      title="远程上传"
      width="480"
      :close-on-click-modal="false"
      @closed="handleRemoteUploadDialogClosed"
    >
      <div class="remote-upload-body">
        <div class="remote-upload-input-row">
          <el-input
            v-model="remoteUploadUrl"
            placeholder="请输入远程文件 URL"
            clearable
            :disabled="remoteUploadLoading"
            @keyup.enter="handleExtractRemote"
          />
          <el-button
            :loading="remoteExtractLoading"
            :disabled="!remoteUploadUrl.trim() || remoteUploadLoading"
            @click="handleExtractRemote"
          >提取图片</el-button>
        </div>

        <div v-if="remotePreviewUrl" class="remote-upload-preview">
          <div class="remote-upload-preview-inner">
            <el-image
              :src="remotePreviewUrl"
              fit="contain"
              class="remote-upload-preview-image"
            />
            <div v-if="remoteUploadLoading" class="remote-upload-progress-mask">
              <el-progress
                type="circle"
                :percentage="remoteUploadProgress"
                :width="64"
                :stroke-width="6"
              />
            </div>
          </div>
        </div>
      </div>

      <template #footer>
        <el-button :disabled="remoteUploadLoading" @click="remoteUploadVisible = false">取消</el-button>
        <el-button
          type="primary"
          :loading="remoteUploadLoading"
          :disabled="!remotePreviewUrl"
          @click="handleRemoteUpload"
        >确认上传</el-button>
      </template>
    </el-dialog>

    <el-image-viewer v-if="imagePreviewVisible" :url-list="imagePreviewUrls" :initial-index="imagePreviewIndex" close-on-press-escape hide-on-click-modal
      @close="imagePreviewVisible = false" />
  </div>
</template>

<script setup lang="ts">
import { Delete, Edit, Plus, Search } from '@element-plus/icons-vue'
import { ElImageViewer, ElMessage, ElMessageBox } from 'element-plus'
import { useClipboard } from '@vueuse/core'
import { getSystemCategories, updateSystemFileName, batchUpdateFilesCategory } from '@/api/file'
import http from '@/utils/axios'

interface CategoryItem {
  label: string
  value: string
  raw?: Record<string, any>
}

interface FileItem {
  _id: string
  url: string
  type?: string
  display_name?: string
  original_name?: string
  size?: number
  width?: number | null
  height?: number | null
  category_id?: string | null
  _add_time_str?: string
  [key: string]: any
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

type UploadType = 'image' | 'video'
const CATEGORY_ALL = 'all'
const CATEGORY_UNGROUPED = 'null'

const mediaTabs: Array<{ label: string; value: UploadType }> = [
  { label: '图片管理', value: 'image' },
  { label: '视频管理', value: 'video' },
]

const activeUploadName = ref<UploadType>('image')
const activeImageCategory = ref(CATEGORY_ALL)
const { copy } = useClipboard()
const selectedImageIds = ref<string[]>([])
const moveTargetCategoryId = ref<string | null>(null)
const moveCategoryLoading = ref(false)
const remoteUploadVisible = ref(false)
const remoteUploadUrl = ref('')
const remoteExtractLoading = ref(false)
const remotePreviewUrl = ref('')
const remoteUploadLoading = ref(false)
const remoteUploadProgress = ref(0)
const imageCategories = ref<CategoryItem[]>([])
const categoryLoading = ref(false)
const fileListLoading = ref(false)
const uploadLoading = ref(false)
const uploadProgressVisible = ref(false)
const fileListLoaded = ref(false)
const fileList = ref<FileItem[]>([])
const fileTotal = ref(0)
const uploadTasks = ref<UploadTaskItem[]>([])
const imagePreviewVisible = ref(false)
const imagePreviewUrls = ref<string[]>([])
const imagePreviewIndex = ref(0)
const categoryFormRef = ref()
const fileInputRef = ref<HTMLInputElement | null>(null)
const fileQuery = reactive({
  pageIndex: 1,
  pageSize: 50
})

const totalUploadProgress = computed(() => {
  if (!uploadTasks.value.length) {
    return 0
  }

  const total = uploadTasks.value.reduce((sum, task) => {
    return sum + (task.total > 0 ? task.total : 1)
  }, 0)

  const loaded = uploadTasks.value.reduce((sum, task) => {
    const taskTotal = task.total > 0 ? task.total : 1

    if (task.status === 'success' || task.status === 'error') {
      return sum + taskTotal
    }

    return sum + Math.min(task.loaded, taskTotal)
  }, 0)

  if (total > 0) {
    return Math.min(100, Math.round((loaded / total) * 100))
  }

  return Math.round(
    uploadTasks.value.reduce((sum, task) => sum + task.progress, 0) / uploadTasks.value.length
  )
})

const totalUploadCountProgress = computed(() => {
  const totalCount = uploadTasks.value.length
  const finishedCount = uploadTasks.value.filter(task =>
    task.status === 'success' || task.status === 'error' || task.progress >= 100
  ).length

  return `${finishedCount}/${totalCount}`
})

const getTaskCountProgress = (task: UploadTaskItem) => {
  const finishedCount = task.status === 'success' || task.status === 'error' || task.progress >= 100 ? 1 : 0
  return `${finishedCount}/1`
}

const createCategoryFormData = () => ({
  _id: '',
  name: ''
})

const categoryForm = ref({
  data: createCategoryFormData(),
  props: {
    action: '/app/admin/system/systemFile/systemCategories/add',
    columns: [
      {
        key: 'name',
        title: '分类名称',
        type: 'text',
        showLabel: true,
      }
    ],
    rules: {
      name: [
        { required: true, message: '请输入分类名称', trigger: 'blur' },
      ]
    },
    beforeAction: ((formData: Record<string, any>) => ({
      ...formData,
      type: activeUploadName.value
    })) as any,
    formType: 'add',
    title: '添加分类',
    show: false
  }
})

const loadSystemCategories = async () => {
  categoryLoading.value = true
  try {
    const res = await getSystemCategories({
      type: activeUploadName.value
    })
    const rows = res?.data?.data?.rows || []
    imageCategories.value = rows.map((item: Record<string, any>, index: number) => ({
      label: item.name || item.title || item.label || `未命名分类${index + 1}`,
      value: String(item._id || item.id || item.value || item.name || index),
      raw: item
    }))
    // activeImageCategory.value = CATEGORY_ALL
  } finally {
    categoryLoading.value = false
  }
}

const getCategoryFilterValue = () => {
  if (activeImageCategory.value === CATEGORY_ALL) {
    return undefined
  }

  if (activeImageCategory.value === CATEGORY_UNGROUPED) {
    return null
  }

  return activeImageCategory.value
}

const queryForm = ref({
  formData: {
    type: activeUploadName.value,
    category_id: getCategoryFilterValue(),
    original_name: "",
    url: ""
  },
  columns: [
    {
      key: 'type',
      mode: '=',
    },
    {
      key: 'category_id',
      mode: '=',
    },
    {
      key: 'original_name',
      mode: '%%',
    },
    {
      key: 'url',
      mode: '=',
    }
  ]
})

const loadFileList = async () => {
  fileListLoading.value = true
  fileListLoaded.value = false
  try {
    const res = await http.request({
      url: '/app/admin/system/systemFile/systemFile/files/getList',
      method: 'post',
      data: {
        ...queryForm.value,
        pageIndex: fileQuery.pageIndex,
        pageSize: fileQuery.pageSize,
      }
    })

    const responseData = res?.data?.data?.rows !== undefined || res?.data?.data?.total !== undefined
      ? res.data.data
      : (res?.data || {})

    fileList.value = responseData.rows || []
    fileTotal.value = responseData.total || 0
  } finally {
    fileListLoading.value = false
    fileListLoaded.value = true
  }
}

const clearFileList = () => {
  fileList.value = []
  fileTotal.value = 0
  fileListLoaded.value = false
}

const handleImageCategorySelect = (value: string) => {
  activeImageCategory.value = value
}

const handleOpenRemoteUpload = () => {
  remoteUploadVisible.value = true
}

const handleRemoteUploadDialogClosed = () => {
  remoteUploadUrl.value = ''
  remotePreviewUrl.value = ''
  remoteUploadProgress.value = 0
}

const handleExtractRemote = () => {
  const url = remoteUploadUrl.value.trim()
  if (!url) return

  // URL 格式校验
  try {
    new URL(url)
  } catch {
    ElMessage.error('请输入有效的 URL 地址')
    return
  }

  // 图片后缀白名单（宽松判断，路径或参数中含即可）
  const imageExts = /\.(jpe?g|png|gif|webp|bmp|svg|ico|avif|tiff?)(\?|#|$)/i
  const looksLikeImage = imageExts.test(url)

  remoteExtractLoading.value = true
  remotePreviewUrl.value = ''

  const img = new Image()
  img.onload = () => {
    remotePreviewUrl.value = url
    remoteExtractLoading.value = false
  }
  img.onerror = () => {
    remoteExtractLoading.value = false
    if (looksLikeImage) {
      ElMessage.error('图片加载失败，请确认链接可访问且支持跨域')
    } else {
      ElMessage.error('该链接无法识别为图片，请检查 URL 是否正确')
    }
  }
  img.src = url
}

const handleRemoteUpload = async () => {
  const url = remoteUploadUrl.value.trim()
  if (!url) return

  remoteUploadLoading.value = true
  remoteUploadProgress.value = 0

  // 模拟进度（接口无实时进度，用定时器给用户反馈）
  const progressTimer = setInterval(() => {
    if (remoteUploadProgress.value < 85) {
      remoteUploadProgress.value += Math.floor(Math.random() * 12) + 5
    }
  }, 300)

  try {
    await http.request({
      url: '/app/admin/system/systemFile/systemfile/remote/upload',
      method: 'post',
      data: {
        url,
        category_id: getUploadCategoryValue() ?? null,
      },
    })
    remoteUploadProgress.value = 100
    ElMessage.success('远程上传成功')
    await new Promise(r => setTimeout(r, 400))
    remoteUploadVisible.value = false
    clearFileList()
    await loadFileList()
  } finally {
    clearInterval(progressTimer)
    remoteUploadLoading.value = false
  }
}

const handleUploadImage = () => {
  if (uploadLoading.value) {
    return
  }
  fileInputRef.value?.click()
}

const getUploadCategoryValue = () => {
  if (activeImageCategory.value === CATEGORY_ALL) {
    return undefined
  }

  if (activeImageCategory.value === CATEGORY_UNGROUPED) {
    return 'null'
  }

  return activeImageCategory.value
}

const updateUploadTask = (taskId: string, patch: Partial<UploadTaskItem>) => {
  uploadTasks.value = uploadTasks.value.map(task =>
    task.id === taskId ? { ...task, ...patch } : task
  )
}

const clearUploadTaskPreviews = () => {
  uploadTasks.value.forEach(task => {
    if (task.previewUrl) {
      URL.revokeObjectURL(task.previewUrl)
    }
  })
}

const uploadSingleFile = async (file: File, taskId: string) => {
  const formData = new FormData()
  formData.append('file', file)

  const categoryId = getUploadCategoryValue()
  if (categoryId !== undefined) {
    formData.append('category_id', categoryId)
  }
  console.log('categoryId',categoryId)
  return http.request({
    url: '/app/admin/system/systemFile/systemFile/upload',
    method: 'post',
    data: formData,
    openMessage: false,
    onUploadProgress: progressEvent => {
      const total = progressEvent.total || file.size || 0
      const loaded = progressEvent.loaded || 0
      const progress = total > 0 ? Math.min(100, Math.round((loaded / total) * 100)) : 0

      updateUploadTask(taskId, {
        total,
        loaded,
        progress,
        status: 'uploading',
        statusText: `${progress}%`
      })
    }
  })
}

const handleFileInputChange = async (event: Event) => {
  const input = event.target as HTMLInputElement
  const files = Array.from(input.files || [])

  if (!files.length) {
    return
  }

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
    statusText: '等待上传'
  }))

  try {
    const results = await Promise.allSettled(
      files.map((file, index) => uploadSingleFile(file, uploadTasks.value[index].id))
    )

    results.forEach((result, index) => {
      const taskId = uploadTasks.value[index]?.id
      if (!taskId) {
        return
      }

      if (result.status === 'fulfilled') {
        updateUploadTask(taskId, {
          progress: 100,
          loaded: uploadTasks.value[index].total,
          status: 'success',
          statusText: '上传成功'
        })
        return
      }

      updateUploadTask(taskId, {
        progress: 100,
        loaded: uploadTasks.value[index].total || 1,
        status: 'error',
        statusText: '上传失败'
      })
    })

    const successCount = results.filter(result => result.status === 'fulfilled').length
    const failCount = results.length - successCount

    if (successCount > 0) {
      clearFileList()
      await loadFileList()
    }

    if (failCount === 0) {
      ElMessage.success(`上传成功，共 ${successCount} 个文件`)
      return
    }

    if (successCount === 0) {
      ElMessage.error('上传失败')
      return
    }

    ElMessage.warning(`上传完成，成功 ${successCount} 个，失败 ${failCount} 个`)
  } finally {
    uploadLoading.value = false
    uploadProgressVisible.value = false
    clearUploadTaskPreviews()
    if (input) {
      input.value = ''
    }
  }
}

const deleteFiles = async (ids: string[]) => {
  await http.request({
    url: '/app/admin/system/systemFile/systemFile/files/delete',
    method: 'post',
    data: {
      ids
    }
  })
}

const handleDeleteImage = async () => {
  if (!selectedImageIds.value.length) {
    ElMessage.warning('请先选择文件')
    return
  }

  await ElMessageBox.confirm(`确认删除选中的 ${selectedImageIds.value.length} 个文件吗？`, '提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })

  await deleteFiles(selectedImageIds.value)
  selectedImageIds.value = []
  ElMessage.success('删除成功')
  clearFileList()
  await loadFileList()
}

const handleSearchImage = () => {
  fileQuery.pageIndex = 1
  clearFileList()
  loadFileList()
}

const handleOpenAddCategory = async () => {
  categoryForm.value.data = createCategoryFormData()
  categoryForm.value.props.action = '/app/admin/system/systemFile/systemCategories/add'
  categoryForm.value.props.formType = 'add'
  categoryForm.value.props.title = '添加分类'
  categoryForm.value.props.show = true
  await nextTick()
  categoryFormRef.value?.resetForm?.()
}

const handleEditCategory = async (item: CategoryItem) => {
  categoryForm.value.data = {
    _id: item.raw?._id || item.value,
    name: item.raw?.name || item.label
  }
  categoryForm.value.props.action = '/app/admin/system/systemFile/systemCategories/update'
  categoryForm.value.props.formType = 'edit'
  categoryForm.value.props.title = '编辑分类'
  categoryForm.value.props.show = true
  await nextTick()
  categoryFormRef.value?.clearValidate?.()
}

const handleDeleteCategory = async (item: CategoryItem) => {
  await ElMessageBox.confirm(`确认删除分类“${item.label}”吗？`, '提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })

  await http.request({
    url: '/app/admin/system/systemFile/systemCategories/delete',
    method: 'post',
    data: {
      _id: item.raw?._id || item.value
    }
  })

  ElMessage.success('删除成功')

  if (activeImageCategory.value === item.value) {
    // activeImageCategory.value = CATEGORY_ALL
  }

  await loadSystemCategories()
}

const handleAddCategorySuccess = async () => {
  categoryForm.value.props.show = false
  await loadSystemCategories()
}

const toggleSelectFile = (id: string) => {
  if (selectedImageIds.value.includes(id)) {
    selectedImageIds.value = selectedImageIds.value.filter(item => item !== id)
    return
  }
  selectedImageIds.value = [...selectedImageIds.value, id]
}

const handleRenameFile = async (item: FileItem) => {
  const currentName = item.original_name || item.display_name || ''

  try {
    const { value } = await ElMessageBox.prompt('请输入新的文件名称', '文件改名', {
      confirmButtonText: '确认',
      cancelButtonText: '取消',
      inputValue: currentName,
      inputPlaceholder: '请输入文件名称',
      inputValidator: (inputValue: string) => {
        if (!inputValue?.trim()) {
          return '文件名称不能为空'
        }

        return true
      }
    })

    const original_name = value.trim()
    if (original_name === currentName) {
      return
    }

    await updateSystemFileName({
      _id: item._id,
      original_name
    })

    fileList.value = fileList.value.map(file =>
      file._id === item._id
        ? {
          ...file,
          original_name
        }
        : file
    )

    ElMessage.success('改名成功')
    clearFileList()
    await loadFileList()
  } catch (error) {
    if (error === 'cancel' || error === 'close') {
      return
    }
    throw error
  }
}


const handleMoveToCategory = async (val: string) => {
  moveCategoryLoading.value = true
  try {
    await batchUpdateFilesCategory({
      ids: selectedImageIds.value,
      category_id: val === CATEGORY_UNGROUPED ? null : val,
    })
    ElMessage.success(`已将 ${selectedImageIds.value.length} 个文件移动至目标分组`)
    selectedImageIds.value = []
    moveTargetCategoryId.value = null
    clearFileList()
    await loadFileList()
  } finally {
    moveCategoryLoading.value = false
  }
}

const handleCopyLink = async (item: FileItem) => {
  await copy(item.url)
  ElMessage.success('链接已复制')
}

const handleViewFile = (item: FileItem) => {
  if (activeUploadName.value === 'image') {
    imagePreviewUrls.value = [item.url]
    imagePreviewIndex.value = 0
    imagePreviewVisible.value = true
    return
  }

  window.open(item.url, '_blank')
}

const handleDeleteSingleFile = async (item: FileItem) => {
  const fileName = item.original_name || item.display_name ||  '未命名文件'

  await ElMessageBox.confirm(`确认删除文件“${fileName}”吗？`, '提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })

  await deleteFiles([item._id])
  selectedImageIds.value = selectedImageIds.value.filter(id => id !== item._id)
  ElMessage.success('删除成功')
  clearFileList()
  await loadFileList()
}

const formatFileSize = (size?: number) => {
  if (!size) {
    return '-'
  }

  if (size < 1024) {
    return `${size}B`
  }

  if (size < 1024 * 1024) {
    return `${(size / 1024).toFixed(1)}KB`
  }

  return `${(size / 1024 / 1024).toFixed(1)}MB`
}

const formatFileMeta = (item: FileItem) => {
  const meta: string[] = [formatFileSize(item.size)]

  if (activeUploadName.value === 'image' && item.width && item.height) {
    meta.push(`${item.width} x ${item.height}`)
  }

  if (item._add_time_str) {
    meta.push(item._add_time_str)
  }

  return meta.join(' / ')
}

onMounted(() => {
  loadSystemCategories()
  loadFileList()
})

watch(activeUploadName, () => {
  activeImageCategory.value = CATEGORY_ALL
  selectedImageIds.value = []
  fileQuery.pageIndex = 1
  queryForm.value.formData.type = activeUploadName.value
  queryForm.value.formData.category_id = getCategoryFilterValue()
  clearFileList()
  loadSystemCategories()
  loadFileList()
})

watch(activeImageCategory, () => {
  selectedImageIds.value = []
  fileQuery.pageIndex = 1
  queryForm.value.formData.type = activeUploadName.value
  queryForm.value.formData.category_id = getCategoryFilterValue()
  clearFileList()
  loadFileList()
})
</script>

<style lang="scss" scoped>
.upload-manage-wrap {
  @apply flex h-full min-h-0 flex-col overflow-hidden;
}

.upload-inner-tabs {
  @apply flex h-full min-h-0 flex-1 flex-col overflow-hidden;
}

.upload-inner-tabs :deep(.el-tabs__header) {
  @apply shrink-0;
}

.upload-inner-tabs :deep(.el-tabs__content) {
  @apply flex min-h-0 flex-1 flex-col overflow-hidden;
}

.upload-inner-tabs :deep(.el-tab-pane) {
  @apply min-h-0 flex-1 overflow-hidden;
}

.image-manage-layout {
  @apply flex h-full min-h-0 gap-4;
}

.image-category-panel {
  @apply flex w-[220px] min-w-[220px] flex-col overflow-hidden border;
  border-color: var(--el-border-color-light);
}

.image-category-list {
  @apply flex-1;
}

.image-category-add-btn {
  @apply mx-auto my-2 mb-3 flex h-9 w-[60%] cursor-pointer items-center justify-center border border-dashed text-sm font-medium transition-all duration-200 ease-in-out;
  border-color: var(--el-color-primary-light-5);
  color: var(--el-color-primary);
}

.image-category-add-btn:hover {
  border-color: var(--el-color-primary);
  box-shadow: 0 0 12px rgba(64, 158, 255, 0.16);
}

.image-category-item {
  @apply flex cursor-pointer items-center justify-between gap-2 border-b px-3 py-2.5 text-sm transition-all duration-200 ease-in-out;
  color: var(--el-text-color-regular);
  border-bottom-color: var(--el-border-color);
  background-color: var(--el-scrollbar-bg-color);
}

.image-category-item-label {
  @apply min-w-0 flex-1 truncate;
}

.image-category-item-actions {
  @apply flex items-center gap-1 transition-opacity duration-200 ease-in-out;
  opacity: 0;
}

.image-category-item:hover .image-category-item-actions,
.image-category-item.is-active .image-category-item-actions {
  opacity: 1;
}

.image-category-action-btn {
  @apply inline-flex h-[22px] w-[22px] items-center justify-center rounded text-sm transition-all duration-200 ease-in-out;
  color: var(--el-text-color-secondary);
}

.image-category-action-btn:hover {
  color: var(--el-color-primary);
  background-color: rgba(64, 158, 255, 0.12);
}

.image-category-action-btn.is-danger:hover {
  color: var(--el-color-danger);
  background-color: rgba(245, 108, 108, 0.12);
}


.image-category-item:hover {
  background-color: var(--el-fill-color-light);
}

.image-category-item.is-active {
  color: var(--el-color-primary);
  background-color: var(--el-color-primary-light-9);
}

.image-content-panel {
  @apply flex min-h-0 min-w-0 flex-1 flex-col gap-4 rounded border p-4;
  border-color: var(--el-border-color-light);
}

.image-content-body {
  @apply min-h-0 flex-1 overflow-auto ;
}

.media-grid {
  @apply grid gap-4 justify-between;
  grid-template-columns: repeat(auto-fill, 135px);
}

.media-card {
  @apply flex w-[135px] cursor-pointer flex-col overflow-hidden rounded-lg border transition-all duration-200 ease-in-out;
  border-color: var(--el-border-color-light);
}

.media-card:hover {
  border-color: var(--el-color-primary-light-5);
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
}

.media-card.is-selected {
  border-color: var(--el-color-primary);
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.12);
}

.media-preview {
  @apply h-[150px] shrink-0 overflow-hidden;
  background-color: var(--el-fill-color-light);
}

.media-preview-image,
.media-preview-video {
  @apply block h-full w-full object-cover;
}

.media-card-info {
  @apply flex flex-col justify-center;
}

.media-card-name {
  @apply truncate text-xs p-[4px];
  color: var(--el-text-color-primary);
  line-height: 1.3;
}

.media-card-meta {
  @apply mt-0.5 truncate text-[10px];
  color: var(--el-text-color-secondary);
  line-height: 1.2;
}

.media-card-actions {
  @apply grid shrink-0;
  border-top: 1px solid var(--el-border-color-lighter);
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.media-card-actions > * {
  min-width: 0;
}

.media-card-actions :deep(.el-button) {
  @apply m-0 min-h-0 w-full rounded-none px-1 py-1.5 text-[11px];
}

:deep(.media-view-popover-popper) {
  padding: 6px 0 !important;
}

:deep(.media-view-popover-menu) {
  @apply min-w-[88px];
}

:deep(.media-view-popover-item) {
  @apply cursor-pointer whitespace-nowrap px-3 py-1.5;
  line-height: 1.2;
}

:deep(.media-view-popover-item:hover) {
  background-color: var(--el-fill-color-light);
}

.media-pagination {
  @apply flex justify-end pt-1;
}

.image-toolbar {
  @apply flex items-center justify-between gap-4;
}

.image-toolbar-left {
  @apply flex items-center gap-3;
}

.hidden-file-input {
  @apply hidden;
}

.image-search-input {
  @apply ml-auto w-[260px];
}

.image-upload-placeholder {
  @apply flex h-[200px] w-[135px] cursor-pointer flex-col items-center justify-center gap-2.5 rounded-lg border border-dashed text-center transition-all duration-200 ease-in-out;
  border-color: var(--el-border-color);
  color: var(--el-text-color-secondary);
  background-color: var(--el-fill-color-lighter);
}

.image-upload-placeholder:hover {
  border-color: var(--el-color-primary);
  color: var(--el-color-primary);
  background-color: var(--el-color-primary-light-9);
}

.image-upload-placeholder-icon {
  @apply text-[34px];
}

.image-upload-placeholder-title {
  @apply text-base font-medium;
  color: var(--el-text-color-primary);
  line-height: 1.3;
}

.image-upload-placeholder-desc {
  @apply px-3 text-[13px];
  color: inherit;
  line-height: 1.4;
}

.upload-progress-dialog {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.upload-progress-summary {
  padding: 12px 14px;
  border: 1px solid var(--el-border-color-light);
  border-radius: 8px;
  background-color: var(--el-fill-color-lighter);
}

.upload-progress-summary-top {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 12px;
}

.upload-progress-summary-title-wrap {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.upload-progress-summary-title {
  font-size: 15px;
  font-weight: 600;
  color: var(--el-text-color-primary);
}

.upload-progress-summary-desc {
  font-size: 12px;
  color: var(--el-text-color-secondary);
}

.upload-progress-summary-value {
  flex-shrink: 0;
  font-size: 20px;
  line-height: 1;
  color: var(--el-color-primary);
}

.upload-progress-list {
  max-height: 320px;
  overflow: auto;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.upload-progress-item {
  padding: 10px 12px;
  border: 1px solid var(--el-border-color-lighter);
  border-radius: 8px;
}

.upload-progress-item-inner {
  display: flex;
  align-items: center;
  gap: 12px;
}

.upload-progress-item-preview {
  width: 56px;
  height: 56px;
  flex-shrink: 0;
  border-radius: 6px;
  overflow: hidden;
  background-color: var(--el-fill-color-light);
}

.upload-progress-item-preview-image,
.upload-progress-item-preview-video {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.upload-progress-item-preview-empty {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--el-text-color-secondary);
}

.upload-progress-item-main {
  flex: 1;
  min-width: 0;
}

.upload-progress-item-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 8px;
}

.upload-progress-item-name {
  flex: 1;
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 13px;
  color: var(--el-text-color-primary);
}

.upload-progress-item-status {
  flex-shrink: 0;
  font-size: 12px;
  color: var(--el-text-color-secondary);
}

.remote-upload-body {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.remote-upload-input-row {
  display: flex;
  gap: 8px;
  align-items: center;
}

.remote-upload-input-row .el-input {
  flex: 1;
}

.remote-upload-preview {
  display: flex;
  justify-content: center;
}

.remote-upload-preview-inner {
  position: relative;
  width: 200px;
  height: 200px;
  border-radius: 6px;
  overflow: hidden;
  border: 1px solid var(--el-border-color);
  background: var(--el-fill-color-lighter);
}

.remote-upload-preview-image {
  width: 100%;
  height: 100%;
}

.remote-upload-progress-mask {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.45);
}

.remote-upload-progress-mask :deep(.el-progress__text) {
  color: #fff;
  font-size: 13px !important;
}
</style>
