<template>
    <div>
        <el-form>
            <qa-form-item v-for="item in columns" :label="item.title" 
            :type="item.type"
            :labelWidth="item.labelWidth"></qa-form-item>
        </el-form>
    </div>
</template>

<script setup lang="ts">
import qaFormItem from './qaFormItem.tsx';
interface QaFormColumns {
    key: string
    title: string
    type?: string
    labelWidth?: string | number,
    width?: string | number
    valueFormat?: string
    tips?: string
    dateType?: string
}
const props = withDefaults(
    defineProps<{
        modelValue: any
        rules: any
        action: string
        formType: string
        columns: QaFormColumns[]
        labelWidth: string | number,
    }>(),
    {
    }
)

const emit = defineEmits(['success'])
</script>

<style scoped></style>