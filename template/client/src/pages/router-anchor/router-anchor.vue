<template>
  <view class="page">
    <text class="t">路由占位页</text>
    <text class="d">满足主包 pages 至少 2 条以开启 H5 多页路由；启动页仍为 pages/index/index。</text>
  </view>
</template>

<script setup lang="ts"></script>

<style scoped>
.page {
  padding: 24rpx;
}
.t {
  font-size: 30rpx;
  display: block;
  margin-bottom: 16rpx;
}
.d {
  font-size: 26rpx;
  color: #666;
}
</style>
