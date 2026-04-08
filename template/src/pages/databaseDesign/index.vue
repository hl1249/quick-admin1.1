<script setup lang="ts">
import { ref, computed, nextTick, onMounted, onBeforeUnmount, watch } from 'vue'
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

interface SchemaRecord {
  _id: string
  name: string
  fields?: FieldDef[]
  required?: string[]
  jsonSchema?: Record<string, unknown>
  fieldCount?: number
  _add_time?: number
  _update_time?: number
}

const genId = () => Math.random().toString(36).slice(2)

function deepClone<T>(value: T): T {
  return JSON.parse(JSON.stringify(value)) as T
}

function normalizeField(field: Partial<FieldDef> | null | undefined): FieldDef {
  return {
    id: field?.id || genId(),
    key: field?.key || '',
    bsonType: field?.bsonType ?? 'string',
    description: field?.description || '',
    required: !!field?.required,
    typeRules: field?.typeRules ? deepClone(field.typeRules) : undefined,
    minLength: field?.minLength,
    maxLength: field?.maxLength,
    pattern: field?.pattern,
    minimum: field?.minimum,
    maximum: field?.maximum,
    formType: field?.formType,
    formConfig: field?.formConfig ? deepClone(field.formConfig) : undefined,
  }
}

function normalizeFields(source: unknown): FieldDef[] {
  if (!Array.isArray(source)) return []
  return source.map(item => normalizeField(item as Partial<FieldDef>))
}

function buildRequiredKeys(sourceFields: FieldDef[]) {
  return sourceFields.filter(f => f.required).map(f => f.key.trim()).filter(Boolean)
}

function buildJsonSchemaPreview(sourceFields: FieldDef[]) {
  const properties: Record<string, unknown> = {}
  for (const f of sourceFields) {
    if (!f.key?.trim()) continue
    properties[f.key.trim()] = buildFieldSpec(f)
  }
  const required = buildRequiredKeys(sourceFields)
  const schema: Record<string, unknown> = { bsonType: 'object', properties }
  if (required.length) schema.required = required
  return { $jsonSchema: schema }
}

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

function buildSchemaStorageFields(sourceFields: FieldDef[]) {
  return deepClone(sourceFields)
}

function buildSchemaSnapshot(schemaName: string, sourceFields: FieldDef[]) {
  return JSON.stringify({
    name: schemaName.trim(),
    fields: buildSchemaStorageFields(sourceFields),
    required: buildRequiredKeys(sourceFields),
    jsonSchema: buildJsonSchemaPreview(sourceFields).$jsonSchema,
  })
}

function syncSavedSnapshot(schemaName = currentSchemaName.value, sourceFields = fields.value) {
  lastSavedSnapshot.value = buildSchemaSnapshot(schemaName, sourceFields)
}

function extractResponseData<T = any>(res: any): T {
  return (res?.data?.data ?? res?.data ?? {}) as T
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

function getSchemaFieldCount(item: SchemaRecord) {
  if (typeof item.fieldCount === 'number') return item.fieldCount
  return Array.isArray(item.fields) ? item.fields.filter(field => field.key?.trim()).length : 0
}

// ──────────────────────────── 状态 ────────────────────────────
const fields = ref<FieldDef[]>([])
const selectedId = ref<string | null>(null)
const showPreview = ref(false)
const submitting = ref(false)
const schemaSubmitting = ref(false)
const loadingSchemas = ref(false)

const showCreateDialog = ref(false)
const createForm = ref({ dbName: '', collectionName: '' })

const showCrudDialog = ref(false)
const crudForm = ref({ dirName: '', controllerName: '', tableName: '' })

const showSchemaCreateDialog = ref(false)
const schemaCreateForm = ref({ name: '' })
const schemaOptions = ref<SchemaRecord[]>([])
const schemaSelectModel = ref('')
const currentSchemaId = ref('')
const currentSchemaName = ref('')
const lastSavedSnapshot = ref('')
const autoSavePending = ref(false)
const autoSaving = ref(false)

const dragOverCanvas = ref(false)
const draggingId = ref<string | null>(null)
const formConfigRef = ref<InstanceType<typeof FormConfigDialog>>()
const propertyPanelRef = ref<InstanceType<typeof FieldPropertyPanel>>()

let draggingType: BsonType | null = null
let draggingFieldId: string | null = null
let draggingFieldIndex: number = -1
let dragOverResetTimer: ReturnType<typeof setTimeout> | null = null
let autoSaveTimer: ReturnType<typeof setTimeout> | null = null
let isApplyingSchema = false

// ──────────────────────────── 计算属性 ────────────────────────────
const selectedField = computed(() =>
  fields.value.find(f => f.id === selectedId.value) ?? null
)

const canvasAddActive = computed(() =>
  dragOverCanvas.value && draggingType !== null
)

const requiredKeys = computed(() => buildRequiredKeys(fields.value))

const jsonSchemaPreview = computed(() => buildJsonSchemaPreview(fields.value))

const hasActiveSchema = computed(() => !!currentSchemaId.value)

const isSchemaDirty = computed(() => {
  if (!hasActiveSchema.value) return false
  return buildSchemaSnapshot(currentSchemaName.value, fields.value) !== lastSavedSnapshot.value
})

// ──────────────────────────── Schema 选择 / 保存 ────────────────────────────
function clearAutoSaveTimer() {
  if (!autoSaveTimer) return
  clearTimeout(autoSaveTimer)
  autoSaveTimer = null
}

function applySchema(schema: SchemaRecord | null) {
  isApplyingSchema = true
  clearAutoSaveTimer()
  autoSavePending.value = false

  if (!schema) {
    currentSchemaId.value = ''
    currentSchemaName.value = ''
    schemaSelectModel.value = ''
    fields.value = []
    selectedId.value = null
    lastSavedSnapshot.value = ''
    return
  }

  const normalizedFields = normalizeFields(schema.fields)
  currentSchemaId.value = schema._id
  currentSchemaName.value = schema.name
  schemaSelectModel.value = schema._id
  fields.value = normalizedFields
  selectedId.value = normalizedFields[0]?.id ?? null
  syncSavedSnapshot(schema.name, normalizedFields)

  nextTick(() => {
    isApplyingSchema = false
  })
}

async function loadSchemaList(preferredId?: string) {
  loadingSchemas.value = true
  try {
    const res = await http.request({
      method: 'POST',
      url: '/app/admin/dev/databaseDesign/schemas/getList',
      openMessage: false,
      data: {
        pageIndex: 1,
        pageSize: 200,
        sortRule: [{ name: '_add_time', type: 'desc' }],
      },
    })
    const payload = extractResponseData<{ rows?: SchemaRecord[] }>(res)
    schemaOptions.value = Array.isArray(payload.rows) ? payload.rows : []

    const targetId = preferredId || currentSchemaId.value
    if (targetId) {
      const target = schemaOptions.value.find(item => `${item._id}` === `${targetId}`)
      if (target) applySchema(target)
    }
  } catch {
    schemaOptions.value = []
  } finally {
    loadingSchemas.value = false
  }
}

async function confirmDiscardChanges() {
  if (!isSchemaDirty.value) return true
  try {
    await ElMessageBox.confirm(
      '当前 Schema 有未保存改动，切换后这些修改会丢失，是否继续？',
      '提示',
      { type: 'warning' },
    )
    return true
  } catch {
    return false
  }
}

async function openSchemaCreateDialog() {
  if (!(await confirmDiscardChanges())) return
  schemaCreateForm.value = { name: '' }
  showSchemaCreateDialog.value = true
}

async function handleSchemaSelectionChange(value: string) {
  if (!value || value === currentSchemaId.value) {
    schemaSelectModel.value = currentSchemaId.value
    return
  }

  if (!(await confirmDiscardChanges())) {
    schemaSelectModel.value = currentSchemaId.value
    return
  }

  const target = schemaOptions.value.find(item => `${item._id}` === `${value}`)
  if (!target) {
    schemaSelectModel.value = currentSchemaId.value
    ElMessage.warning('未找到所选 Schema')
    return
  }

  applySchema(target)
}

async function handleCreateSchema() {
  const name = schemaCreateForm.value.name.trim()
  if (!name) {
    ElMessage.warning('请填写 Schema 名称')
    return
  }
  if (schemaOptions.value.some(item => item.name === name)) {
    ElMessage.warning('Schema 名称已存在，请更换')
    return
  }

  schemaSubmitting.value = true
  try {
    const res = await http.request({
      method: 'POST',
      url: '/app/admin/dev/databaseDesign/schemas/add',
      data: {
        name,
        fields: [],
        required: [],
        jsonSchema: { bsonType: 'object', properties: {} },
        fieldCount: 0,
      },
    })

    const responseData = extractResponseData<{ insertedId?: string | { $oid?: string } }>(res)
    const insertedId = typeof responseData.insertedId === 'string'
      ? responseData.insertedId
      : responseData.insertedId?.$oid

    await loadSchemaList()
    const created = schemaOptions.value.find(item =>
      insertedId
        ? `${item._id}` === `${insertedId}`
        : item.name === name,
    )
    if (created) applySchema(created)

    showSchemaCreateDialog.value = false
    ElMessage.success(`Schema "${name}" 创建成功`)
  } catch {
  } finally {
    schemaSubmitting.value = false
  }
}

async function persistSchema(openMessage = false) {
  if (!currentSchemaId.value) {
    return false
  }

  clearAutoSaveTimer()
  autoSavePending.value = false
  autoSaving.value = true
  try {
    await http.request({
      method: 'POST',
      url: '/app/admin/dev/databaseDesign/schemas/update',
      data: {
        _id: currentSchemaId.value,
        name: currentSchemaName.value,
        fields: buildSchemaStorageFields(fields.value),
        required: buildRequiredKeys(fields.value),
        jsonSchema: buildJsonSchemaPreview(fields.value).$jsonSchema,
        fieldCount: fields.value.filter(field => field.key.trim()).length,
      },
    })
    syncSavedSnapshot()
    if (openMessage) {
      ElMessage.success('Schema 已保存')
    }
    return true
  } catch {
    autoSavePending.value = buildSchemaSnapshot(currentSchemaName.value, fields.value) !== lastSavedSnapshot.value
    return false
  } finally {
    autoSaving.value = false
  }
}

function queueAutoSave() {
  if (!hasActiveSchema.value || isApplyingSchema) return
  if (!isSchemaDirty.value) {
    autoSavePending.value = false
    clearAutoSaveTimer()
    return
  }

  autoSavePending.value = true
  clearAutoSaveTimer()
  autoSaveTimer = setTimeout(() => {
    void persistSchema()
  }, 500)
}

async function handleBackToSchemaList() {
  clearAutoSaveTimer()
  if (isSchemaDirty.value || autoSavePending.value) {
    const success = await persistSchema()
    if (!success) return
  }
  applySchema(null)
  await loadSchemaList()
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
  if (!hasActiveSchema.value) {
    ElMessage.warning('请先新建或选择 Schema')
    return
  }

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
    ...deepClone(source),
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
  if (!hasActiveSchema.value) {
    ElMessage.warning('请先新建或选择 Schema')
    return
  }
  const err = validateFields()
  if (err) { ElMessage.warning(err); return }
  createForm.value = { dbName: '', collectionName: currentSchemaName.value || '' }
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
  if (!hasActiveSchema.value) {
    ElMessage.warning('请先新建或选择 Schema')
    return
  }
  if (!fields.value.length) { ElMessage.warning('请先添加字段'); return }
  const err = validateFields()
  if (err) { ElMessage.warning(err); return }
  crudForm.value = { dirName: '', controllerName: '', tableName: currentSchemaName.value || '' }
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
            ? (deepClone(f.formConfig) as Record<string, unknown>)
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
  if (!hasActiveSchema.value) return
  try {
    await ElMessageBox.confirm('确认清空当前 Schema 的所有字段？', '提示', { type: 'warning' })
    clearForm()
  } catch {}
}

onMounted(() => {
  void loadSchemaList()
})

onBeforeUnmount(() => {
  clearAutoSaveTimer()
})

watch(
  fields,
  () => {
    queueAutoSave()
  },
  { deep: true },
)
</script>

<template>
  <div class="db-designer h-full flex flex-col bg-gray-50 overflow-hidden">
    <div
      v-if="hasActiveSchema"
      class="flex items-center gap-3 px-4 py-3 bg-white border-b border-gray-200 shadow-sm flex-shrink-0"
    >
      <el-button plain @click="handleBackToSchemaList">返回</el-button>

      <div class="flex items-center gap-2 text-blue-600 font-bold text-lg select-none">
        <span class="text-xl">🗄️</span>
        <span>QuickAdmin CRUD生成器</span>
      </div>

      <div class="flex-1 flex items-center gap-3 ml-4 flex-wrap">
        <template v-if="!hasActiveSchema">
          <el-select
            v-model="schemaSelectModel"
            class="w-[280px]"
            filterable
            clearable
            :loading="loadingSchemas"
            placeholder="请选择已有 Schema"
            @change="handleSchemaSelectionChange"
          >
            <el-option
              v-for="item in schemaOptions"
              :key="item._id"
              :label="item.name"
              :value="item._id"
            >
              <div class="flex items-center justify-between gap-3">
                <span>{{ item.name }}</span>
                <span class="text-xs text-gray-400">{{ getSchemaFieldCount(item) }} 个字段</span>
              </div>
            </el-option>
          </el-select>

          <el-button @click="openSchemaCreateDialog">新建 Schema</el-button>
          <el-button text :loading="loadingSchemas" @click="loadSchemaList()">刷新列表</el-button>
        </template>

        <div class="text-sm text-gray-400 flex items-center gap-2 flex-wrap">
          <span v-if="hasActiveSchema" class="bg-blue-50 text-blue-500 px-2 py-0.5 rounded-full">
            当前：{{ currentSchemaName }}
          </span>
          <span v-else class="bg-gray-100 text-gray-500 px-2 py-0.5 rounded-full">
            未选择 Schema
          </span>
          <span v-if="hasActiveSchema" class="bg-slate-100 text-slate-600 px-2 py-0.5 rounded-full">
            {{ fields.length }} 个字段
          </span>
          <span v-if="requiredKeys.length" class="bg-red-50 text-red-500 px-2 py-0.5 rounded-full">
            {{ requiredKeys.length }} 必填
          </span>
          <span v-if="hasActiveSchema && autoSavePending" class="bg-amber-50 text-amber-600 px-2 py-0.5 rounded-full">
            500ms 后自动保存
          </span>
          <span v-if="hasActiveSchema && autoSaving" class="bg-green-50 text-green-600 px-2 py-0.5 rounded-full">
            自动保存中
          </span>
        </div>
      </div>

      <div class="flex items-center gap-2 ml-auto">
        <el-button @click="showPreview = true" :disabled="!hasActiveSchema">预览 Schema</el-button>
        <el-button type="danger" plain @click="handleReset" :disabled="!hasActiveSchema || !fields.length">清空</el-button>
        <el-button :disabled="!hasActiveSchema || !fields.length" @click="openCreateDialog">创建集合</el-button>
        <el-button type="primary" :disabled="!hasActiveSchema || !fields.length" @click="openCrudDialog">生成 CRUD</el-button>
      </div>
    </div>

    <div v-if="!hasActiveSchema" class="flex-1 flex items-center justify-center p-8">
      <div class="w-full max-w-2xl bg-white border border-gray-200 rounded-2xl shadow-sm p-8">
        <h2 class="text-2xl font-semibold text-gray-800">先新建 Schema，或选择已有 Schema</h2>
        <p class="text-sm text-gray-500 mt-3 leading-6">
          新建后会先在 `qa-schemas` 库里创建一条 schema 记录；选择已有 schema 后，会把已保存的字段属性和每个字段的表单类型加载回来继续编辑。
        </p>

        <div class="mt-6 flex flex-wrap items-center gap-3">
          <el-button type="primary" @click="openSchemaCreateDialog">新建 Schema</el-button>
          <el-button :loading="loadingSchemas" @click="loadSchemaList()">刷新列表</el-button>
        </div>

        <div class="mt-6">
          <div class="text-sm text-gray-600 mb-2">选择已有 Schema</div>
          <el-select
            v-model="schemaSelectModel"
            class="w-full"
            filterable
            clearable
            :loading="loadingSchemas"
            placeholder="请选择已有 Schema"
            @change="handleSchemaSelectionChange"
          >
            <el-option
              v-for="item in schemaOptions"
              :key="item._id"
              :label="item.name"
              :value="item._id"
            >
              <div class="flex items-center justify-between gap-3">
                <span>{{ item.name }}</span>
                <span class="text-xs text-gray-400">{{ getSchemaFieldCount(item) }} 个字段</span>
              </div>
            </el-option>
          </el-select>
          <div class="text-xs text-gray-400 mt-2">
            当前共 {{ schemaOptions.length }} 个 Schema。
          </div>
        </div>
      </div>
    </div>

    <div v-else class="flex flex-1 overflow-hidden">
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

    <FormConfigDialog ref="formConfigRef" :selected-field="selectedField" @saved="onFormConfigSaved" />

    <el-dialog
      v-model="showSchemaCreateDialog"
      title="新建 Schema"
      width="420"
      draggable
      :close-on-click-modal="false"
    >
      <el-form label-width="90px" @submit.prevent="handleCreateSchema">
        <el-form-item label="Schema 名称" required>
          <el-input v-model="schemaCreateForm.name" placeholder="请输入 schema 名称" clearable />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showSchemaCreateDialog = false">取消</el-button>
        <el-button type="primary" :loading="schemaSubmitting" @click="handleCreateSchema">确认创建</el-button>
      </template>
    </el-dialog>

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
