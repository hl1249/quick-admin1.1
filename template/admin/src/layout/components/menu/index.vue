<template>
    <div class="left-silder">
        <el-menu :default-openeds="menuStore.openeds" popper-effect="dark" :default-active="String(route.name)" class="el-menu-vertical-demo theme-bg" :collapse="menuStore.isCollapse">
            <silder-item v-for="menu in menuStore.menuList" :key="menu._id" :item="menu"/>
        </el-menu>
    </div>
</template>

<script lang="ts" setup>
import SilderItem from './silderItem.vue'
import { useRoute } from 'vue-router'

import { useStore } from '@/store'
const { menuStore } = useStore()
const route = useRoute()

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