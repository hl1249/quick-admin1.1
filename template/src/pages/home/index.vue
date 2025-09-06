<template>
    <div class="position-relative">
        <div id="lottie_box" class="animation" ></div>
    </div>
</template>

<script setup lang="ts">
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

<style scoped lang="scss">
.animation {
    width: 500px;
    margin: auto;
    height: calc(100vh - 180px);
}
</style>
