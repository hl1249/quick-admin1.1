<template>
    <div>
        <el-form :rules="rules" ref="ruleFormRef" :model="model" :label-width="labelWidth">
            <qa-form-item v-model="model" v-for="item in columns"
                v-bind="{ ...item, key: item.key, itemKey: item.key, label: item.title }" :form-type="formType">
                <template v-if="$slots[item.key]" #default>
                    <slot :form="model" :keyName="item.key" :name="item.key" />
                </template>
            </qa-form-item>
            <!-- ✅ 外层用 template 包裹，v-if/v-else 才算同级 -->
            <template v-if="!$slots.footer">
                <el-form-item>
                    <el-button type="primary" @click="submitForm(ruleFormRef)">
                        提交:resetCache:{{ resetCache }}
                    </el-button>
                    <el-button @click="resetFormDataDefault(ruleFormRef)">
                        重置:model:{{ model }}
                    </el-button>
                </el-form-item>
            </template>

            <template v-else>
                <slot name="footer" :loading="loading" />
            </template>
        </el-form>
    </div>
</template>

<script setup lang="ts">
import { ElMessage, type FormInstance } from 'element-plus'
import { useVModel } from "@vueuse/core"
import { cloneDeep } from '@/utils'
import qaFormItem from './qaFormItems.vue';
import http from '@/utils/axios'
const emit = defineEmits(["update:modelValue", "success"])

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
        beforeAction: (value: any) => boolean | void
    }>(),
    {
    }
)
// 通过 useVModel 直接拿到响应式 formData（相当于 computed + emit）
const model = useVModel(props, "modelValue", emit)

// 存放重置时的默认值
const resetCache = ref(cloneDeep(model.value))


const loading = ref(false)
const ruleFormRef = ref<FormInstance>()
const submitForm = async (formEl: FormInstance | undefined) => {
    if (!formEl) return

    console.log('当前表单数据:', JSON.parse(JSON.stringify(model.value)))
    console.log('表单规则:', props.rules)
    await formEl.validate(async (valid, fields) => {
        if (valid) {
            loading.value = true

            let postData = model.value

            if (props.beforeAction(model.value) === false) {
                return
            }

            if (props.beforeAction(model.value)) {
                postData = props.beforeAction(model.value) === true ? model.value : props.beforeAction(model.value)
            }

            try {
                const res = await http.request({
                    url: props.action,
                    method: 'post',
                    data: postData,
                })
            } catch (error) {

            } finally {
                loading.value = false
            }
            ElMessage.success("提交成功!")
            emit('success')

            console.log('submit!')
        } else {
            console.log('error submit!', fields)
        }
    })
}

const beforeSubmitForm = async ({data,success,fail}: {
  data: any
  success: (result:any) => void
  fail: (error:any) => void
}) =>{
    
}


// 完全重置表单
const resetForm = (formEl: FormInstance | undefined) => {
    if (!formEl) return
    formEl.resetFields()
    formEl.clearValidate()
}

// 设置新的默认重置值
function setResetFormData(data?: Partial<typeof model>) {
    if (data) {
        Object.assign(model.value, data)
    }
    // 更新重置缓存
    resetCache.value = cloneDeep(model.value)
}

// 重置表单验证 但是有默认值
const resetFormDataDefault = (formEl: FormInstance | undefined) => {
    if (!formEl) return
    formEl.resetFields()
    formEl.clearValidate()
    console.log('model', model, cloneDeep(resetCache.value))
    Object.assign(model.value, cloneDeep(resetCache.value))
}


defineExpose({
    validate: (...args: any[]) => ruleFormRef.value?.validate?.(...args),
    validateField: (...args: any[]) => ruleFormRef.value?.validateField?.(...args),
    // resetFields: async (...args: any[]) => {
    //     await nextTick() // 确认组件已经渲染完成
    //     ruleFormRef.value?.resetFields?.(...args)
    // },
    resetForm: async () => {
        await nextTick() // 确认组件已经渲染完成
        resetForm(ruleFormRef.value)
    },
    clearValidate: (...args: any[]) => ruleFormRef.value?.clearValidate?.(...args),
    submitForm: () => submitForm(ruleFormRef.value),
    setResetFormData: (data: any) => setResetFormData(data),
    resetFormDataDefault: async () => {
        await nextTick()
        resetFormDataDefault(ruleFormRef.value)
    }
})

</script>

<style scoped></style>