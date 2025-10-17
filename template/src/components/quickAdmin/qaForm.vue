<template>
    <div>
        <el-form :model="internalModel">
            <el-form-item v-for="item in columns" :prop="item.key" :label="item.title">
                <qa-form-item :modelValue="internalModel[item.key]" @update:modelValue="handleItemUpdate(item.key, $event)" :itemKey="item.key" v-bind="item"></qa-form-item>
            </el-form-item>
        </el-form>
    </div>
</template>

<script setup lang="ts">
import qaFormItem from './qaFormItem.vue';
interface QaFormItem {
    key: string
    title: string
    type?: 'text' | 'textarea' | 'date'
    width?: number
    placeholder?: string
    tips?: string
    labelWidth?: string | number
    showLabel?: boolean
    show?: boolean
    showRule?: boolean
    disabled?: boolean
    watch?: (res: any) => void
}

const props = withDefaults(
    defineProps<{
        modelValue: any
        rules: any
        action: string
        formType: string
        columns: QaFormItem[]
        labelWidth: string | number,
    }>(),
    {
    }
)

const internalModel = reactive({ ...props.modelValue })
const emit = defineEmits(['success','update:modelValue'])

function handleItemUpdate(key: string, value: any) {
  internalModel[key] = value
  emit('update:modelValue', { ...internalModel })
}

</script>

<style scoped></style>