<template>
    <div class="left-silder">
        <el-menu :default-openeds="menuStore.openeds" popper-effect="dark" :default-active="menuStore.activeName" class="el-menu-vertical-demo theme-bg" :collapse="menuStore.isCollapse" @open="handleOpen"
            @close="handleClose">
            <silder-item v-for="route,index in menuStore.menuList" :key="route._id" :item="route"/>
        </el-menu>
    </div>
</template>

<script lang="ts" setup>
import SilderItem from './silderItem.vue'

import {
  Document,
  Menu as IconMenu,
  Location,
  Setting,
} from '@element-plus/icons-vue'

import { useStore } from '@/store'
const { menuStore } = useStore()

const isCollapse = ref(true)

const handleOpen = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}
const handleClose = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}
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