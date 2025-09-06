<template>
    <el-menu default-active="2" popper-effect="dark"
  :collapse="menuStore.isCollapse" class="el-menu-vertical-demo theme-bg" @open="handleOpen" @close="handleClose">
    <el-sub-menu index="1">
      <template #title>
        <el-icon>
          <location />
        </el-icon>
        <span>Navigator One</span>
      </template>
      <el-menu-item-group title="Group One">
        <el-menu-item index="1-1">item one</el-menu-item>
        <el-menu-item index="1-2">item two</el-menu-item>
      </el-menu-item-group>
      <el-menu-item-group title="Group Two">
        <el-menu-item index="1-3">item three</el-menu-item>
      </el-menu-item-group>
    </el-sub-menu>
      <el-sub-menu index="1-4">
        <template #title>
        <el-icon>
          <location />
        </el-icon>
        <span>item four</span>
      </template>
        <el-menu-item index="1-4-1">item one</el-menu-item>
      </el-sub-menu>
  </el-menu>
</template>

<script lang="ts" setup>
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