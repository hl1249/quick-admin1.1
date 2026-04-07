<script setup lang="ts">
import { ref, computed, nextTick } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import http from '@/utils/axios'
import {
  buildFieldSpec,
  coerceSwitchValues,
  coerceOptionDataValues,
  isSwitchCustomValueEnabled,
  getOptionDataValueType,
  type BsonType,
  type FieldDef,
} from './types'
import FieldTypePanel from './components/FieldTypePanel.vue'
import FieldCanvas from './components/FieldCanvas.vue'
import FieldPropertyPanel from './components/FieldPropertyPanel.vue'
import FormConfigDialog from './components/FormConfigDialog.vue'

// ──────────────────────────── 状态 ────────────────────────────
const fields = ref<FieldDef[]>([])
const selectedId = ref<string | null>(null)
const showPreview = ref(false)
const submitting = ref(false)

const showCreateDialog = ref(false)
const createForm = ref({ dbName: '', collectionName: '' })

const showCrudDialog = ref(false)
const crudForm = ref({ dirName: '', controllerName: '', tableName: '' })
const dragOverCanvas = ref(false)
const draggingId = ref<string | null>(null)
const formConfigRef = ref<InstanceType<typeof FormConfigDialog>>()
const propertyPanelRef = ref<InstanceType<typeof FieldPropertyPanel>>()

let draggingType: BsonType | null = null
let draggingFieldId: string | null = null
let draggingFieldIndex: number = -1
let dragOverResetTimer: ReturnType<typeof setTimeout> | null = null

// ──────────────────────────── 计算属性 ────────────────────────────
const selectedField = computed(() =>
  fields.value.find(f => f.id === selectedId.value) ?? null
)

const canvasAddActive = computed(() =>
  dragOverCanvas.value && draggingType !== null
)

const requiredKeys = computed(() =>
  fields.value.filter(f => f.required).map(f => f.key).filter(Boolean)
)

const jsonSchemaPreview = computed(() => {
  const properties: Record<string, unknown> = {}
  for (const f of fields.value) {
    if (!f.key) continue
    properties[f.key] = buildFieldSpec(f)
  }
  const schema: Record<string, unknown> = { bsonType: 'object', properties }
  if (requiredKeys.value.length) schema.required = requiredKeys.value
  return { $jsonSchema: schema }
})

// ──────────────────────────── 工具函数 ────────────────────────────
const genId = () => Math.random().toString(36).slice(2)

function buildFieldList() {
  return fields.value
    .filter(f => f.key.trim())
    .map(f => {
      const item: Record<string, unknown> = {
        key: f.key.trim(),
        ...buildFieldSpec(f),
      }
      return item
    })
}

function getFilenameFromDisposition(disposition?: string) {
  if (!disposition) return ''
  const utf8Match = disposition.match(/filename\*=UTF-8''([^;]+)/i)
  if (utf8Match?.[1]) return decodeURIComponent(utf8Match[1])
  const plainMatch = disposition.match(/filename="?([^"]+)"?/i)
  return plainMatch?.[1] ?? ''
}

function triggerBrowserDownload(blob: Blob, fileName: string) {
  const downloadUrl = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = downloadUrl
  link.download = fileName
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
  URL.revokeObjectURL(downloadUrl)
}

// ──────────────────────────── 左侧拖拽 ────────────────────────────
function onTypeDragStart(e: DragEvent, bsonType: BsonType) {
  draggingType = bsonType
  draggingFieldId = null
  e.dataTransfer!.effectAllowed = 'copy'
}

function onTypeDragEnd() {
  draggingType = null
  resetCanvasDragState()
}

function addField(bsonType: BsonType) {
  const newField: FieldDef = {
    id: genId(),
    key: '',
    bsonType,
    description: '',
    required: false,
  }
  fields.value.push(newField)
  selectedId.value = newField.id
  nextTick(() => {
    const input = document.getElementById(`key-input-${newField.id}`)
    input?.focus()
  })
}

// ──────────────────────────── 画布内排序拖拽 ────────────────────────────
function onFieldDragStart(e: DragEvent, index: number, id: string) {
  draggingFieldId = id
  draggingFieldIndex = index
  draggingType = null
  draggingId.value = id
  e.dataTransfer!.effectAllowed = 'move'
}

function onFieldDragEnd() {
  draggingFieldId = null
  draggingFieldIndex = -1
  draggingId.value = null
  resetCanvasDragState()
}

function onFieldDragOver(e: DragEvent, index: number) {
  e.preventDefault()
  if (draggingFieldId === null) return
  if (index === draggingFieldIndex) return
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  const offsetY = e.clientY - rect.top
  const midpoint = rect.height / 2
  const movingDown = draggingFieldIndex < index
  const movingUp = draggingFieldIndex > index
  if (movingDown && offsetY < midpoint) return
  if (movingUp && offsetY > midpoint) return
  const arr = [...fields.value]
  const item = arr.splice(draggingFieldIndex, 1)[0]
  arr.splice(index, 0, item)
  fields.value = arr
  draggingFieldIndex = index
}

// ──────────────────────────── 画布放置 ────────────────────────────
function resetCanvasDragState() {
  if (dragOverResetTimer) {
    clearTimeout(dragOverResetTimer)
    dragOverResetTimer = null
  }
  dragOverCanvas.value = false
}

function keepCanvasDragAlive() {
  if (!dragOverCanvas.value) dragOverCanvas.value = true
  if (dragOverResetTimer) clearTimeout(dragOverResetTimer)
  dragOverResetTimer = setTimeout(() => {
    dragOverCanvas.value = false
    dragOverResetTimer = null
  }, 120)
}

function onCanvasDragOver(e: DragEvent) {
  e.preventDefault()
  if (!draggingType) {
    resetCanvasDragState()
    e.dataTransfer!.dropEffect = 'move'
    return
  }
  keepCanvasDragAlive()
  e.dataTransfer!.dropEffect = 'copy'
}

function onCanvasDrop(e: DragEvent) {
  e.preventDefault()
  resetCanvasDragState()
  if (!draggingType) return
  addField(draggingType)
  draggingType = null
}

// ──────────────────────────── 字段操作 ────────────────────────────
function selectField(id: string) {
  selectedId.value = id
}

function deleteField(id: string) {
  fields.value = fields.value.filter(f => f.id !== id)
  if (selectedId.value === id) selectedId.value = null
}

function duplicateField(id: string) {
  const idx = fields.value.findIndex(f => f.id === id)
  if (idx === -1) return
  const source = fields.value[idx]
  const copy: FieldDef = {
    ...source,
    id: genId(),
    key: source.key + '_copy',
    bsonType: Array.isArray(source.bsonType) ? [...source.bsonType] : source.bsonType,
  }
  fields.value.splice(idx + 1, 0, copy)
  selectedId.value = copy.id
}

function moveUp(index: number) {
  if (index === 0) return
  const arr = [...fields.value]
  ;[arr[index - 1], arr[index]] = [arr[index], arr[index - 1]]
  fields.value = arr
}

function moveDown(index: number) {
  if (index === fields.value.length - 1) return
  const arr = [...fields.value]
  ;[arr[index], arr[index + 1]] = [arr[index + 1], arr[index]]
  fields.value = arr
}

// ──────────────────────────── TransitionGroup 动画 ────────────────────────────
function onFieldBeforeLeave(el: Element) {
  const element = el as HTMLElement
  const parent = element.parentElement as HTMLElement | null
  if (!parent) return
  const rect = element.getBoundingClientRect()
  const parentRect = parent.getBoundingClientRect()
  element.style.width = `${rect.width}px`
  element.style.height = `${rect.height}px`
  element.style.position = 'absolute'
  element.style.left = `${rect.left - parentRect.left}px`
  element.style.top = `${rect.top - parentRect.top}px`
  element.style.zIndex = '1'
  element.style.pointerEvents = 'none'
}

function onFieldLeave(el: Element, done: () => void) {
  const element = el as HTMLElement
  void element.offsetHeight
  requestAnimationFrame(() => {
    element.style.opacity = '0'
    element.style.transform = 'translateX(32px)'
  })
  const handleTransitionEnd = (event: TransitionEvent) => {
    if (event.target !== element || event.propertyName !== 'opacity') return
    element.removeEventListener('transitionend', handleTransitionEnd)
    done()
  }
  element.addEventListener('transitionend', handleTransitionEnd)
}

function onFieldAfterLeave(el: Element) {
  const element = el as HTMLElement
  element.style.width = ''
  element.style.height = ''
  element.style.position = ''
  element.style.left = ''
  element.style.top = ''
  element.style.zIndex = ''
  element.style.pointerEvents = ''
  element.style.opacity = ''
  element.style.transform = ''
}

// ──────────────────────────── 表单类型配置弹窗 ────────────────────────────
function openFormConfig(ftValue: string, ftLabel: string) {
  formConfigRef.value?.open(ftValue, ftLabel)
}

function onFormConfigSaved() {
  propertyPanelRef.value?.switchToDetail()
}

// ──────────────────────────── 字段校验 ────────────────────────────
function validateFields(): string | null {
  const keys = fields.value.map(f => f.key.trim()).filter(Boolean)
  if (fields.value.length > 0 && keys.length !== fields.value.length) {
    return '存在字段名为空的字段，请填写完整'
  }
  const uniqueKeys = new Set(keys)
  if (uniqueKeys.size !== keys.length) return '字段名存在重复，请修改'
  return null
}

// ──────────────────────────── 创建集合 ────────────────────────────
function openCreateDialog() {
  const err = validateFields()
  if (err) { ElMessage.warning(err); return }
  createForm.value = { dbName: '', collectionName: '' }
  showCreateDialog.value = true
}

async function handleCreateCollection() {
  const { dbName, collectionName } = createForm.value
  if (!collectionName.trim()) { ElMessage.warning('请填写集合名'); return }

  submitting.value = true
  try {
    await http.request({
      method: 'POST',
      url: '/app/admin/dev/databaseDesign/databaseDesign/createDatabase',
      data: {
        dbName: dbName.trim() || undefined,
        tableName: collectionName.trim(),
        fields: buildFieldList(),
        required: requiredKeys.value,
        withValidator: buildFieldList().length > 0,
      },
    })
    ElMessage.success(`集合 "${collectionName}" 创建成功！`)
    showCreateDialog.value = false
  } catch {
  } finally {
    submitting.value = false
  }
}

// ──────────────────────────── 生成 CRUD ────────────────────────────
function openCrudDialog() {
  if (!fields.value.length) { ElMessage.warning('请先添加字段'); return }
  const err = validateFields()
  if (err) { ElMessage.warning(err); return }
  crudForm.value = { dirName: '', controllerName: '', tableName: '' }
  showCrudDialog.value = true
}

async function handleDownloadCRUD() {
  const { dirName, controllerName, tableName } = crudForm.value
  if (!dirName.trim()) { ElMessage.warning('请填写目录名称'); return }
  if (!controllerName.trim()) { ElMessage.warning('请填写控制器名称'); return }
  if (!tableName.trim()) { ElMessage.warning('请填写表名'); return }

  submitting.value = true
  try {
    const response = await http.request({
      method: 'POST',
      url: '/app/admin/dev/databaseDesign/databaseDesign/downloadCRUD',
      responseType: 'blob',
      data: {
        dirName: dirName.trim(),
        controllerName: controllerName.trim(),
        tableName: tableName.trim(),
        fields: fields.value.filter(f => f.key.trim()).map((f) => {
          const formConfig = f.formConfig
            ? (JSON.parse(JSON.stringify(f.formConfig)) as Record<string, unknown>)
            : undefined
          if (
            formConfig
            && ['select', 'radio', 'checkbox'].includes(f.formType || '')
            && Array.isArray(formConfig.data)
          ) {
            coerceOptionDataValues(
              formConfig.data as { value: unknown; label?: string }[],
              getOptionDataValueType(formConfig as Record<string, any>),
            )
          }
          if (formConfig && f.formType === 'switch' && isSwitchCustomValueEnabled(formConfig as Record<string, any>)) {
            coerceSwitchValues(formConfig as Record<string, any>)
          }
          return {
            key: f.key.trim(),
            ...buildFieldSpec(f),
            description: f.description || undefined,
            required: f.required,
            formType: f.formType || undefined,
            formConfig,
          }
        }),
      },
    })

    const fileName = getFilenameFromDisposition(response.headers['content-disposition'])
      || `${dirName.trim()}.zip`
    const blob = response.data instanceof Blob
      ? response.data
      : new Blob([response.data], { type: 'application/zip' })

    triggerBrowserDownload(blob, fileName)
    ElMessage.success('CRUD 代码包下载成功')
    showCrudDialog.value = false
  } catch {
  } finally {
    submitting.value = false
  }
}

function clearForm() {
  fields.value = []
  selectedId.value = null
}

async function handleReset() {
  try {
    await ElMessageBox.confirm('确认清空所有字段？', '提示', { type: 'warning' })
    clearForm()
  } catch {}
}
</script>

<template>
  <div class="db-designer h-full flex flex-col bg-gray-50 overflow-hidden">
    <!-- ───── 顶部栏 ───── -->
    <div class="flex items-center gap-3 px-4 py-3 bg-white border-b border-gray-200 shadow-sm flex-shrink-0">
      <div class="flex items-center gap-2 text-blue-600 font-bold text-lg select-none">
        <span class="text-xl">🗄️</span>
        <span>QuickAdmin CRUD生成器</span>
      </div>
      <div class="flex-1 flex items-center gap-3 ml-4">
        <div class="text-sm text-gray-400">
          <span class="bg-blue-50 text-blue-500 px-2 py-0.5 rounded-full">{{ fields.length }} 个字段</span>
          <span v-if="requiredKeys.length" class="ml-1 bg-red-50 text-red-500 px-2 py-0.5 rounded-full">{{ requiredKeys.length }} 必填</span>
        </div>
      </div>
      <div class="flex items-center gap-2 ml-auto">
        <el-button @click="showPreview = true" :disabled="!fields.length">预览 Schema</el-button>
        <el-button type="danger" plain @click="handleReset" :disabled="!fields.length">清空</el-button>
        <el-button :disabled="!fields.length" @click="openCreateDialog">创建集合</el-button>
        <el-button type="primary" :disabled="!fields.length" @click="openCrudDialog">生成 CRUD</el-button>
      </div>
    </div>

    <!-- ───── 主体三栏 ───── -->
    <div class="flex flex-1 overflow-hidden">
      <FieldTypePanel
        @drag-start="onTypeDragStart"
        @drag-end="onTypeDragEnd"
        @add="addField"
      />

      <FieldCanvas
        :fields="fields"
        :selected-id="selectedId"
        :dragging-id="draggingId"
        :canvas-add-active="canvasAddActive"
        @select="selectField"
        @delete="deleteField"
        @duplicate="duplicateField"
        @move-up="moveUp"
        @move-down="moveDown"
        @canvas-drag-over="onCanvasDragOver"
        @canvas-drop="onCanvasDrop"
        @field-drag-start="onFieldDragStart"
        @field-drag-over="onFieldDragOver"
        @field-drag-end="onFieldDragEnd"
        @before-leave="onFieldBeforeLeave"
        @leave="onFieldLeave"
        @after-leave="onFieldAfterLeave"
      />

      <FieldPropertyPanel
        ref="propertyPanelRef"
        :selected-field="selectedField"
        @open-form-config="openFormConfig"
      />
    </div>

    <!-- ───── 弹窗 ───── -->
    <FormConfigDialog ref="formConfigRef" :selected-field="selectedField" @saved="onFormConfigSaved" />

    <!-- 创建集合弹窗 -->
    <el-dialog v-model="showCreateDialog" title="创建集合" width="460" draggable :close-on-click-modal="false">
      <el-form label-width="80px" @submit.prevent="handleCreateCollection">
        <el-form-item label="数据库">
          <el-input v-model="createForm.dbName" placeholder="默认库（可不填）" clearable />
        </el-form-item>
        <el-form-item label="集合名" required>
          <el-input v-model="createForm.collectionName" placeholder="请输入集合名称" clearable />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showCreateDialog = false">取消</el-button>
        <el-button type="primary" :loading="submitting" @click="handleCreateCollection">确认创建</el-button>
      </template>
    </el-dialog>

    <!-- 生成 CRUD 弹窗 -->
    <el-dialog v-model="showCrudDialog" title="生成 CRUD 代码包" width="500" draggable :close-on-click-modal="false">
      <el-form label-width="90px" @submit.prevent="handleDownloadCRUD">
        <el-form-item label="目录名称" required>
          <el-input v-model="crudForm.dirName" placeholder="如 system" clearable />
        </el-form-item>
        <el-form-item label="控制器名称" required>
          <el-input v-model="crudForm.controllerName" placeholder="如 systemLog" clearable />
        </el-form-item>
        <el-form-item label="表名" required>
          <el-input v-model="crudForm.tableName" placeholder="数据库集合名" clearable />
        </el-form-item>
      </el-form>
      <div class="text-xs text-gray-400 mt-2 px-1">
        下载 ZIP 包含：<code class="bg-gray-100 px-1 rounded">{目录名}/{控制器名}.controller.ts</code> + <code class="bg-gray-100 px-1 rounded">{目录名}/index.vue</code>
      </div>
      <template #footer>
        <el-button @click="showCrudDialog = false">取消</el-button>
        <el-button type="primary" :loading="submitting" @click="handleDownloadCRUD">下载代码包</el-button>
      </template>
    </el-dialog>

    <el-dialog v-model="showPreview" title="完整 $jsonSchema 预览" width="600" draggable>
      <div class="text-xs text-gray-500 mb-2">
        该 Schema 将作为 <code class="bg-gray-100 px-1 rounded">validator.$jsonSchema</code> 写入 MongoDB 集合。
      </div>
      <pre class="text-sm bg-gray-50 border border-gray-200 rounded-xl p-4 overflow-auto max-h-96 leading-relaxed text-gray-700">{{ JSON.stringify(jsonSchemaPreview, null, 2) }}</pre>
      <template #footer>
        <el-button @click="showPreview = false">关闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped>
.db-designer {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}
</style>
