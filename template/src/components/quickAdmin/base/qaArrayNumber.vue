<template>
  <div class="flex flex-col gap-[12px] w-full">
    <div
      v-for="(item, index) in list"
      :key="index"
      class="flex items-center gap-[8px] w-full"
    >
      <el-input
        :model-value="item"
        controls-position="right"
        class="flex-1 min-w-0"
        clearable
        type="number"
        style="width: 100%"
        @update:model-value="(v) => update(index, v)"
      >
     
      <template #append>
        <el-button :icon="Delete" @click="remove(index)" />
      </template>
      </el-input>
    </div>

    <div class="flex gap-[12px]">
      <el-button plain :icon="Plus" @click="add">添加</el-button>
      <el-popconfirm v-if="list.length > 0" title="确定清空？" @confirm="clear">
        <template #reference>
          <el-button type="danger" plain>清空</el-button>
        </template>
      </el-popconfirm>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { RemoveFilled, Plus, Delete } from '@element-plus/icons-vue'

const props = withDefaults(
  defineProps<{
    modelValue?: (number | null)[]
  }>(),
  {
    modelValue: () => [],
  }
)

const emit = defineEmits<{
  (e: 'update:modelValue', val: (number | null)[]): void
}>()

const list = computed<(number | null)[]>(() =>
  Array.isArray(props.modelValue) ? props.modelValue : []
)

/** el-input 即 type="number" 仍以 string 形式回传 modelValue */
const update = (i: number, v: string | number | null | undefined) => {
  const arr = [...list.value]
  if (v === '' || v === undefined || v === null) {
    arr[i] = null
  } else {
    const n = typeof v === 'number' ? v : Number(v)
    arr[i] = Number.isFinite(n) ? n : null
  }
  emit('update:modelValue', arr)
}

const remove = (i: number) =>
  emit('update:modelValue', list.value.filter((_, idx) => idx !== i))

const add = () => emit('update:modelValue', [...list.value, null])

const clear = () => emit('update:modelValue', [])
</script>
