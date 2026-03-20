<template>
  <div class="system-file-page">
    <el-tabs type="border-card" class="system-file-tabs">
      <el-tab-pane label="上传">上传</el-tab-pane>
      <el-tab-pane label="配置">
        <el-tabs v-model="activeName" class="config-inner-tabs demo-tabs" @tab-click="handleClick">
          <el-tab-pane label="存储配置" name="config">
           <div class="flex flex-col gap-[20px]">
             <el-radio-group v-model="provider">
               <el-radio value="local">本地</el-radio>
               <el-radio value="tencent">腾讯云</el-radio>
               <el-radio value="aliyun">阿里云</el-radio>
               <el-radio value="qiniu">七牛云</el-radio>
             </el-radio-group>
             <div>
               <el-button type="primary" @click="saveConfig()" :loading="saveLoading">保存</el-button>
             </div>
           </div>
          </el-tab-pane>
          <el-tab-pane label="腾讯云" name="tencent">
            <div class="tab-pane-fill">
              <el-alert type="info" class="flex-shrink-0">
                <p>腾讯云cos开通方法：点击查看</p>
                <p>第一步： 添加【存储空间】（空间名称不能重复）</p>
                <p>第二步： 开启【使用状态】</p>
                <p>第三步（可选）： 选择云存储空间列表上的修改【空间域名操作】</p>
                <p>第四步（可选）： 选择云存储空间列表上的修改【CNAME配置】，打开后复制记录值到对应的平台解析</p>
              </el-alert>
              <space-list v-if="activeName === 'tencent'" :provider="activeName" class="space-list-grow" />
            </div>
          </el-tab-pane>
          <el-tab-pane label="阿里云" name="aliyun">
            <space-list v-if="activeName === 'aliyun'" :provider="activeName" class="space-list-grow" />
          </el-tab-pane>
          <el-tab-pane label="七牛云" name="qiniu">
            <space-list v-if="activeName === 'qiniu'" :provider="activeName" class="space-list-grow" />
          </el-tab-pane>
        </el-tabs>
      </el-tab-pane>
    </el-tabs>


  </div>
</template>

<script setup lang="ts">
import {ElMessage, type TabsPaneContext} from 'element-plus'
import spaceList from './components/spaceList.vue'
import { saveStorageConfig, getStorageConfig } from '@/api/file'

const activeName = ref('config')

const provider: Ref<string> = ref('')

const handleClick = (tab: TabsPaneContext, event: Event) => {
  console.log(tab, event)
}

const saveLoading:Ref<boolean> = ref( false)
const saveConfig = async () => {
  saveLoading.value = true
  try{
    await saveStorageConfig({
      provider: provider.value
    })
    ElMessage.success('保存成功')
  }catch (err){
    ElMessage.error(JSON.stringify(err))
  }finally {
    saveLoading.value = false
  }

}

const getConfig = async () => {
  const res = await getStorageConfig()
  provider.value = res.data.data.provider
}

onMounted(() => {
  getConfig()
})
</script>

<style lang="scss" scoped>
/* 与 layout main 里 router-view 外包的 h-full 衔接，占满可视区域 */
.system-file-page {
  height: 100%;
  min-height: 0;
  display: flex;
  flex-direction: column;
}

/* 外层 Tabs：占满页面剩余高度 */
.system-file-tabs {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.system-file-tabs :deep(.el-tabs__content) {
  flex: 1;
  min-height: 0;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.system-file-tabs :deep(.el-tab-pane) {
  flex: 1;
  min-height: 0;
  overflow: hidden;
}

/* 「配置」里嵌套的 Tabs 同样撑满上一层面板 */
.config-inner-tabs {
  height: 100%;
  min-height: 0;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.config-inner-tabs :deep(.el-tabs__content) {
  flex: 1;
  min-height: 0;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.config-inner-tabs :deep(.el-tab-pane) {
  flex: 1;
  min-height: 0;
  overflow: hidden;
}

/* 腾讯云：提示区固定高度，下方列表吃满剩余 */
.tab-pane-fill {
  height: 100%;
  min-height: 0;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.space-list-grow {
  flex: 1;
  min-height: 0;
  min-width: 0;
}
</style>