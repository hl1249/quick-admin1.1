<template>
  <el-select
    v-model="currentValue"
    :loading="loading"
    :style="{ width }"
    :filterable="filterable"
    :remote="filterable"
    clearable
    :remote-method="filterable ? handleRemoteSearch : undefined"
  >
    <el-option
      v-for="item in optionList"
      :key="String(item.key)"
      :value="item.value"
      :label="item.label"
    >
      {{ item.label }}
    </el-option>
  </el-select>
</template>

<script setup lang="ts">
import { computed, onUnmounted, ref, watch } from 'vue'
import http from '@/utils/axios'

interface FieldProps {
  value?: string
  label?: string
  list?: string
  [key: string]: any
}

const props = withDefaults(
  defineProps<{
    modelValue?: any
    action?: string
    actionData?: Record<string, any> | (() => Record<string, any>)
    props?: FieldProps
    filterable?: boolean
    width?: string
    /** 表单场景下类型变化时重新拉取（如弹窗每次打开） */
    formType?: string
  }>(),
  {
    width: '100%',
    filterable: false,
  }
)

const emit = defineEmits<{
  (e: 'update:modelValue', val: any): void
}>()

const currentValue = computed({
  get: () => props.modelValue,
  set: (v) => emit('update:modelValue', v),
})

const resolveActionData = (): Record<string, any> | undefined => {
  if (typeof props.actionData === 'function') {
    return (props.actionData as () => Record<string, any>)()
  }
  return props.actionData
}

const getByPath = (obj: any, path: string) =>
  path.split('.').reduce((cur, key) => cur?.[key], obj)

const optionList = ref<{ key: any; label: any; value: any }[]>([])
const loading = ref(false)

const requestKey = computed(() =>
  JSON.stringify({
    action: props.action ?? '',
    actionData: resolveActionData() ?? null,
    itemProps: props.props ?? null,
  })
)

const loadOptions = async (searchValue?: string) => {
  if (!props.action) {
    optionList.value = []
    return
  }

  loading.value = true
  try {
    const base = resolveActionData()
    const data =
      searchValue != null && searchValue !== ''
        ? { searchValue, ...base }
        : base

    const res = await http.request({
      method: 'POST',
      url: props.action,
      data,
    })
    const responseData = res.data?.data
    const listKey = props.props?.list ?? 'rows'
    const valueKey = props.props?.value ?? 'value'
    const labelKey = props.props?.label ?? 'label'
    const options = Array.isArray(responseData)
      ? responseData
      : responseData?.[listKey] ?? []

    optionList.value = Array.isArray(options)
      ? options.map((item: any) => ({
          key: getByPath(item, valueKey),
          label: getByPath(item, labelKey),
          value: getByPath(item, valueKey),
        }))
      : []
  } finally {
    loading.value = false
  }
}

watch(requestKey, () => {
  void loadOptions()
}, { immediate: true })

watch(() => props.formType, () => {
  void loadOptions()
})

let remoteSearchTimer: ReturnType<typeof setTimeout> | null = null
const handleRemoteSearch = (query: string) => {
  if (remoteSearchTimer) clearTimeout(remoteSearchTimer)
  if (!query.trim()) return
  remoteSearchTimer = setTimeout(() => {
    void loadOptions(query)
  }, 1000)
}

onUnmounted(() => {
  if (remoteSearchTimer) clearTimeout(remoteSearchTimer)
})
</script>
