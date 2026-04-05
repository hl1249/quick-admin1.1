<script setup lang="ts">
import { ref, computed, nextTick } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ArrowUp, ArrowDown, Plus } from '@element-plus/icons-vue'
import http from '@/utils/axios'

// ──────────────────────────── 类型定义 ────────────────────────────
type BsonType =
  | 'string' | 'number' | 'int' | 'long' | 'decimal'
  | 'bool' | 'date' | 'objectId' | 'array' | 'object' | 'binData'

interface FieldDef {
  id: string
  key: string
  bsonType: BsonType
  description: string
  required: boolean
  // string 约束
  minLength?: number
  maxLength?: number
  pattern?: string
  enumStr?: string   // 逗号分隔，提交时转为数组
  // number/int/long/decimal 约束
  minimum?: number
  maximum?: number
}

// ──────────────────────────── 左侧字段类型面板 ────────────────────────────
interface TypeDef {
  bsonType: BsonType
  label: string
  icon: string
  color: string
  desc: string
}

const TYPE_DEFS: TypeDef[] = [
  { bsonType: 'string',   label: 'String',   icon: 'T',  color: '#409EFF', desc: '文本字符串' },
  { bsonType: 'int',      label: 'Int32',    icon: '①',  color: '#67C23A', desc: '32位整数' },
  { bsonType: 'long',     label: 'Int64',    icon: 'L',  color: '#67C23A', desc: '64位整数' },
  { bsonType: 'number',   label: 'Double',   icon: '#',  color: '#E6A23C', desc: '双精度浮点' },
  { bsonType: 'decimal',  label: 'Decimal',  icon: 'D',  color: '#E6A23C', desc: '高精度小数' },
  { bsonType: 'bool',     label: 'Boolean',  icon: '✓',  color: '#909399', desc: '布尔值' },
  { bsonType: 'date',     label: 'Date',     icon: '📅', color: '#F56C6C', desc: '日期时间' },
  { bsonType: 'objectId', label: 'ObjectId', icon: '🔑', color: '#B39DDB', desc: 'MongoDB ID' },
  { bsonType: 'array',    label: 'Array',    icon: '[]', color: '#26C6DA', desc: '数组' },
  { bsonType: 'object',   label: 'Object',   icon: '{}', color: '#FF8A65', desc: '嵌套对象' },
  { bsonType: 'binData',  label: 'BinData',  icon: '⬛', color: '#78909C', desc: '二进制数据' },
]

// ──────────────────────────── 状态 ────────────────────────────
const collectionName = ref('')
const dbName = ref('')
const fields = ref<FieldDef[]>([])
const selectedId = ref<string | null>(null)
const showPreview = ref(false)
const submitting = ref(false)
const dragOverCanvas = ref(false)
// 当前正在被拖拽的字段 id（用于模板中半透明样式）
const draggingId = ref<string | null>(null)

// 拖拽：从左侧类型面板拖入
let draggingType: BsonType | null = null
// 拖拽：在画布内排序
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
    const spec: Record<string, unknown> = { bsonType: f.bsonType }
    if (f.description) spec.description = f.description
    if (['string'].includes(f.bsonType)) {
      if (f.minLength !== undefined) spec.minLength = f.minLength
      if (f.maxLength !== undefined) spec.maxLength = f.maxLength
      if (f.pattern) spec.pattern = f.pattern
      if (f.enumStr) spec.enum = f.enumStr.split(',').map(s => s.trim()).filter(Boolean)
    }
    if (['number', 'int', 'long', 'decimal'].includes(f.bsonType)) {
      if (f.minimum !== undefined) spec.minimum = f.minimum
      if (f.maximum !== undefined) spec.maximum = f.maximum
    }
    properties[f.key] = spec
  }
  const schema: Record<string, unknown> = { bsonType: 'object', properties }
  if (requiredKeys.value.length) schema.required = requiredKeys.value
  return { $jsonSchema: schema }
})

// ──────────────────────────── 工具函数 ────────────────────────────
const genId = () => Math.random().toString(36).slice(2)

const getTypeDef = (bsonType: BsonType) =>
  TYPE_DEFS.find(t => t.bsonType === bsonType)!

const isNumericType = (t: BsonType) =>
  ['number', 'int', 'long', 'decimal'].includes(t)

const isStringType = (t: BsonType) => t === 'string'

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

function onTypeAddClick(bsonType: BsonType) {
  addField(bsonType)
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
  // 只有越过目标项中线才交换，避免在边界反复抖动
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
  if (!dragOverCanvas.value) {
    dragOverCanvas.value = true
  }
  if (dragOverResetTimer) {
    clearTimeout(dragOverResetTimer)
  }
  // 用 dragover 心跳保活高亮，避免边缘触发 leave 时闪烁
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
  const copy: FieldDef = { ...fields.value[idx], id: genId(), key: fields.value[idx].key + '_copy' }
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

// ──────────────────────────── 提交 ────────────────────────────
function validateBeforeSubmit(): string | null {
  if (!collectionName.value.trim()) return '请填写集合名（Collection Name）'
  const keys = fields.value.map(f => f.key.trim()).filter(Boolean)
  if (fields.value.length > 0 && keys.length !== fields.value.length) {
    return '存在字段名为空的字段，请填写完整'
  }
  const uniqueKeys = new Set(keys)
  if (uniqueKeys.size !== keys.length) return '字段名存在重复，请修改'
  return null
}

async function handleSubmit() {
  const err = validateBeforeSubmit()
  if (err) { ElMessage.warning(err); return }

  submitting.value = true
  try {
    const fieldList = fields.value
      .filter(f => f.key.trim())
      .map(f => {
        const item: Record<string, unknown> = {
          key: f.key.trim(),
          bsonType: f.bsonType,
        }
        if (f.description) item.description = f.description
        if (isStringType(f.bsonType)) {
          if (f.minLength !== undefined) item.minLength = f.minLength
          if (f.maxLength !== undefined) item.maxLength = f.maxLength
          if (f.pattern) item.pattern = f.pattern
          if (f.enumStr) item.enum = f.enumStr.split(',').map(s => s.trim()).filter(Boolean)
        }
        if (isNumericType(f.bsonType)) {
          if (f.minimum !== undefined) item.minimum = f.minimum
          if (f.maximum !== undefined) item.maximum = f.maximum
        }
        return item
      })

    await http.request({
      method: 'POST',
      // 动态加载器将文件路径映射为路由前缀：
      // src/app/admin/dev/databaseDesign/databaseDesign.controller.ts
      // → 前缀 /app/admin/dev/databaseDesign/databaseDesign
      // + @Post('/createDatabase') → 完整路径如下
      url: '/app/admin/dev/databaseDesign/databaseDesign/createDatabase',
      data: {
        dbName: dbName.value.trim() || undefined,
        tableName: collectionName.value.trim(),
        fields: fieldList,
        required: requiredKeys.value,
        withValidator: fieldList.length > 0,
      },
    })

    ElMessage.success(`集合 "${collectionName.value}" 创建成功！`)
    clearForm()
  } catch {
    // axios 拦截器已根据 HTTP 状态码自动展示后端返回的 message，此处不重复提示
  } finally {
    submitting.value = false
  }
}

/** 直接清空表单（无需确认），用于提交成功后重置 */
function clearForm() {
  collectionName.value = ''
  dbName.value = ''
  fields.value = []
  selectedId.value = null
}

/** 带确认弹窗的清空，用于手动点击"清空"按钮 */
async function handleReset() {
  try {
    await ElMessageBox.confirm('确认清空当前设计？', '提示', { type: 'warning' })
    clearForm()
  } catch {
    // 用户点取消，不做任何操作
  }
}
</script>

<template>
  <div class="db-designer h-full flex flex-col bg-gray-50 overflow-hidden">

    <!-- ───── 顶部栏 ───── -->
    <div class="flex items-center gap-3 px-4 py-3 bg-white border-b border-gray-200 shadow-sm flex-shrink-0">
      <div class="flex items-center gap-2 text-blue-600 font-bold text-lg select-none">
        <span class="text-xl">🗄️</span>
        <span>QuickAdmin 表设计器</span>
      </div>
      <div class="flex-1 flex items-center gap-3 ml-4">
        <div class="flex items-center gap-2">
          <span class="text-sm text-gray-500 whitespace-nowrap">数据库</span>
          <el-input
            v-model="dbName"
            placeholder="默认库（可不填）"
            size="small"
            class="w-40"
            clearable
          />
        </div>
        <span class="text-gray-300">/</span>
        <div class="flex items-center gap-2">
          <span class="text-sm text-gray-500 whitespace-nowrap">集合名 <span class="text-red-500">*</span></span>
          <el-input
            v-model="collectionName"
            placeholder="请输入 Collection 名称"
            size="small"
            class="w-52"
            clearable
          />
        </div>
        <div class="ml-2 text-sm text-gray-400">
          <span class="bg-blue-50 text-blue-500 px-2 py-0.5 rounded-full">{{ fields.length }} 个字段</span>
          <span v-if="requiredKeys.length" class="ml-1 bg-red-50 text-red-500 px-2 py-0.5 rounded-full">{{ requiredKeys.length }} 必填</span>
        </div>
      </div>
      <div class="flex items-center gap-2 ml-auto">
        <el-button size="small" @click="showPreview = true" :disabled="!fields.length">
          预览 Schema
        </el-button>
        <el-button size="small" type="danger" plain @click="handleReset" :disabled="!fields.length && !collectionName">
          清空
        </el-button>
        <el-button size="small" type="primary" :loading="submitting" :disabled="!collectionName.trim()" @click="handleSubmit">
          创建集合
        </el-button>
      </div>
    </div>

    <!-- ───── 主体三栏 ───── -->
    <div class="flex flex-1 overflow-hidden">

      <!-- ══════ 左侧：字段类型面板 ══════ -->
      <div class="left-panel w-44 bg-white border-r border-gray-200 flex flex-col overflow-y-auto flex-shrink-0">
        <div class="px-3 py-2 text-xs font-semibold text-gray-400 uppercase tracking-wider border-b border-gray-100 select-none">
          字段类型
        </div>
        <div class="p-2 flex flex-col gap-1">
          <div
            v-for="t in TYPE_DEFS"
            :key="t.bsonType"
            draggable="true"
            @dragstart="onTypeDragStart($event, t.bsonType)"
            @dragend="onTypeDragEnd"
            class="type-card flex items-center gap-2 px-2 py-2 rounded-lg cursor-grab
                   border border-transparent hover:border-blue-200 hover:bg-blue-50
                   active:cursor-grabbing select-none transition-all duration-150 group"
          >
            <span
              class="w-7 h-7 rounded-md flex items-center justify-center text-white text-xs font-bold flex-shrink-0"
              :style="{ backgroundColor: t.color }"
            >{{ t.icon }}</span>
            <div class="min-w-0">
              <div class="text-sm font-medium text-gray-700 leading-tight">{{ t.label }}</div>
              <div class="text-xs text-gray-400 leading-tight truncate">{{ t.desc }}</div>
            </div>
            <el-button
              type="primary"
              text
              bg
              size="small"
              draggable="false"
              class="type-add-btn ml-auto"
              :icon="Plus"
              title="直接添加字段"
              @mousedown.stop
              @click.stop="onTypeAddClick(t.bsonType)"
            />
          </div>
        </div>
        <div class="mt-auto px-3 py-3 text-xs text-gray-400 border-t border-gray-100">
          ← 拖拽到中间添加字段
        </div>
      </div>

      <!-- ══════ 中间：画布 ══════ -->
      <div
        class="flex-1 flex flex-col overflow-hidden"
        @dragover="onCanvasDragOver"
        @drop="onCanvasDrop"
      >
        <!-- 字段列表头 -->
        <div v-if="fields.length" class="flex items-center px-4 py-2 bg-gray-100 border-b border-gray-200 text-xs text-gray-500 font-medium select-none flex-shrink-0">
          <span class="w-8 text-center">#</span>
          <span class="w-6 ml-2"></span>
          <span class="flex-1 ml-2">字段名 (key)</span>
          <span class="w-24 text-center">BSON 类型</span>
          <span class="w-14 text-center">必填</span>
          <span class="w-28 text-center">操作</span>
        </div>

        <!-- 拖放区域 -->
        <div
          class="canvas-scroll flex-1 overflow-y-auto relative"
        >
          <!-- 空状态提示 -->
          <div
            v-if="!fields.length"
            class="absolute inset-0 flex flex-col items-center justify-center pointer-events-none transition-all duration-200"
            :class="canvasAddActive ? 'opacity-100' : 'opacity-60'"
          >
            <div
              class="w-64 h-40 rounded-2xl border-2 border-dashed flex flex-col items-center justify-center gap-3 transition-colors duration-200"
              :class="canvasAddActive ? 'border-blue-400 bg-blue-50' : 'border-gray-300 bg-white'"
            >
              <span class="text-4xl">📋</span>
              <p class="text-sm font-medium" :class="canvasAddActive ? 'text-blue-500' : 'text-gray-400'">
                {{ canvasAddActive ? '松开鼠标添加字段' : '从左侧拖入字段类型' }}
              </p>
            </div>
          </div>

          <!-- 字段列表 -->
          <TransitionGroup
            tag="div"
            name="field-list"
            class="relative overflow-hidden py-2 px-3 flex flex-col gap-1"
            @before-leave="onFieldBeforeLeave"
            @leave="onFieldLeave"
            @after-leave="onFieldAfterLeave"
          >
            <div
              v-for="(field, index) in fields"
              :key="field.id"
              draggable="true"
              @dragstart="onFieldDragStart($event, index, field.id)"
              @dragover.stop="onFieldDragOver($event, index)"
              @dragend="onFieldDragEnd"
              class="field-row flex items-center px-3 py-2 rounded-xl border transition-colors duration-150 cursor-pointer select-none"
              :class="[
                selectedId === field.id
                  ? 'border-blue-400 bg-blue-50 shadow-sm'
                  : 'border-gray-200 bg-white hover:border-blue-200 hover:bg-gray-50',
                draggingId === field.id ? 'opacity-40 scale-[0.98]' : ''
              ]"
              @click="selectField(field.id)"
            >
              <!-- 行号 -->
              <span class="w-5 text-xs text-gray-400 text-center flex-shrink-0">{{ index + 1 }}</span>

              <!-- 拖拽手柄 -->
              <span class="w-5 ml-1 text-gray-300 cursor-grab active:cursor-grabbing flex-shrink-0 text-center">⠿</span>

              <!-- 字段名输入 -->
              <div class="flex-1 ml-2" @click.stop>
                <input
                  :id="`key-input-${field.id}`"
                  v-model="field.key"
                  placeholder="字段名（必填）"
                  class="w-full text-sm bg-transparent border-none outline-none text-gray-800 placeholder-gray-300"
                  @focus="selectField(field.id)"
                />
              </div>

              <!-- 类型徽章 -->
              <div class="w-24 flex justify-center flex-shrink-0">
                <span
                  class="px-2 py-0.5 rounded-full text-xs text-white font-medium"
                  :style="{ backgroundColor: getTypeDef(field.bsonType).color }"
                >{{ getTypeDef(field.bsonType).label }}</span>
              </div>

              <!-- 必填 -->
              <div class="w-14 flex justify-center flex-shrink-0" @click.stop>
                <el-checkbox v-model="field.required" />
              </div>

              <!-- 操作按钮 -->
              <div class="w-28 flex items-center justify-end gap-1 flex-shrink-0" @click.stop>
                <button
                  class="p-1 text-gray-400 hover:text-blue-500 disabled:opacity-30 transition-colors"
                  :disabled="index === 0"
                  @click="moveUp(index)"
                >
                  <el-icon><ArrowUp /></el-icon>
                </button>
                <button
                  class="p-1 text-gray-400 hover:text-blue-500 disabled:opacity-30 transition-colors"
                  :disabled="index === fields.length - 1"
                  @click="moveDown(index)"
                >
                  <el-icon><ArrowDown /></el-icon>
                </button>
                <button
                  class="p-1 text-gray-400 hover:text-green-500 transition-colors"
                  @click="duplicateField(field.id)"
                >⧉</button>
                <button
                  class="p-1 text-gray-400 hover:text-red-500 transition-colors"
                  @click="deleteField(field.id)"
                >✕</button>
              </div>
            </div>
          </TransitionGroup>

          <!-- 底部拖入提示（有字段时） -->
          <div
            v-if="fields.length"
            class="mx-3 mb-2 flex items-center justify-center h-12 rounded-xl border-2 border-dashed transition-colors duration-200"
            :class="canvasAddActive ? 'border-blue-400 bg-blue-50' : 'border-gray-200'"
          >
            <span class="text-xs" :class="canvasAddActive ? 'text-blue-500' : 'text-gray-400'">
              {{ canvasAddActive ? '松开以添加字段' : '拖入新字段' }}
            </span>
          </div>
        </div>
      </div>

      <!-- ══════ 右侧：属性编辑器 ══════ -->
      <div class="right-panel w-72 bg-white border-l border-gray-200 flex flex-col overflow-y-auto flex-shrink-0">
        <div class="px-4 py-2 border-b border-gray-100 flex-shrink-0">
          <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider select-none">字段属性</p>
        </div>

        <!-- 无选中 -->
        <div v-if="!selectedField" class="flex flex-col items-center justify-center flex-1 gap-3 text-gray-400 select-none p-6">
          <span class="text-5xl opacity-50">🔧</span>
          <p class="text-sm text-center">点击中间字段<br>在此编辑属性</p>
        </div>

        <!-- 属性面板 -->
        <div v-else class="p-4 flex flex-col gap-4 text-sm">
          <!-- 类型标签 -->
          <div class="flex items-center gap-2 p-2 rounded-lg" :style="{ backgroundColor: getTypeDef(selectedField.bsonType).color + '18' }">
            <span
              class="w-8 h-8 rounded-md flex items-center justify-center text-white text-xs font-bold"
              :style="{ backgroundColor: getTypeDef(selectedField.bsonType).color }"
            >{{ getTypeDef(selectedField.bsonType).icon }}</span>
            <div>
              <p class="font-semibold text-gray-700">{{ getTypeDef(selectedField.bsonType).label }}</p>
              <p class="text-xs text-gray-400">{{ getTypeDef(selectedField.bsonType).desc }}</p>
            </div>
          </div>

          <!-- 基础属性 -->
          <div class="section">
            <p class="section-title">基础属性</p>
            <div class="field-item">
              <label class="field-label">字段名 <span class="text-red-500">*</span></label>
              <el-input v-model="selectedField.key" placeholder="字段名（key）" size="small" clearable />
            </div>
            <div class="field-item">
              <label class="field-label">描述</label>
              <el-input
                v-model="selectedField.description"
                placeholder="字段说明（description）"
                type="textarea"
                :rows="2"
                size="small"
              />
            </div>
            <div class="field-item flex items-center">
              <label class="field-label mb-0">必填</label>
              <div class="flex-1 flex items-center gap-2">
                <el-switch v-model="selectedField.required" />
                <span class="text-xs text-gray-400">{{ selectedField.required ? '该字段必须存在' : '该字段可选' }}</span>
              </div>
            </div>
          </div>

          <!-- String 约束 -->
          <div v-if="isStringType(selectedField.bsonType)" class="section">
            <p class="section-title">字符串约束</p>
            <div class="field-item">
              <label class="field-label">minLength</label>
              <el-input-number
                v-model="selectedField.minLength"
                :min="0"
                size="small"
                class="w-full"
                placeholder="最小长度"
                controls-position="right"
              />
            </div>
            <div class="field-item">
              <label class="field-label">maxLength</label>
              <el-input-number
                v-model="selectedField.maxLength"
                :min="0"
                size="small"
                class="w-full"
                placeholder="最大长度"
                controls-position="right"
              />
            </div>
            <div class="field-item">
              <label class="field-label">pattern</label>
              <el-input
                v-model="selectedField.pattern"
                placeholder="正则表达式，如 ^[a-z]+$"
                size="small"
              />
              <p class="text-xs text-gray-400 mt-1">值须匹配此正则</p>
            </div>
            <div class="field-item">
              <label class="field-label">enum</label>
              <el-input
                v-model="selectedField.enumStr"
                placeholder="枚举值，逗号分隔"
                size="small"
              />
              <p class="text-xs text-gray-400 mt-1">如：active,inactive,pending</p>
            </div>
          </div>

          <!-- 数值约束 -->
          <div v-if="isNumericType(selectedField.bsonType)" class="section">
            <p class="section-title">数值约束</p>
            <div class="field-item">
              <label class="field-label">minimum</label>
              <el-input-number
                v-model="selectedField.minimum"
                size="small"
                class="w-full"
                placeholder="最小值"
                controls-position="right"
              />
            </div>
            <div class="field-item">
              <label class="field-label">maximum</label>
              <el-input-number
                v-model="selectedField.maximum"
                size="small"
                class="w-full"
                placeholder="最大值"
                controls-position="right"
              />
            </div>
          </div>

          <!-- $jsonSchema 预览片段 -->
          <div class="section">
            <p class="section-title">当前字段 Schema</p>
            <pre class="text-xs bg-gray-50 border border-gray-100 rounded-lg p-2 overflow-x-auto leading-relaxed text-gray-600">{{ JSON.stringify(
              (() => {
                if (!selectedField.key) return { '(字段名为空)': {} }
                const spec: Record<string, unknown> = { bsonType: selectedField.bsonType }
                if (selectedField.description) spec.description = selectedField.description
                if (isStringType(selectedField.bsonType)) {
                  if (selectedField.minLength !== undefined) spec.minLength = selectedField.minLength
                  if (selectedField.maxLength !== undefined) spec.maxLength = selectedField.maxLength
                  if (selectedField.pattern) spec.pattern = selectedField.pattern
                  if (selectedField.enumStr) spec.enum = selectedField.enumStr.split(',').map((s: string) => s.trim()).filter(Boolean)
                }
                if (isNumericType(selectedField.bsonType)) {
                  if (selectedField.minimum !== undefined) spec.minimum = selectedField.minimum
                  if (selectedField.maximum !== undefined) spec.maximum = selectedField.maximum
                }
                return { [selectedField.key]: spec }
              })()
            , null, 2) }}</pre>
          </div>
        </div>
      </div>
    </div>

    <!-- ───── 预览 JSON Schema 弹窗 ───── -->
    <el-dialog
      v-model="showPreview"
      title="完整 $jsonSchema 预览"
      width="600"
      draggable
    >
      <div class="text-xs text-gray-500 mb-2">
        该 Schema 将作为 <code class="bg-gray-100 px-1 rounded">validator.$jsonSchema</code> 写入 MongoDB 集合。
      </div>
      <pre class="text-sm bg-gray-50 border border-gray-200 rounded-xl p-4 overflow-auto max-h-96 leading-relaxed text-gray-700">{{ JSON.stringify(jsonSchemaPreview, null, 2) }}</pre>
      <template #footer>
        <el-button @click="showPreview = false">关闭</el-button>
        <el-button type="primary" :loading="submitting" @click="showPreview = false; handleSubmit()">
          确认并创建集合
        </el-button>
      </template>
    </el-dialog>

  </div>
</template>

<style scoped>
.db-designer {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}

.left-panel::-webkit-scrollbar,
.right-panel::-webkit-scrollbar {
  width: 4px;
}
.left-panel::-webkit-scrollbar-thumb,
.right-panel::-webkit-scrollbar-thumb {
  background: #e5e7eb;
  border-radius: 4px;
}

.type-card {
  transition: transform 0.1s ease;
}
.type-card:active {
  transform: scale(0.97);
}

:deep(.type-add-btn) {
  width: 24px;
  height: 24px;
  padding: 0;
  border-radius: 0.375rem;
  color: #2563eb !important;
  background: #eff6ff !important;
  border: 1px solid #bfdbfe !important;
  box-shadow: 0 1px 2px rgba(37, 99, 235, 0.12);
}

:deep(.type-add-btn:hover) {
  color: #1d4ed8 !important;
  background: #dbeafe !important;
  border-color: #93c5fd !important;
  transform: scale(1.05);
}

.field-row {
  user-select: none;
}

.canvas-scroll {
  scrollbar-gutter: stable;
}

/* TransitionGroup FLIP 排序动画 */
.field-list-move {
  transition: transform 220ms cubic-bezier(0.25, 0.8, 0.25, 1);
}
/* 新增字段进入动画 */
.field-list-enter-active {
  transition: all 220ms cubic-bezier(0.25, 0.8, 0.25, 1);
}
.field-list-enter-from {
  opacity: 0;
  transform: translateX(-16px);
}
.field-list-leave-active {
  pointer-events: none;
  transition:
    opacity 180ms cubic-bezier(0.4, 0, 1, 1),
    transform 180ms cubic-bezier(0.25, 0.8, 0.25, 1);
}
.field-list-leave-to {
  opacity: 0;
  transform: translateX(32px);
}

.section {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.section-title {
  font-size: 0.75rem;
  font-weight: 600;
  color: #9ca3af;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  padding-bottom: 0.25rem;
  border-bottom: 1px solid #f3f4f6;
}

.field-item {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.field-label {
  font-size: 0.75rem;
  color: #6b7280;
  font-weight: 500;
}

:deep(.el-input-number) {
  width: 100%;
}
:deep(.el-input-number .el-input__wrapper) {
  width: 100%;
}
</style>
