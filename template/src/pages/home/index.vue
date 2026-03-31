<template>
    <div class="flex flex-col h-full">
        <el-scrollbar>
            <div class="position-relative">
                <qa-area-cascader v-model="wuhu" @confirm="confirm" />
                <div id="lottie_box" class="animation"></div>
            </div>
        </el-scrollbar>
    </div>
</template>

<script setup lang="ts">
import type { AddrResult } from '@/components/quickAdmin/base/qaAreaCascader.vue';

const confirm = (value: AddrResult) => {
    console.log(value)
}

let wuhu = ref({})

import anData from '@/assets/lottie/mongo.json'
import lottie from 'lottie-web'
onMounted(() => {
    lottie.loadAnimation({
        container: document.getElementById('lottie_box') as HTMLElement,
        renderer: 'svg',
        loop: true,
        autoplay: true,
        animationData: anData,
    })
})

</script>

<style scoped lang="scss">
.animation {
    width: 500px;
    margin: auto;
    height: calc(100vh - 200px);
}
</style>
