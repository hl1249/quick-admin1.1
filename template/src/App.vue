<template>
    <router-view />
</template>

<script setup>
import { RouterView } from 'vue-router';
import { useDark, useLocalStorage } from '@vueuse/core'
const isDark = useDark()
document.documentElement.classList.toggle('dark', isDark.value)

</script>

<style lang="less" scoped>
</style>