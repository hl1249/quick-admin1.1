<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import http from '@/utils/axios'

type RouteItem = {
  path: string
  controller: string
  file: string
}

type RouteTreeNode = {
  controller: string
  controllerPath: string
  file: string
  routes: RouteItem[]
}

type RouteOption = {
  value: string
  label: string
  disabled?: boolean
  children?: RouteOption[]
}

const props = withDefaults(defineProps<{
  modelValue?: string
  placeholder?: string
  manualPlaceholder?: string
}>(), {
  placeholder: '请选择接口地址',
  manualPlaceholder: '也可手动输入接口地址',
})

const emit = defineEmits<{
  'update:modelValue': [value: string]
}>()

const loading = ref(false)
const routeOptions = ref<RouteOption[]>([])

const currentValue = computed({
  get: () => props.modelValue ?? '',
  set: (value: string | number | null | undefined) => emit('update:modelValue', `${value ?? ''}`),
})

const treeProps = {
  value: 'value',
  label: 'label',
  children: 'children',
  disabled: 'disabled',
}

function buildRouteOptions(tree: RouteTreeNode[]): RouteOption[] {
  return tree
    .map((node) => {
      const children = Array.isArray(node.routes)
        ? node.routes.map(route => ({
            value: route.path,
            label: route.path,
          }))
        : []

      return {
        value: node.controllerPath || node.controller,
        label: node.controllerPath
          ? `${node.controller}`
          : node.controller,
        disabled: true,
        children,
      }
    })
    .filter(option => option.children?.length)
}

async function loadRouteOptions() {
  loading.value = true
  try {
    const res = await http.request({
      method: 'POST',
      url: '/app/admin/dev/databaseDesign/databaseDesign/getRouter',
      openMessage: false,
    })
    const tree = res.data?.data?.tree ?? res.data?.tree ?? []
    routeOptions.value = Array.isArray(tree) ? buildRouteOptions(tree as RouteTreeNode[]) : []
  } catch {
    routeOptions.value = []
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  void loadRouteOptions()
})
</script>

<template>
  <div class="flex flex-col gap-2">
    <el-tree-select
      v-model="currentValue"
      :data="routeOptions"
      :props="treeProps"
      :placeholder="placeholder"
      node-key="value"
      clearable
      filterable
      default-expand-all
      check-strictly
      class="w-full"
    />
    <el-input
      v-model="currentValue"
      :placeholder="manualPlaceholder"
      clearable
    />
    <p class="text-xs text-[var(--el-text-color-secondary)]">
      {{ loading ? '正在加载系统路由...' : '可在树中直接选择接口叶子节点，也支持手动填写。' }}
    </p>
  </div>
</template>
