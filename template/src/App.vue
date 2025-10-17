<template>
    
  <el-config-provider :locale="locale" :size="size">
    <router-view />
  </el-config-provider>
</template>

<script setup lang="ts">
import { RouterView } from 'vue-router';
import { useDark, useLocalStorage } from '@vueuse/core'
const isDark = useDark()
document.documentElement.classList.toggle('dark', isDark.value)
import { ElConfigProvider } from 'element-plus'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
const locale = ref(zhCn)
const size = useLocalStorage('element-size', 'default') as unknown as
  | ''
  | 'small'
  | 'default'
  | 'large'

</script>

<style lang="less" scoped>
</style>