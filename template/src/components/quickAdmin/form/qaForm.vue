<template>
    <div>
        <el-form :rules="rules" ref="ruleFormRef" :model="model" :label-width="labelWidth">
            <qa-form-item v-for="item in columns" :key="item.key"
                v-model="model"
                v-bind="getFormItemBind(item)" :form-type="formType"
                @update:formData="(val) => { (item as any).formData = val }">

                <template v-if="$slots[item.key]" #default>
                    <slot :form="model" :keyName="item.key" :name="item.key" />
                </template>
            </qa-form-item>
            <!-- ✅ 外层用 template 包裹，v-if/v-else 才算同级 -->
            <template v-if="!$slots.footer">
                <div class="flex items-center justify-end" >
                    <!-- <el-button @click="resetFormDataDefault(ruleFormRef)">
                        重置
                    </el-button> -->
                    
                    <el-button @click="closeForm">
                        {{cancelText}}
                    </el-button>
                    <el-button type="primary" @click="submitForm(ruleFormRef)">
                        {{submitText}}
                    </el-button>
                </div>
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
import qaFormItem from './qaFormItem.vue';
import http from '@/utils/axios'
const emit = defineEmits(["update:modelValue", "success","closeForm"])

interface QaFormColumns {
    key: string
    title: string
    type?: string
    labelWidth?: string | number,
    width?: string | number
    activeValue?: boolean | string | number
    inactiveValue?: boolean | string | number
    valueFormat?: string
    tips?: string
    dateType?: string
}
const props = withDefaults(
    defineProps<{
        modelValue?: any
        rules?: any
        action: string | ((value: any) => void)
        formType?: string
        columns: QaFormColumns[]
        labelWidth?: string | number,
        beforeAction?: (value: any) => boolean | void
        cancelText?: string
        submitText?: string
        data?:any
    }>(),
    {
        cancelText: '取消',
        submitText: '确认'
    }
)

/** 表单项绑定 props（排除 key，避免与 v-for 的 :key 冲突） */
function getFormItemBind(item: QaFormColumns) {
    const { key: _key, ...rest } = item
    return { ...rest, itemKey: item.key, label: item.title }
}

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

            if (typeof props.action === 'string') {

                let postData = model.value

                // 调用前先判断是否存在
                const beforeResult = props.beforeAction?.(model.value)

                if (beforeResult === false) {
                    return
                }

                // 如果存在返回值并且不是 false
                if (beforeResult !== undefined) {
                    postData = beforeResult === true ? model.value : beforeResult
                }

                try {
                     await http.request({
                        url: props.action as string,
                        method: 'post',
                        data: postData,
                    })
                    ElMessage.success("提交成功!")
                    emit('success')
                } catch (error: any) {
                    // ElMessage.error(error)
                } finally {
                    loading.value = false
                }

                console.log('submit!')
            }

            if (typeof props.action === 'function') {
                try{
                    await props.action({data:model.value})
                    ElMessage.success("提交成功!")
                }catch(error:any){
                    ElMessage.error(error)
                } finally {
                    loading.value = false
                }
            }
        }
        else {
            console.log('error submit!', fields)
        }
    })
}

function getResetFormData() {
    return cloneDeep(resetCache.value)
}

// 按当前缓存的默认值重置表单，并清除校验状态
const resetForm = async (formEl: FormInstance | undefined) => {
    if (!formEl) return

    model.value = getResetFormData()
    await nextTick()
    formEl.clearValidate()
}

// 设置新的默认重置值，不直接改动当前表单数据
function setResetFormData(data?: Record<string, any>) {
    resetCache.value = cloneDeep(data ?? model.value)
}

// 兼容旧调用方式，行为与 resetForm 保持一致
const resetFormDataDefault = async (formEl: FormInstance | undefined) => {
    await resetForm(formEl)
}

// 关闭表单弹窗
const closeForm = () => {
    emit('closeForm')
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
        return resetForm(ruleFormRef.value)
    },
    clearValidate: (...args: any[]) => ruleFormRef.value?.clearValidate?.(...args),
    submitForm: () => submitForm(ruleFormRef.value),
    setResetFormData: (data: any) => setResetFormData(data),
    resetFormDataDefault: async () => {
        await nextTick()
        return resetFormDataDefault(ruleFormRef.value)
    }
})

</script>
