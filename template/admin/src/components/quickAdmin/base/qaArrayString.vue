<template>
  <div class="flex flex-col gap-[12px] w-full">
    <el-input
      v-for="(item, index) in list"
      :key="index"
      :model-value="item"
      @update:model-value="(v) => update(index, v)"
    >
      <template #append>
        <el-button :icon="Delete" @click="remove(index)" />
      </template>
    </el-input>

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
    modelValue?: string[]
  }>(),
  {
    modelValue: () => [],
  }
)

const emit = defineEmits<{
  (e: 'update:modelValue', val: string[]): void
}>()

const list = computed<string[]>(() =>
  Array.isArray(props.modelValue) ? props.modelValue : []
)

const update = (i: number, v: string | undefined) => {
  const arr = [...list.value]
  arr[i] = v ?? ''
  emit('update:modelValue', arr)
}

const remove = (i: number) =>
  emit('update:modelValue', list.value.filter((_, idx) => idx !== i))

const add = () => emit('update:modelValue', [...list.value, ''])

const clear = () => emit('update:modelValue', [])
</script>
