<template>
  <view class="content">
    <image class="logo" src="/static/logo.png" />
    <button @click="getInfo">获取app信息</button>
    <view class="text-area">
      <text class="title">{{ title }}</text>
      <view>当前运行环境：{{ currentMode }}</view>
      <view>当前环境的 VITE_SERVER_BASEURL：{{ currentBaseUrl || '未读取到' }}</view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { getAppInfo } from '@/api/appid'

const title = ref('Hello')
const currentMode = import.meta.env.MODE
const currentBaseUrl = import.meta.env.VITE_SERVER_BASEURL as string | undefined

const getInfo = () => {
  getAppInfo({
	  appid:"wx65f51726f2c3e73a"
  }).then(res => {
    console.log(res)
  })
}
</script>

<style>
.content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.logo {
  height: 200rpx;
  width: 200rpx;
  margin-top: 200rpx;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: 50rpx;
}

.text-area {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.title {
  font-size: 36rpx;
  color: #8f8f94;
}
</style>
