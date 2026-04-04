<template>
  <div class="flex flex-col gap-[12px] w-full">
    <!-- 空列表也渲染表头，否则嵌套子表无列名、易被误认为「控件没渲染」 -->
    <el-table :data="list" border class="w-full qa-array-object-table" resizable>
      <el-table-column type="index" label="序号" width="60" align="center" />

      <el-table-column
        v-for="col in columns"
        :key="String(col.key)"
        :label="col.title"
        :width="tableColWidth(col)"
        :min-width="col.minWidth"
        :align="col.align ?? 'left'"
      >
        <template #default="{ $index }">
          <div class="min-w-0 w-full max-w-full py-[14px]">
            <qa-form-item
              :key="String(col.key) + '-' + $index"
              v-model="rootProxy"
              v-bind="columnFormBind(col, $index)"
            />
          </div>
        </template>
      </el-table-column>

      <el-table-column
        v-if="hasRowActions"
        label="操作"
        align="center"
        min-width="198"
      >
        <template #default="{ $index }">
          <div class="flex flex-wrap gap-x-[12px] gap-y-[4px] justify-center items-center text-sm">
            <span
              v-if="rightBtnList.includes('copy')"
              class="cursor-pointer select-none text-[var(--el-color-primary)] hover:opacity-80"
              @click="copyRow($index)"
            >
              复制
            </span>
            <span
              v-if="showSort && $index > 0"
              class="cursor-pointer select-none text-[var(--el-color-primary)] hover:opacity-80"
              @click="moveRow($index, -1)"
            >
              上移
            </span>
            <span
              v-if="showSort && $index < list.length - 1"
              class="cursor-pointer select-none text-[var(--el-color-primary)] hover:opacity-80"
              @click="moveRow($index, 1)"
            >
              下移
            </span>
            <span
              v-if="rightBtnList.includes('delete')"
              class="cursor-pointer select-none text-[var(--el-color-primary)] hover:opacity-80"
              @click="removeRow($index)"
            >
              删除
            </span>
          </div>
        </template>
      </el-table-column>

      <template #empty>
        <span
          v-if="showAdd"
          class="cursor-pointer select-none text-[var(--el-color-primary)] hover:opacity-80 py-[12px] inline-block text-sm"
          @click="addRow"
        >
          新增一行
        </span>
      </template>
    </el-table>

    <div class="flex gap-[12px]">
      <el-button v-if="showAdd" plain :icon="Plus" @click="addRow">添加</el-button>
      <el-popconfirm v-if="showClear && list.length > 0" title="确定清空？" @confirm="clearAll">
        <template #reference>
          <el-button type="danger" plain>清空</el-button>
        </template>
      </el-popconfirm>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Plus } from '@element-plus/icons-vue'
import type { Columns } from '../table/qaTable.vue'
import { cloneDeep } from '@/utils'

/** 与 qaFormItem 一致：支持 fieldKey 为点路径（如 array.0.nested） */
function getByPath(obj: Record<string, any> | undefined, path: string): any {
  if (!obj || path == null || path === '') return undefined
  if (!path.includes('.')) return obj[path]
  return path.split('.').reduce((o: any, k) => (o == null ? undefined : o[k]), obj)
}

function setByPathImmutable(root: Record<string, any>, path: string, value: any): Record<string, any> {
  const parts = path.split('.').filter(Boolean)
  if (parts.length === 0) return { ...root }

  const walk = (node: any, i: number): any => {
    const key = parts[i]
    const isLast = i === parts.length - 1
    if (isLast) {
      if (Array.isArray(node)) {
        const idx = Number(key)
        const next = [...node]
        next[idx] = value
        return next
      }
      return { ...node, [key]: value }
    }
    const child = Array.isArray(node) ? node[Number(key)] : node?.[key]
    const nextSeg = parts[i + 1]
    const emptyChild = nextSeg !== undefined && /^\d+$/.test(nextSeg) ? [] : {}
    const clonedChild = walk(child ?? emptyChild, i + 1)
    if (Array.isArray(node)) {
      const idx = Number(key)
      const next = [...node]
      next[idx] = clonedChild
      return next
    }
    return { ...node, [key]: clonedChild }
  }

  return walk(root, 0) as Record<string, any>
}

const props = withDefaults(
  defineProps<{
    rootModel: Record<string, any>
    fieldKey: string
    columns: Columns[]
    defaultRow?: Record<string, any>
    showAdd?: boolean
    showClear?: boolean
    showSort?: boolean
    rightBtns?: string[]
    itemWidth?: string | number
    disabled?: boolean
    formType?: string
    nestedLabelWidth?: string | number
  }>(),
  {
    rootModel: () => ({}),
    columns: () => [],
    defaultRow: () => ({}),
    showAdd: true,
    showClear: false,
    showSort: false,
    rightBtns: () => ['delete'],
    nestedLabelWidth: '80px',
  }
)

const emit = defineEmits<{
  (e: 'update:rootModel', val: Record<string, any>): void
}>()

const list = computed<any[]>(() => {
  const v = getByPath(props.rootModel, props.fieldKey)
  return Array.isArray(v) ? v : []
})

const rightBtnList = computed(() => props.rightBtns ?? ['delete'])

const hasRowActions = computed(
  () => props.showSort || (rightBtnList.value?.length ?? 0) > 0,
)

function tableColWidth(col: Columns) {
  const w = col.width ?? props.itemWidth
  return w === undefined || w === '' ? undefined : w
}

const rootProxy = computed({
  get: () => props.rootModel,
  set: (v) => emit('update:rootModel', v),
})

const fieldPath = (rowIndex: number, colKey: string) =>
  `${props.fieldKey}.${rowIndex}.${colKey}`

const patchRows = (rows: any[]) => {
  const base = props.rootModel ?? {}
  if (props.fieldKey.includes('.')) {
    emit('update:rootModel', setByPathImmutable(base, props.fieldKey, rows))
    return
  }
  emit('update:rootModel', { ...base, [props.fieldKey]: rows })
}

const addRow = () => {
  patchRows([...list.value, cloneDeep(props.defaultRow ?? {})])
}

const removeRow = (i: number) => {
  patchRows(list.value.filter((_, idx) => idx !== i))
}

const clearAll = () => {
  patchRows([])
}

const copyRow = (i: number) => {
  const rows = [...list.value]
  rows.splice(i + 1, 0, cloneDeep(rows[i]))
  patchRows(rows)
}

const moveRow = (i: number, delta: number) => {
  const j = i + delta
  if (j < 0 || j >= list.value.length) return
  const rows = [...list.value]
  ;[rows[i], rows[j]] = [rows[j], rows[i]]
  patchRows(rows)
}

const isCellDisabled = (col: Columns & { disabled?: any }) => {
  if (props.disabled) return true
  return col.disabled
}

/** 传给 qa-form-item：去掉 key，补上 itemKey；watch 包装成 payload，避免 watchContext 每次渲染新对象 */
function columnFormBind(col: Columns, index: number) {
  const {
    key,
    title,
    watch: colWatch,
    rules,
    width,
    /** Columns 里为 boolean 标记列，与 qa-form-item 的 string 型 nameKey/idKey 语义不同，勿透传 */
    nameKey: _colNameKey,
    idKey: _colIdKey,
    /** Columns 为 string|number；qa-form-item 为嵌套 array<object> 的 Record，同名不同义 */
    defaultValue: _colDefaultValue,
    ...rest
  } = col as Columns & Record<string, any>
  const wrappedWatch = colWatch
    ? (val: any) => {
        colWatch({
          value: val,
          column: col,
          formData: list.value[index],
          index,
          $set: (k: string, v: any) => {
            const rows = [...list.value]
            const cur = rows[index]?.[k]
            if (Object.is(cur, v)) return
            rows[index] = { ...rows[index], [k]: v }
            patchRows(rows)
          },
        })
      }
    : undefined
  return {
    ...rest,
    itemKey: fieldPath(index, String(key)),
    label: title,
    title,
    width: width ?? props.itemWidth,
    watch: wrappedWatch,
    disabled: isCellDisabled(col as Columns & { disabled?: any }),
    rules,
    formType: props.formType,
    labelWidth: props.nestedLabelWidth,
    /** 表头已展示列名，单元格内不再重复 label，避免嵌套表格里把输入区挤没 */
    showLabel: false,
  }
}
</script>

<style scoped>
/* 表格单元格默认 overflow:hidden + 校验信息绝对定位，会导致 rule 文案被裁切；预留底部空间保证行高能包住输入框与错误提示 */
/* 行内垂直居中：与整行最高单元格对齐时，较矮列的控件落在行中间（非 top） */
.qa-array-object-table :deep(.el-table__cell) {
  vertical-align: middle;
}

.qa-array-object-table :deep(.cell) {
  overflow: visible;
}

.qa-array-object-table :deep(.el-form-item__content) {
  align-items: flex-start;
}

/* 列宽有限时让表单项与控件随单元格收缩，避免 input 撑出 cell（保留 .cell overflow:visible 以显示校验文案） */
.qa-array-object-table :deep(.el-form-item) {
  width: 100%;
  max-width: 100%;
  min-width: 0;
  margin-bottom: 0;
}

.qa-array-object-table :deep(.el-form-item__content) {
  width: 100%;
  max-width: 100%;
  min-width: 0;
}

.qa-array-object-table :deep(.el-form-item__content > .w-full) {
  min-width: 0;
  max-width: 100%;
}

.qa-array-object-table :deep(.el-input),
.qa-array-object-table :deep(.el-input-number),
.qa-array-object-table :deep(.el-select),
.qa-array-object-table :deep(.el-cascader),
.qa-array-object-table :deep(.el-date-editor),
.qa-array-object-table :deep(.el-time-picker),
.qa-array-object-table :deep(.el-textarea) {
  width: 100% !important;
  max-width: 100%;
  min-width: 0;
  box-sizing: border-box;
}
</style>
