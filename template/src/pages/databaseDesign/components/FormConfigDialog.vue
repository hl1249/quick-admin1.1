<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import {
  FORM_TYPE_CONFIG,
  coerceSwitchValues,
  coerceOptionDataValues,
  getOptionDataValueType,
  inferOptionDataValueType,
  inferSwitchValueType,
  isSwitchCustomValueEnabled,
  type ConfigField,
  type FieldDef,
} from '../types'
import RouteActionSelect from './RouteActionSelect.vue'
import ConfigObjectArrayEditor from './ConfigObjectArrayEditor.vue'

const props = defineProps<{
  selectedField: FieldDef | null
}>()

const emit = defineEmits<{
  saved: []
}>()

const showDialog = ref(false)
const configFormType = ref('')
const configFormLabel = ref('')
const tempFormConfig = ref<Record<string, any>>({})

const currentConfigFields = computed(() => FORM_TYPE_CONFIG[configFormType.value] ?? [])
const dialogWidth = computed(() => configFormType.value === 'table-select' ? 920 : 520)

function isConfigFieldVisible(cf: ConfigField): boolean {
  if (!cf.visibleWhen) return true
  return tempFormConfig.value?.[cf.visibleWhen.key] === cf.visibleWhen.value
}

function cloneValue<T>(value: T): T {
  if (value === undefined) return value
  return JSON.parse(JSON.stringify(value))
}

function open(ftValue: string, ftLabel: string) {
  const field = props.selectedField
  if (!field) return
  configFormType.value = ftValue
  configFormLabel.value = ftLabel
  const cfgFields = FORM_TYPE_CONFIG[ftValue] ?? []
  if (cfgFields.length === 0) {
    field.formType = ftValue
    field.formConfig = undefined
    emit('saved')
    return
  }
  const isReedit = field.formType === ftValue
  tempFormConfig.value = isReedit ? cloneValue(field.formConfig ?? {}) : {}
  cfgFields.forEach(cf => {
    if (tempFormConfig.value[cf.key] === undefined && cf.default !== undefined) {
      tempFormConfig.value[cf.key] = cloneValue(cf.default)
    }
  })
  if (
    isReedit
    && field.formConfig?.dataValueType === undefined
    && Array.isArray(tempFormConfig.value.data)
    && tempFormConfig.value.data.length
  ) {
    tempFormConfig.value.dataValueType = inferOptionDataValueType(tempFormConfig.value.data)
  }
  if (isReedit && ftValue === 'switch' && tempFormConfig.value.switchValueType === undefined) {
    tempFormConfig.value.switchValueType = inferSwitchValueType(tempFormConfig.value)
  }
  if (isReedit && ftValue === 'switch' && tempFormConfig.value.useCustomSwitchValue === undefined) {
    tempFormConfig.value.useCustomSwitchValue = isSwitchCustomValueEnabled(tempFormConfig.value)
  }
  showDialog.value = true
}

function save() {
  const field = props.selectedField
  if (!field) return
  const vt = tempFormConfig.value.dataValueType
  if ((vt === 'number' || vt === 'string') && Array.isArray(tempFormConfig.value.data)) {
    coerceOptionDataValues(tempFormConfig.value.data, vt)
  }
  if (configFormType.value === 'switch' && isSwitchCustomValueEnabled(tempFormConfig.value)) {
    coerceSwitchValues(tempFormConfig.value)
  }
  field.formType = configFormType.value
  field.formConfig = cloneValue(tempFormConfig.value)
  showDialog.value = false
  emit('saved')
}

function cancel() {
  showDialog.value = false
}

function addOptionItem(listKey: string) {
  if (!tempFormConfig.value[listKey]) tempFormConfig.value[listKey] = []
  tempFormConfig.value[listKey].push({ value: '', label: '' })
}

function removeOptionItem(listKey: string, index: number) {
  tempFormConfig.value[listKey]?.splice(index, 1)
}

watch(
  () => tempFormConfig.value.dataValueType,
  (next, prev) => {
    if (prev === undefined || next === prev) return
    if (next !== 'string' && next !== 'number') return
    coerceOptionDataValues(tempFormConfig.value.data, next)
  },
)

watch(
  () => tempFormConfig.value.useCustomSwitchValue,
  (enabled) => {
    if (enabled !== true) return
    if (tempFormConfig.value.switchValueType === undefined) {
      tempFormConfig.value.switchValueType = inferSwitchValueType(tempFormConfig.value)
    }
  },
)

watch(
  () => tempFormConfig.value.switchValueType,
  (next, prev) => {
    if (prev === undefined || next === prev) return
    if (next !== 'string' && next !== 'number' && next !== 'boolean') return
    if (!isSwitchCustomValueEnabled(tempFormConfig.value)) return
    coerceSwitchValues(tempFormConfig.value)
  },
)

defineExpose({ open })
</script>

<template>
  <el-dialog
    v-model="showDialog"
    :title="`配置 - ${configFormLabel || configFormType}`"
    :width="dialogWidth"
    draggable
    destroy-on-close
  >
    <div v-if="currentConfigFields.length" class="flex flex-col gap-4">
      <div v-for="cf in currentConfigFields" :key="cf.key">
        <template v-if="isConfigFieldVisible(cf)">
        <div v-if="cf.type === 'route-select'" class="config-field">
          <label class="config-label">{{ cf.label }}</label>
          <RouteActionSelect
            v-model="tempFormConfig[cf.key]"
            :placeholder="cf.placeholder || '请选择接口地址'"
          />
          <p v-if="cf.tip" class="text-xs text-gray-400 mt-0.5">{{ cf.tip }}</p>
        </div>

        <div v-else-if="cf.type === 'text'" class="config-field">
          <label class="config-label">{{ cf.label }}</label>
          <el-input v-model="tempFormConfig[cf.key]" :placeholder="cf.placeholder || ''" clearable />
          <p v-if="cf.tip" class="text-xs text-gray-400 mt-0.5">{{ cf.tip }}</p>
        </div>

        <div v-else-if="cf.type === 'number'" class="config-field">
          <label class="config-label">{{ cf.label }}</label>
          <el-input-number v-model="tempFormConfig[cf.key]" class="w-full" controls-position="right" />
          <p v-if="cf.tip" class="text-xs text-gray-400 mt-0.5">{{ cf.tip }}</p>
        </div>

        <div v-else-if="cf.type === 'switch'" class="config-field flex-row items-center gap-3">
          <label class="config-label mb-0 flex-shrink-0">{{ cf.label }}</label>
          <el-switch v-model="tempFormConfig[cf.key]" />
          <p v-if="cf.tip" class="text-xs text-gray-400 ml-2">{{ cf.tip }}</p>
        </div>

        <div v-else-if="cf.type === 'select'" class="config-field">
          <label class="config-label">{{ cf.label }}</label>
          <el-select v-model="tempFormConfig[cf.key]" clearable class="w-full">
            <el-option v-for="opt in cf.options" :key="opt.value" :value="opt.value" :label="opt.label" />
          </el-select>
          <p v-if="cf.tip" class="text-xs text-gray-400 mt-0.5">{{ cf.tip }}</p>
        </div>

        <div v-else-if="cf.type === 'options-editor'" class="config-field">
          <label class="config-label">{{ cf.label }}</label>
          <p v-if="cf.tip" class="text-xs text-gray-400 mb-1">{{ cf.tip }}</p>
          <div class="flex flex-col gap-1.5">
            <div v-for="(item, idx) in (tempFormConfig[cf.key] ?? [])" :key="idx" class="flex items-center gap-2">
              <el-input
                v-model="item.value"
                class="flex-1"
                placeholder="value"
                :type="getOptionDataValueType(tempFormConfig) === 'number' ? 'number' : 'text'"
              />
              <el-input v-model="item.label" placeholder="label（可选）" class="flex-1" />
              <el-button type="danger" text @click="removeOptionItem(cf.key, Number(idx))">✕</el-button>
            </div>
          </div>
          <el-button type="primary" plain class="mt-2 w-full" @click="addOptionItem(cf.key)">
            + 添加选项
          </el-button>
        </div>

        <div v-else-if="cf.type === 'object-array-editor'" class="config-field">
          <label class="config-label">{{ cf.label }}</label>
          <p v-if="cf.tip" class="text-xs text-gray-400 mb-1">{{ cf.tip }}</p>
          <ConfigObjectArrayEditor
            :model-value="tempFormConfig[cf.key] ?? []"
            :item-fields="cf.itemFields"
            :add-text="cf.addText"
            @update:model-value="tempFormConfig[cf.key] = $event"
          />
        </div>
        </template>
      </div>
    </div>
    <div v-else class="text-center text-gray-400 py-6 text-sm">
      该表单类型无需额外配置
    </div>
    <template #footer>
      <el-button @click="cancel">取消</el-button>
      <el-button type="primary" @click="save">确定</el-button>
    </template>
  </el-dialog>
</template>

<style scoped>
.config-field {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}
.config-field.flex-row {
  flex-direction: row;
}
.config-label {
  font-size: 0.8rem;
  color: #374151;
  font-weight: 500;
  margin-bottom: 2px;
}

:deep(.el-input-number) {
  width: 100%;
}
:deep(.el-input-number .el-input__wrapper) {
  width: 100%;
}
</style>
