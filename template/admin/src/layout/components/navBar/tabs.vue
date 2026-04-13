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
      <el-dropdown trigger="click">
        <div class="border  border-[--el-border-color] w-[32px] h-[32px] flex items-center justify-center"> <el-icon>
            <ArrowDown />
          </el-icon> </div>
        <template #dropdown>
          <el-dropdown-menu>

            <el-dropdown-item @click="menuStore.closeLeftNavTab()" :disabled="menuStore.tabsActiveIndex < 2">
              <div class="flex items-center justify-center">
                <el-icon>
                  <Back />
                </el-icon>
                关闭左侧
              </div>
            </el-dropdown-item>
            <el-dropdown-item @click="menuStore.closeRightNavTab()"
              :disabled="!(menuStore.tabsList.length > 1 && menuStore.tabsActiveIndex != menuStore.tabsList.length - 1)">
              <div class="flex items-center justify-center"><el-icon>
                  <Right />
                </el-icon>
                关闭右侧
              </div>
            </el-dropdown-item>
            <el-dropdown-item @click="menuStore.closeOtherNavTab()" :disabled="menuStore.tabsList.length <= 1">
              <div class="flex items-center justify-center"><el-icon>
                  <Close />
                </el-icon>
                关闭其他
              </div>
            </el-dropdown-item>

            <el-dropdown-item :disabled="menuStore.tabsList.length <= 1" @click="menuStore.removeAllTabs()">
              <div class="flex items-center justify-center"><el-icon>
                  <CircleCloseFilled />
                </el-icon>
                关闭所有
              </div>
            </el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
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
  console.log('router.getRoutes()',router.getRoutes(),item)
  const toRouter = router.getRoutes().find(i => i.name === item)
  menuStore.tabsNavTo(toRouter as TabItem)
}

const removeTab = (targetName: TabPaneName) => {
  const findIndex = menuStore.tabsList.findIndex(item => item.name === targetName)
  menuStore.removeTabs(findIndex, targetName)
}
</script>

<style lang="scss" scoped>
.demo-tabs {
  :deep(.el-tabs__header) {
    margin: 0;
    border: none;
  }

  :deep(.el-tabs__nav) {
    padding-top: 1px;
    gap: 5px !important;
    border: none;
    background-color: transparent;
    border: none !important;
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