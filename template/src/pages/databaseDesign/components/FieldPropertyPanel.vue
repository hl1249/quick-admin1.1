<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import { ArrowLeft } from '@element-plus/icons-vue'
import {
  buildFieldSpec,
  ensureFieldTypeRules,
  TYPE_DEFS,
  FORM_TYPE_GROUPS, FORM_TYPE_CONFIG,
  formatBsonTypeLabel,
  getBsonTypeList,
  getPrimaryBsonType,
  getTypeDef,
  normalizeBsonTypeValue,
  supportsNumericRule,
  supportsStringRule,
  supportsTypeRuleEditor,
  coerceSwitchValues,
  coerceOptionDataValues,
  getOptionDataValueType,
  inferOptionDataValueType,
  inferSwitchValueType,
  isSwitchCustomValueEnabled,
  type BsonType,
  type FieldDef, type ConfigField, type FieldTypeRule,
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

const bsonTypeModel = computed<BsonType[]>({
  get() {
    return getBsonTypeList(props.selectedField?.bsonType)
  },
  set(value) {
    if (!props.selectedField) return
    const nextValue = value.length ? value : [getPrimaryBsonType(props.selectedField.bsonType)]
    props.selectedField.bsonType = normalizeBsonTypeValue(nextValue)
  },
})

const selectedPrimaryTypeDef = computed(() => {
  if (!props.selectedField) return null
  return getTypeDef(getPrimaryBsonType(props.selectedField.bsonType))
})

const selectedBsonTypeLabel = computed(() => formatBsonTypeLabel(props.selectedField?.bsonType))

const selectedBsonTypeDesc = computed(() => {
  if (!props.selectedField) return ''
  if (getBsonTypeList(props.selectedField.bsonType).length > 1) return '当前字段允许多种 BSON 类型'
  return selectedPrimaryTypeDef.value?.desc ?? ''
})

const selectedRuleSections = computed(() => {
  const field = props.selectedField
  if (!field) return []
  const typeRules = ensureFieldTypeRules(field)
  return getBsonTypeList(field.bsonType)
    .filter(type => supportsTypeRuleEditor(type))
    .map(type => ({
      type,
      def: getTypeDef(type),
      rule: typeRules[type] as FieldTypeRule,
    }))
})

function isConfigFieldVisible(cf: ConfigField): boolean {
  if (!cf.visibleWhen) return true
  return cfgModel.value?.[cf.visibleWhen.key] === cf.visibleWhen.value
}

watch(() => props.selectedField?.id, () => {
  ensureFieldTypeRules(props.selectedField)
  formView.value = props.selectedField?.formType ? 'detail' : 'select'
})

watch(rightTab, (tab) => {
  if (tab !== 'form') return
  formView.value = props.selectedField?.formType ? 'detail' : 'select'
})

watch(
  () => props.selectedField?.bsonType,
  () => {
    ensureFieldTypeRules(props.selectedField)
  },
  { immediate: true, deep: true },
)

watch(
  () => ({ id: props.selectedField?.id, ft: props.selectedField?.formType }),
  () => {
    const f = props.selectedField
    if (!f || !['select', 'radio', 'checkbox', 'switch'].includes(f.formType || '')) return
    if (!f.formConfig) return
    if (['select', 'radio', 'checkbox'].includes(f.formType || '') && f.formConfig.dataValueType === undefined) {
      f.formConfig.dataValueType = inferOptionDataValueType(f.formConfig.data)
    }
    if (f.formType === 'switch' && f.formConfig.useCustomSwitchValue === undefined) {
      f.formConfig.useCustomSwitchValue = isSwitchCustomValueEnabled(f.formConfig)
    }
    if (f.formType === 'switch' && f.formConfig.switchValueType === undefined) {
      f.formConfig.switchValueType = inferSwitchValueType(f.formConfig)
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

watch(
  () => props.selectedField?.formConfig?.useCustomSwitchValue,
  (enabled) => {
    const cfg = props.selectedField?.formConfig
    if (!cfg || enabled !== true) return
    if (cfg.switchValueType === undefined) {
      cfg.switchValueType = inferSwitchValueType(cfg)
    }
  },
)

watch(
  () => props.selectedField?.formConfig?.switchValueType,
  (next, prev) => {
    const cfg = props.selectedField?.formConfig
    if (!cfg) return
    if (next !== 'string' && next !== 'number' && next !== 'boolean') return
    if (prev === undefined && next === undefined) return
    if (next === prev) return
    if (!isSwitchCustomValueEnabled(cfg)) return
    coerceSwitchValues(cfg)
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
  return { [f.key]: buildFieldSpec(f) }
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
  <div class="right-panel w-72 bg-[var(--el-bg-color)] border-l border-[var(--el-border-color)] flex flex-col overflow-hidden flex-shrink-0">
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
          <div class="flex items-center gap-2 p-2 rounded-lg bg-[var(--el-color-primary-light-9)]">
            <span
              class="w-8 h-8 rounded-md flex items-center justify-center text-white text-xs font-bold"
              :style="{ backgroundColor: selectedPrimaryTypeDef?.color || 'var(--el-color-primary)' }"
            >{{ selectedPrimaryTypeDef?.icon }}</span>
            <div>
              <p class="font-semibold text-gray-700">{{ selectedBsonTypeLabel }}</p>
              <p class="text-xs text-gray-400">{{ selectedBsonTypeDesc }}</p>
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
            <div class="field-item">
              <label class="field-label">BSON 类型</label>
              <el-select
                v-model="bsonTypeModel"
                multiple
                class="w-full"
                clearable
                placeholder="请选择 BSON 类型"
              >
                <el-option
                  v-for="typeDef in TYPE_DEFS"
                  :key="typeDef.bsonType"
                  :label="typeDef.label"
                  :value="typeDef.bsonType"
                >
                  <div class="flex items-center justify-between gap-2">
                    <span>{{ typeDef.label }}</span>
                    <span class="text-xs text-gray-400">{{ typeDef.desc }}</span>
                  </div>
                </el-option>
              </el-select>
              <p class="text-xs text-gray-400 mt-1">可同时选择多个类型，生成如 <code class="bg-[var(--el-fill-color-light)] px-1 rounded">bsonType: ['string', 'array']</code></p>
            </div>
            <div class="field-item flex items-center">
              <label class="field-label mb-0">必填</label>
              <div class="flex-1 flex items-center gap-2">
                <el-switch v-model="selectedField.required" />
                <span class="text-xs text-gray-400">{{ selectedField.required ? '该字段必须存在' : '该字段可选' }}</span>
              </div>
            </div>
          </div>

          <div v-for="section in selectedRuleSections" :key="section.type" class="section">
            <p class="section-title">{{ section.def.label }} 约束</p>
            <div v-if="supportsStringRule(section.type)" class="flex flex-col gap-2">
              <div class="field-item">
                <label class="field-label">minLength</label>
                <el-input-number v-model="section.rule.minLength" :min="0" class="w-full" placeholder="最小长度" controls-position="right" />
              </div>
              <div class="field-item">
                <label class="field-label">maxLength</label>
                <el-input-number v-model="section.rule.maxLength" :min="0" class="w-full" placeholder="最大长度" controls-position="right" />
              </div>
              <div class="field-item">
                <label class="field-label">pattern</label>
                <el-input v-model="section.rule.pattern" placeholder="正则表达式，如 ^[a-z]+$" />
                <p class="text-xs text-gray-400 mt-1">值须匹配此正则</p>
              </div>
            </div>
            <div v-if="supportsNumericRule(section.type)" class="flex flex-col gap-2">
              <div class="field-item">
                <label class="field-label">minimum</label>
                <el-input-number v-model="section.rule.minimum" class="w-full" placeholder="最小值" controls-position="right" />
              </div>
              <div class="field-item">
                <label class="field-label">maximum</label>
                <el-input-number v-model="section.rule.maximum" class="w-full" placeholder="最大值" controls-position="right" />
              </div>
            </div>
            <p v-if="getBsonTypeList(selectedField.bsonType).length > 1" class="text-xs text-gray-400">
              多类型字段将生成 <code class="bg-[var(--el-fill-color-light)] px-1 rounded">anyOf</code>，当前规则只作用于 {{ section.def.label }}。
            </p>
          </div>

          <div class="section">
            <p class="section-title">当前字段 Schema</p>
            <pre class="text-xs bg-[var(--el-fill-color-extra-light)] border border-[var(--el-border-color-lighter)] rounded-lg p-2 overflow-x-auto leading-relaxed text-[var(--el-text-color-regular)]">{{ JSON.stringify(fieldSchemaPreview, null, 2) }}</pre>
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
            <el-button text :icon="ArrowLeft" @click="backToSelect" class="!px-1 text-[var(--el-text-color-secondary)] hover:!text-[var(--el-color-primary)]">返回</el-button>
            <span class="px-2 py-0.5 rounded-full text-xs text-white bg-[var(--el-color-primary)] font-medium">{{ formTypeLabel }}</span>
          </div>

          <div v-if="detailConfigFields.length" class="flex flex-col gap-3">
            <div v-for="cf in detailConfigFields" :key="cf.key" class="field-item" @click="ensureFormConfig()">
              <template v-if="isConfigFieldVisible(cf)">
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
              </template>
            </div>
          </div>
          <div v-else class="text-center text-gray-400 py-4 text-xs">
            该类型无需配置
          </div>

          <div class="pt-3 border-t border-[var(--el-border-color-lighter)]">
            <el-button type="danger" plain class="w-full" @click="clearFormType">
              清除表单类型
            </el-button>
          </div>
        </div>

        <!-- ── 选择视图：类型网格 ── -->
        <div v-else class="p-4 flex flex-col gap-3 text-sm">
          <div class="flex items-center gap-2 p-2 rounded-lg bg-[var(--el-fill-color-light)] border border-[var(--el-border-color-lighter)]">
            <span class="text-xs text-gray-400">当前字段:</span>
            <span class="font-medium text-gray-700">{{ selectedField.key || '(未命名)' }}</span>
            <span v-if="selectedField.formType" class="ml-auto px-2 py-0.5 rounded-full text-xs text-white bg-[var(--el-color-primary)]">{{ selectedField.formType }}</span>
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
                  ? 'border-[var(--el-color-primary)] bg-[var(--el-color-primary-light-9)] text-[var(--el-color-primary)] shadow-sm'
                  : 'border-[var(--el-border-color)] bg-[var(--el-bg-color)] text-[var(--el-text-color-regular)] hover:border-[var(--el-color-primary-light-5)] hover:bg-[var(--el-color-primary-light-9)]'"
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
  background: var(--el-fill-color-darker);
  border-radius: 4px;
}

.right-tabs {
  flex-shrink: 0;
}
:deep(.right-tabs .el-tabs__header) {
  margin: 0;
  border-bottom: 1px solid var(--el-border-color-lighter);
}
:deep(.right-tabs .el-tabs__nav-wrap::after) {
  display: none;
}
:deep(.right-tabs .el-tabs__item) {
  font-size: 12px;
  height: 36px;
  line-height: 36px;
  font-weight: 600;
  color: var(--el-text-color-secondary);
  letter-spacing: 0.03em;
}
:deep(.right-tabs .el-tabs__item.is-active) {
  color: var(--el-color-primary);
}

.section {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}
.section-title {
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--el-text-color-secondary);
  text-transform: uppercase;
  letter-spacing: 0.05em;
  padding-bottom: 0.25rem;
  border-bottom: 1px solid var(--el-border-color-lighter);
}
.field-item {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}
.field-label {
  font-size: 0.75rem;
  color: var(--el-text-color-regular);
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
