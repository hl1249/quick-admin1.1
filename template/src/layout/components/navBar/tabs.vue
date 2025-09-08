<template>
  <div class="px-[1rem] h-[40px]">
    <div class="flex justify-between items-center">
      <div class="w-0 flex-1">
        <el-tabs v-model="menuStore.activeName" type="card" class="demo-tabs" @tab-remove="removeTab"
          @tab-change="TabClick">
          <el-tab-pane :closable="item?.noClosable ? false : true" v-for="item in menuStore.tabsList" :key="item.name"
            :label="item.meta.title" :name="item.name">
          </el-tab-pane>
        </el-tabs>
      </div>
      <div>
        我
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import type { TabPaneName } from 'element-plus'
import type { TabItem } from '@/store/modules/menuStore'
import router from '@/router'
import { useStore } from '@/store'

const { menuStore } = useStore()

const TabClick = (item: any) => {
  const toRouter = router.getRoutes().find(i => i.name === item)
  menuStore.tabsNavTo(toRouter as TabItem)
}

const removeTab = (targetName: TabPaneName) => {
  const findIndex = menuStore.tabsList.findIndex( item => item.name === targetName)
  console.log('targetName', findIndex)
  menuStore.removeTabs(findIndex,targetName)
}
</script>

<style lang="less" scoped>
.demo-tabs {
  :deep(.el-tabs__header) {
    margin: 0;
    border: none;
  }

  :deep(.el-tabs__nav) {
    gap: 5px !important;
    border: none;
    background-color: transparent;
  }

  :deep(.el-tabs__item) {
    margin: 0;
    height: 25px;
    // padding: 4px 8px;
    border-left: none;
    border-radius: 3px;
    border: 1px solid var(--el-border-color) !important;
    // background-color: white;
  }

  :deep(.el-tabs__nav-next),
  :deep(.el-tabs__nav-prev) {
    line-height: 25px;
  }
}
</style>