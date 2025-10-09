<template>
    <div>
        <el-form :rules="rules" ref="ruleFormRef" :model="model" :label-width="labelWidth" >
            <qa-form-item v-model="model" v-for="item in columns"
                v-bind="{ ...item, key: item.key, itemKey: item.key, label: item.title }"></qa-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm(ruleFormRef)">
                    提交
                </el-button>
                <el-button @click="resetForm(ruleFormRef)">Reset</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script setup lang="ts">
import qaFormItem from './qaFormItems.vue';
import { ElMessage, type FormInstance } from 'element-plus'
import { useVModel } from "@vueuse/core"
const emit = defineEmits(["update:modelValue","success"])

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
// 通过 useVModel 直接拿到响应式 formData（相当于 computed + emit）
const model = useVModel(props, "modelValue", emit)


import http from '@/utils/axios'
const ruleFormRef = ref<FormInstance>()
const submitForm = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate(async(valid, fields) => {
        if (valid) {

            const res = await http.request({
                url: props.action,
                method: 'post',
                data: model.value,
            })

            ElMessage.success("提交成功!")
            emit('success')

            console.log('submit!')
        } else {
            console.log('error submit!', fields)
        }
    })
}

const resetForm = (formEl: FormInstance | undefined) => {
    if (!formEl) return
    formEl.resetFields()
}

</script>

<style scoped></style>