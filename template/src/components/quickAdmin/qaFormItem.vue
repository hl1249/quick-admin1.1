<template>
    <div></div>
</template>

<script setup lang="ts">
const props = withDefaults(defineProps<{
    type: 'text' | 'textarea' | 'date',
    itemKey: string
}>(), {

})
</script>

<style scoped></style>