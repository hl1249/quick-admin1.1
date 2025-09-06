<template>
  <div class="px-[1rem] h-[40px]">
    <div class="flex justify-between items-center">
      <div class="w-[80%] flex-1">

        <el-tabs v-model="editableTabsValue" type="card" class="demo-tabs"  @tab-remove="removeTab">
          <el-tab-pane label="首页" name="/home" >
          </el-tab-pane>
          <el-tab-pane  closable v-for="item in editableTabs" :key="item.name" :label="item.title" :name="item.name">
          </el-tab-pane>
        </el-tabs>
      </div>
      <div @click="addTab('维护')">
        我叼你妈
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'

import type { TabPaneName } from 'element-plus'

let tabIndex = 2
const editableTabsValue = ref('2')
const editableTabs = ref([
  {
    title: 'Tab 1',
    name: '1',
    content: 'Tab 1 content',
  }
])

const addTab = (targetName: string) => {
  const newTabName = `${++tabIndex}`
  editableTabs.value.push({
    title: 'New Tab',
    name: newTabName,
    content: 'New Tab content',
  })
  editableTabsValue.value = newTabName
}
const removeTab = (targetName: TabPaneName) => {
  const tabs = editableTabs.value
  let activeName = editableTabsValue.value
  if (activeName === targetName) {
    tabs.forEach((tab, index) => {
      if (tab.name === targetName) {
        const nextTab = tabs[index + 1] || tabs[index - 1]
        if (nextTab) {
          activeName = nextTab.name
        }
      }
    })
  }

  editableTabsValue.value = activeName
  editableTabs.value = tabs.filter((tab) => tab.name !== targetName)
}
</script>

<style lang="less" scoped>
.demo-tabs {
  /deep/ .el-tabs__header {
    margin: 0;
    border: none;
  }

  /deep/ .el-tabs__nav {
    gap: 5px !important;
    border: none;
    background-color: transparent;
  }

  /deep/ .el-tabs__item {
    margin: 0;
    height: 25px;
    padding: 4px 8px;
    border-left: none;
    border-radius: 3px;
    border: 1px solid var(--el-border-color) !important;
    // background-color: white;
  }

  /deep/ .el-tabs__nav-next,
  /deep/ .el-tabs__nav-prev {
    line-height: 25px;
  }
}
</style>