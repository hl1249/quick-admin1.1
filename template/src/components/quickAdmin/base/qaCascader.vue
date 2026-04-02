<template>
  <el-cascader
    v-model="currentValue"
    :options="isLazy ? undefined : list"
    :props="cascaderProps"
    :loading="loading"
    :style="{ width }"
    v-bind="$attrs"
  />
</template>

<script setup lang="ts">
import http from '@/utils/axios'

interface CascaderProps {
  value?: string
  label?: string
  children?: string
  list?: string
  lazy?: boolean
  multiple?: boolean
  [key: string]: any
}

const props = withDefaults(
  defineProps<{
    modelValue?: any
    /** 静态数据：数组或返回数组的函数 */
    data?: any[] | (() => any[])
    /** 远程请求地址 */
    action?: string
    /** 请求参数：对象或返回对象的函数 */
    actionData?: Record<string, any> | (() => Record<string, any>)
    /** el-cascader props 配置（含 lazy / multiple 等） */
    props?: CascaderProps
    /** 组件宽度 */
    width?: string
  }>(),
  {
    width: '100%',
  }
)

const emit = defineEmits<{
  (e: 'update:modelValue', val: any): void
}>()

const currentValue = computed({
  get: () => props.modelValue,
  set: (v) => emit('update:modelValue', v),
})

/* ---------- 是否懒加载 ---------- */
const isLazy = computed(() => !!props.props?.lazy && !!props.action)

/* ---------- 解析 actionData ---------- */
const resolveActionData = (): Record<string, any> | undefined => {
  if (typeof props.actionData === 'function') {
    return (props.actionData as () => Record<string, any>)()
  }
  return props.actionData
}

/* ---------- 懒加载函数 ---------- */
const lazyLoad = (node: any, resolve: (data: any[]) => void) => {
  const { value, level } = node
  http
    .request({
      method: 'POST',
      url: props.action!,
      data: { ...resolveActionData(), node_value: value, level },
    })
    .then((res) => {
      const listKey = props.props?.list
      const options = listKey
        ? res.data?.data?.[listKey] ?? []
        : res.data?.data ?? []
      resolve(Array.isArray(options) ? options : [])
    })
}

/* ---------- cascaderProps 合并 lazyLoad ---------- */
const cascaderProps = computed(() => {
  if (!isLazy.value) return props.props
  return { ...props.props, lazyLoad }
})

/* ---------- 列表数据 ---------- */
const list = ref<any[]>([])
const loading = ref(false)

const loadOptions = async () => {
  // 懒加载模式不预加载
  if (isLazy.value) return

  if (!props.action) {
    // 静态数据
    const src = props.data
    list.value = typeof src === 'function' ? (src as () => any[])() : (src ?? [])
    return
  }

  // 远程加载
  loading.value = true
  try {
    const res = await http.request({
      method: 'POST',
      url: props.action,
      data: resolveActionData(),
    })
    const listKey = props.props?.list
    const options = listKey
      ? res.data?.data?.[listKey] ?? []
      : res.data?.data ?? []
    list.value = Array.isArray(options) ? options : []
  } finally {
    loading.value = false
  }
}

/* ---------- 监听关键 props 变化自动重载 ---------- */
const watchKey = computed(() =>
  JSON.stringify({
    action: props.action ?? '',
    propsConfig: props.props ?? null,
  })
)

watch(watchKey, () => void loadOptions(), { immediate: true })

defineExpose({ reload: loadOptions })
</script>
