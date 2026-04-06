<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import { ArrowLeft } from '@element-plus/icons-vue'
import {
  FORM_TYPE_GROUPS, FORM_TYPE_CONFIG,
  getTypeDef, isStringType, isNumericType,
  coerceOptionDataValues,
  getOptionDataValueType,
  inferOptionDataValueType,
  type FieldDef, type ConfigField,
} from '../types'
import RouteActionSelect from './RouteActionSelect.vue'
import ConfigObjectArrayEditor from './ConfigObjectArrayEditor.vue'

const props = defineProps<{
  selectedField: FieldDef | null
}>()

const emit = defineEmits<{
  openFormConfig: [ftValue: string, ftLabel: string]
}>()

const rightTab = ref<'field' | 'form'>('field')
const formView = ref<'select' | 'detail'>('select')

const formTypeLabel = computed(() => {
  if (!props.selectedField?.formType) return ''
  for (const g of FORM_TYPE_GROUPS) {
    const ft = g.types.find(t => t.value === props.selectedField!.formType)
    if (ft) return ft.label
  }
  return props.selectedField.formType
})

const detailConfigFields = computed<ConfigField[]>(() => {
  if (!props.selectedField?.formType) return []
  return FORM_TYPE_CONFIG[props.selectedField.formType] ?? []
})

watch(() => props.selectedField?.id, () => {
  formView.value = props.selectedField?.formType ? 'detail' : 'select'
})

watch(
  () => ({ id: props.selectedField?.id, ft: props.selectedField?.formType }),
  () => {
    const f = props.selectedField
    if (!f || !['select', 'radio', 'checkbox'].includes(f.formType || '')) return
    if (!f.formConfig) f.formConfig = {}
    if (f.formConfig.dataValueType === undefined) {
      f.formConfig.dataValueType = inferOptionDataValueType(f.formConfig.data)
    }
  },
  { immediate: true },
)

watch(
  () => props.selectedField?.formConfig?.dataValueType,
  (next, prev) => {
    const data = props.selectedField?.formConfig?.data
    if (!props.selectedField?.formConfig) return
    if (next !== 'string' && next !== 'number') return
    if (prev === undefined && next === undefined) return
    if (next === prev) return
    coerceOptionDataValues(data, next)
  },
)

function switchToDetail() {
  formView.value = 'detail'
}

function backToSelect() {
  formView.value = 'select'
}

function clearFormType() {
  if (!props.selectedField) return
  props.selectedField.formType = undefined
  props.selectedField.formConfig = undefined
  formView.value = 'select'
}

function ensureFormConfig() {
  if (!props.selectedField) return
  if (!props.selectedField.formConfig) props.selectedField.formConfig = {}
}

const cfgModel = computed(() => {
  if (!props.selectedField) return {} as Record<string, any>
  if (!props.selectedField.formConfig) props.selectedField.formConfig = {}
  return props.selectedField.formConfig
})

const fieldSchemaPreview = computed(() => {
  const f = props.selectedField
  if (!f || !f.key) return { '(字段名为空)': {} }
  const spec: Record<string, unknown> = { bsonType: f.bsonType }
  if (f.description) spec.description = f.description
  if (isStringType(f.bsonType)) {
    if (f.minLength !== undefined) spec.minLength = f.minLength
    if (f.maxLength !== undefined) spec.maxLength = f.maxLength
    if (f.pattern) spec.pattern = f.pattern
    if (f.enumStr) spec.enum = f.enumStr.split(',').map((s: string) => s.trim()).filter(Boolean)
  }
  if (isNumericType(f.bsonType)) {
    if (f.minimum !== undefined) spec.minimum = f.minimum
    if (f.maximum !== undefined) spec.maximum = f.maximum
  }
  return { [f.key]: spec }
})

function addOptionItem(key: string) {
  ensureFormConfig()
  const cfg = props.selectedField!.formConfig!
  if (!cfg[key]) cfg[key] = []
  cfg[key].push({ value: '', label: '' })
}

function removeOptionItem(key: string, index: number) {
  props.selectedField?.formConfig?.[key]?.splice(index, 1)
}

defineExpose({ switchToDetail })
</script>

<template>
  <div class="right-panel w-72 bg-white border-l border-gray-200 flex flex-col overflow-hidden flex-shrink-0">
    <el-tabs v-model="rightTab" class="right-tabs" stretch>
      <el-tab-pane label="字段属性" name="field" />
      <el-tab-pane label="表单类型" name="form" />
    </el-tabs>

    <div class="flex-1 overflow-y-auto">
      <!-- ────── Tab: 字段属性 ────── -->
      <template v-if="rightTab === 'field'">
        <div v-if="!selectedField" class="flex flex-col items-center justify-center h-full gap-3 text-gray-400 select-none p-6">
          <span class="text-5xl opacity-50">🔧</span>
          <p class="text-sm text-center">点击中间字段<br>在此编辑属性</p>
        </div>

        <div v-else class="p-4 flex flex-col gap-4 text-sm">
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

          <div class="section">
            <p class="section-title">基础属性</p>
            <div class="field-item">
              <label class="field-label">字段名 <span class="text-red-500">*</span></label>
              <el-input v-model="selectedField.key" placeholder="字段名（key）" clearable />
            </div>
            <div class="field-item">
              <label class="field-label">描述</label>
              <el-input v-model="selectedField.description" placeholder="字段说明（description）" type="textarea" :rows="2" />
            </div>
            <div class="field-item flex items-center">
              <label class="field-label mb-0">必填</label>
              <div class="flex-1 flex items-center gap-2">
                <el-switch v-model="selectedField.required" />
                <span class="text-xs text-gray-400">{{ selectedField.required ? '该字段必须存在' : '该字段可选' }}</span>
              </div>
            </div>
          </div>

          <div v-if="isStringType(selectedField.bsonType)" class="section">
            <p class="section-title">字符串约束</p>
            <div class="field-item">
              <label class="field-label">minLength</label>
              <el-input-number v-model="selectedField.minLength" :min="0" class="w-full" placeholder="最小长度" controls-position="right" />
            </div>
            <div class="field-item">
              <label class="field-label">maxLength</label>
              <el-input-number v-model="selectedField.maxLength" :min="0" class="w-full" placeholder="最大长度" controls-position="right" />
            </div>
            <div class="field-item">
              <label class="field-label">pattern</label>
              <el-input v-model="selectedField.pattern" placeholder="正则表达式，如 ^[a-z]+$" />
              <p class="text-xs text-gray-400 mt-1">值须匹配此正则</p>
            </div>
            <div class="field-item">
              <label class="field-label">enum</label>
              <el-input v-model="selectedField.enumStr" placeholder="枚举值，逗号分隔" />
              <p class="text-xs text-gray-400 mt-1">如：active,inactive,pending</p>
            </div>
          </div>

          <div v-if="isNumericType(selectedField.bsonType)" class="section">
            <p class="section-title">数值约束</p>
            <div class="field-item">
              <label class="field-label">minimum</label>
              <el-input-number v-model="selectedField.minimum" class="w-full" placeholder="最小值" controls-position="right" />
            </div>
            <div class="field-item">
              <label class="field-label">maximum</label>
              <el-input-number v-model="selectedField.maximum" class="w-full" placeholder="最大值" controls-position="right" />
            </div>
          </div>

          <div class="section">
            <p class="section-title">当前字段 Schema</p>
            <pre class="text-xs bg-gray-50 border border-gray-100 rounded-lg p-2 overflow-x-auto leading-relaxed text-gray-600">{{ JSON.stringify(fieldSchemaPreview, null, 2) }}</pre>
          </div>
        </div>
      </template>

      <!-- ────── Tab: 表单类型 ────── -->
      <template v-if="rightTab === 'form'">
        <div v-if="!selectedField" class="flex flex-col items-center justify-center h-full gap-3 text-gray-400 select-none p-6">
          <span class="text-5xl opacity-50">📝</span>
          <p class="text-sm text-center">点击中间字段<br>在此设置表单类型</p>
        </div>

        <!-- ── 详情视图：已选类型的属性（可编辑） ── -->
        <div v-else-if="formView === 'detail' && selectedField.formType" class="p-4 flex flex-col gap-3 text-sm">
          <div class="flex items-center gap-2">
            <el-button text :icon="ArrowLeft" @click="backToSelect" class="!px-1 text-gray-400 hover:!text-blue-500">返回</el-button>
            <span class="px-2 py-0.5 rounded-full text-xs text-white bg-blue-500 font-medium">{{ formTypeLabel }}</span>
          </div>

          <div v-if="detailConfigFields.length" class="flex flex-col gap-3">
            <div v-for="cf in detailConfigFields" :key="cf.key" class="field-item" @click="ensureFormConfig()">
              <!-- 文本输入 -->
              <template v-if="cf.type === 'route-select'">
                <label class="field-label">{{ cf.label }}</label>
                <RouteActionSelect
                  v-model="cfgModel[cf.key]"
                  :placeholder="cf.placeholder || '请选择接口地址'"
                />
                <p v-if="cf.tip" class="text-xs text-gray-400 mt-0.5">{{ cf.tip }}</p>
              </template>

              <template v-else-if="cf.type === 'text'">
                <label class="field-label">{{ cf.label }}</label>
                <el-input v-model="cfgModel[cf.key]" :placeholder="cf.placeholder || ''" clearable />
                <p v-if="cf.tip" class="text-xs text-gray-400 mt-0.5">{{ cf.tip }}</p>
              </template>

              <!-- 数字输入 -->
              <template v-else-if="cf.type === 'number'">
                <label class="field-label">{{ cf.label }}</label>
                <el-input-number v-model="cfgModel[cf.key]" class="w-full" controls-position="right" />
                <p v-if="cf.tip" class="text-xs text-gray-400 mt-0.5">{{ cf.tip }}</p>
              </template>

              <!-- 开关 -->
              <template v-else-if="cf.type === 'switch'">
                <div class="flex items-center gap-3">
                  <label class="field-label mb-0 flex-shrink-0">{{ cf.label }}</label>
                  <el-switch v-model="cfgModel[cf.key]" />
                </div>
                <p v-if="cf.tip" class="text-xs text-gray-400">{{ cf.tip }}</p>
              </template>

              <!-- 下拉选择 -->
              <template v-else-if="cf.type === 'select'">
                <label class="field-label">{{ cf.label }}</label>
                <el-select v-model="cfgModel[cf.key]" clearable class="w-full">
                  <el-option v-for="opt in cf.options" :key="opt.value" :value="opt.value" :label="opt.label" />
                </el-select>
                <p v-if="cf.tip" class="text-xs text-gray-400 mt-0.5">{{ cf.tip }}</p>
              </template>

              <!-- 选项列表编辑器 -->
              <template v-else-if="cf.type === 'options-editor'">
                <label class="field-label">{{ cf.label }}</label>
                <p v-if="cf.tip" class="text-xs text-gray-400 mb-1">{{ cf.tip }}</p>
                <div class="flex flex-col gap-1.5">
                  <div v-for="(item, idx) in (cfgModel[cf.key] ?? [])" :key="idx" class="flex items-center gap-1">
                    <el-input
                      v-model="item.value"
                      class="flex-1"
                      placeholder="value"
                      :type="getOptionDataValueType(cfgModel) === 'number' ? 'number' : 'text'"
                    />
                    <el-input v-model="item.label" placeholder="label" class="flex-1" />
                    <el-button type="danger" text @click="removeOptionItem(cf.key, Number(idx))">✕</el-button>
                  </div>
                </div>
                <el-button type="primary" plain class="mt-1 w-full" @click="addOptionItem(cf.key)">
                  + 添加选项
                </el-button>
              </template>

              <template v-else-if="cf.type === 'object-array-editor'">
                <label class="field-label">{{ cf.label }}</label>
                <p v-if="cf.tip" class="text-xs text-gray-400 mb-1">{{ cf.tip }}</p>
                <ConfigObjectArrayEditor
                  :model-value="cfgModel[cf.key] ?? []"
                  :item-fields="cf.itemFields"
                  :add-text="cf.addText"
                  @update:model-value="cfgModel[cf.key] = $event"
                />
              </template>
            </div>
          </div>
          <div v-else class="text-center text-gray-400 py-4 text-xs">
            该类型无需配置
          </div>

          <div class="pt-3 border-t border-gray-100">
            <el-button type="danger" plain class="w-full" @click="clearFormType">
              清除表单类型
            </el-button>
          </div>
        </div>

        <!-- ── 选择视图：类型网格 ── -->
        <div v-else class="p-4 flex flex-col gap-3 text-sm">
          <div class="flex items-center gap-2 p-2 rounded-lg bg-gray-50 border border-gray-100">
            <span class="text-xs text-gray-400">当前字段:</span>
            <span class="font-medium text-gray-700">{{ selectedField.key || '(未命名)' }}</span>
            <span v-if="selectedField.formType" class="ml-auto px-2 py-0.5 rounded-full text-xs text-white bg-blue-500">{{ selectedField.formType }}</span>
            <span v-else class="ml-auto text-xs text-gray-400">未设置</span>
          </div>

          <div v-for="group in FORM_TYPE_GROUPS" :key="group.name" class="section">
            <p class="section-title">{{ group.name }}</p>
            <div class="grid grid-cols-2 gap-1.5">
              <div
                v-for="ft in group.types"
                :key="ft.value"
                class="form-type-card px-2 py-2 rounded-lg border text-center cursor-pointer transition-all duration-150 select-none"
                :class="selectedField.formType === ft.value
                  ? 'border-blue-400 bg-blue-50 text-blue-600 shadow-sm'
                  : 'border-gray-200 bg-white text-gray-600 hover:border-blue-200 hover:bg-blue-50/50'"
                @click="emit('openFormConfig', ft.value, ft.label)"
              >
                <span class="text-xs font-medium leading-tight">{{ ft.label }}</span>
              </div>
            </div>
          </div>
        </div>
      </template>
    </div>
  </div>
</template>

<style scoped>
.right-panel::-webkit-scrollbar {
  width: 4px;
}
.right-panel::-webkit-scrollbar-thumb {
  background: #e5e7eb;
  border-radius: 4px;
}

.right-tabs {
  flex-shrink: 0;
}
:deep(.right-tabs .el-tabs__header) {
  margin: 0;
  border-bottom: 1px solid #f3f4f6;
}
:deep(.right-tabs .el-tabs__nav-wrap::after) {
  display: none;
}
:deep(.right-tabs .el-tabs__item) {
  font-size: 12px;
  height: 36px;
  line-height: 36px;
  font-weight: 600;
  color: #9ca3af;
  letter-spacing: 0.03em;
}
:deep(.right-tabs .el-tabs__item.is-active) {
  color: #2563eb;
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

.form-type-card {
  transition: transform 0.1s ease, box-shadow 0.15s ease;
}
.form-type-card:active {
  transform: scale(0.96);
}

</style>
