<template>
    <view class="content">
      <view class="version-box">
        <view>
          <text>当前运行的</text><text class="vue-label">vue</text>版本：
          <text class="vue-version-text">
            <!-- #ifdef VUE2 -->
            Vue2
            <!-- #endif -->
            <!-- #ifdef VUE3 -->
            Vue3
            <!-- #endif -->
          </text>
        </view>
      </view>
  
      <button class="button" type="default" @click="pageTo('../password/password')">用户名和密码</button>
      <button class="button" type="default" @click="pageTo('../mobile/mobile')">手机号和验证码</button>
      <button class="button" type="default" @click="pageTo('../email/email')">邮箱与验证码</button>
      <!-- #ifdef MP-WEIXIN || APP-PLUS -->
      <button class="button" type="default" @click="pageTo('../weixin/weixin')">微信登录</button>
      <!-- #endif -->
      <!-- #ifdef MP-ALIPAY || APP-PLUS -->
      <button class="button" type="default" @click="pageTo('../alipay/alipay')">支付宝登录</button>
      <!-- #endif -->
      <!-- #ifdef MP-QQ || APP-PLUS -->
      <button class="button" type="default" @click="pageTo('../qq/qq')">QQ登录</button>
      <!-- #endif -->
      <view class="section-tip">小白也能轻松上手的数据库API</view>
      <button class="button" type="default" @click="pageTo('../../db/db')">数据库API</button>
      <button class="button" type="default" @click="pageTo('../util/util')">通用方法</button>
      <button class="button" type="default" @click="pageTo('../closeAccount/closeAccount')">账号注销与恢复</button>
  
      <view class="section-tip">插件版本1.8.7 新增 APP手机一键登录</view>
      <button class="button" type="default" @click="pageTo('../univerify/univerify')">APP本机号码一键登录</button>
      <view class="section-tip">插件版本1.4.4 新增 Vuex状态管理</view>
      <button class="button" type="default" @click="pageTo('../../vuex/vuex')">Vuex状态管理演示示例</button>
      <button class="button" type="default" @click="pageTo('../login/index/index')">登录注册找回密码页面模板</button>
      <view class="section-tip">三方工具对接</view>
    </view>
  </template>
  
  <script>
    export default {
      data() {
        return {};
      },
      methods: {
        pageTo(url) {
          uni.navigateTo({
            url
          })
        },
        openWeb(url) {
        },
      },
    };
  </script>
  
  <style scoped>
    .content {
      padding: 15px;
    }

    .content .button {
      margin-bottom: 15px;
    }

    .content .version-box {
      margin-bottom: 10px;
      font-size: 16px;
    }

    .content .version-box .vue-label {
      font-weight: bold;
      margin: 0 5px;
    }

    .content .version-box .vue-version-text {
      font-weight: bold;
    }

    .content .section-tip {
      margin-bottom: 10px;
    }

    .content .web-link {
      font-size: 12px;
      text-decoration: underline;
      color: blue;
    }

    .tips {
      text-align: center;
      line-height: 20px;
      font-size: 14px;
      color: #999999;
      margin-bottom: 20px;
    }
  </style>
  