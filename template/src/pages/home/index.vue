<template>
    <div class="position-relative">
       <qa-area-cascader @confirm="confirm" />
        <div id="lottie_box" class="animation"></div>
    </div>
</template>

<script setup lang="ts">
import qaAreaCascader from '@/components/quickAdmin/qaAreaCascader.vue';
import type {AddrResult} from '@/components/quickAdmin/qaAreaCascader.vue';

const confirm = (value: AddrResult) => {
    console.log(value)
}

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
    height: calc(100vh - 180px);
}
</style>
