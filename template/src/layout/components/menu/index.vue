<template>
    <div class="left-silder">
        <el-menu :default-openeds="menuStore.openeds" popper-effect="dark" :default-active="menuStore.activeName" class="el-menu-vertical-demo theme-bg" :collapse="menuStore.isCollapse">
            <silder-item v-for="route in menuStore.menuList" :key="route._id" :item="route"/>
        </el-menu>
    </div>
</template>

<script lang="ts" setup>
import SilderItem from './silderItem.vue'

import { useStore } from '@/store'
const { menuStore } = useStore()

</script>

<style lang="less">
.left-silder {
  height: 100%;

  .el-menu-vertical-demo:not(.el-menu--collapse) {
    width: 200px;
    min-height: 400px;
    height: 100%;
  }

  .el-menu--collapse {
    height: 100%;
  }
}
</style>