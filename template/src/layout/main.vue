<template>
  <div class="layout-main">
    <Menu />
    <div class="right-content ">
      <NavBar />
      <div id="view" class="view h-[calc(100%-4rem-40px)] p-4">
          <div class="h-full p-4 bg-[--pg-bg-color] border-none" >
            <router-view />
          </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import Menu from './components/menu/index.vue'
import NavBar from './components/navBar/index.vue'
</script>

<style lang="less" scoped>
.layout-main {
  display: flex;
  height: 100vh;
  background-color: var(--v-main-bg-color);

  .right-content {
    width: 0;
    display: flex;
    flex: auto;
    flex-direction: column;
  }

  .center-content {
    display: flex;
    flex: 1;
  }

  .view {
    width: 100%;
    background: var(--el-fill-color);
    transition: var(--el-transition-duration);
    box-sizing: border-box;
    overflow: hidden;
    position: relative;
  }
}
</style>