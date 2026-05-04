<template>
  <view class="content">
    <button @click="loginByWeixin">登录</button>
    <button @click="go">跳转</button>
    <view class="text-area ">
      <text class="title">{{ title }}</text>
      <view>当前运行环境：{{ currentMode }}</view>
      <view>当前 baseURL：{{ currentBaseUrl || '未读取到' }}</view>
      <view>AppInfo：{{ appInfoStore.appInfo }}</view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { getUrl } from '@/utils/http'
import { useAppInfoStore } from '@/store/appInfo'
import {useUserStore} from '@/store/user'

const title = ref('Hello')
const currentMode = import.meta.env.MODE
const currentBaseUrl = getUrl()
const appInfoStore = useAppInfoStore()
const userStore = useUserStore()
const loginByWeixin = async () => {
  const result = await userStore.loginByWeixin(appInfoStore.appInfo.appid)
  console.log(result)
}

const go = () => {
  uni.reLaunch({
    url: '/pages_template/auth/index/index'
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
