<template>
  <div class="login-container">
    <div class=" absolute right-[2%] top-[2%]">
      <Dark/>
    </div>
    <img class="logo" src="@/assets/logo.png" alt="">
    <el-form ref="ruleFormRef" style="max-width: 600px" :model="ruleForm" status-icon :rules="rules" label-width="120px"
      class="demo-ruleForm">
      <el-form-item label="账号" prop="username">
        <el-input v-model="ruleForm.username" type="text" autocomplete="off"  style="width: 220px;"/>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="ruleForm.password" type="password" autocomplete="off" show-password style="width: 220px;"/>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm(ruleFormRef)">
          登录
        </el-button>
        <el-button @click="resetForm(ruleFormRef)">重置</el-button>
      </el-form-item>
    </el-form>
  </div>


</template>

<script setup lang="ts">
import Dark from '@/layout/components/navBar/dark.vue'

import type { FormInstance, FormRules } from 'element-plus'
import { useStore } from '@/store'
const { authStore } = useStore()

const ruleFormRef = ref<FormInstance>()
const validateUsername = (rule: any, value: any, callback: any) => {
  if (value === '') {
    callback(new Error('请填写账号'))
  } else {
    callback()
  }
}
const validatePassword = (rule: any, value: any, callback: any) => {
  if (value === '') {
    callback(new Error('请填写密码'))
  } else {
    callback()
  }
}

const ruleForm = reactive({
  username: 'admin',
  password: 'hr20001124',
})

const rules = reactive<FormRules<typeof ruleForm>>({
  username: [{ validator: validateUsername, trigger: 'blur' }],
  password: [{ validator: validatePassword, trigger: 'blur' }],
})

const submitForm = (formEl: FormInstance | undefined) => {
  console.log(formEl)
  if (!formEl) return
  formEl.validate((valid) => {
    if (valid) {
      console.log('submit!',ruleForm)
      authStore.login(ruleForm)
    } else {
      console.log('error submit!')
    }
  })
}

const resetForm = (formEl: FormInstance | undefined) => {
  if (!formEl) return
  formEl.resetFields()
}
</script>

<style lang="less" scoped>
.login-container {
  width: 100%;
  height: 100vh;
  background-color: var(--v-bg-color);
  display: flex;
  justify-content: center;
  align-items: center;

  .logo {
    width: 250px;
    height: 250px;
  }
}
</style>
