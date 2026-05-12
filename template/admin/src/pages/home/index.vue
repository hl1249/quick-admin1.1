<template>
  <div class="flex flex-col h-full">
    <el-scrollbar>
      <div class="position-relative">
        <div id="lottie_box" class="animation"></div>
      </div>
    </el-scrollbar>
  </div>
</template>

<script setup lang="ts">

let wuhu = ref({})

import anData from '@/assets/lottie/mongo.json'
import lottie from 'lottie-web'
let animation = {};
onMounted(() => {
  animation = lottie.loadAnimation({
    container: document.getElementById('lottie_box') as HTMLElement,
    renderer: 'svg',
    loop: true,
    autoplay: true,
    animationData: anData,
  })
})

</script>

<style scoped>
.animation {
  width: 500px;
  margin: auto;
  height: calc(100vh - 200px);
  width: 500px;
  margin: auto;
  height: calc(100vh - 180px);
}
</style>

