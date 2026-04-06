<template>
  <div class="p-6 max-w-lg">
    <qa-upload v-model="fileUrl" :limit="1" :file-size="2" size-unit="MB" button-text="选择文件" />
    <pre class="mt-4 text-sm bg-gray-100 p-3 rounded">{{ JSON.stringify(fileUrl, null, 2) }}</pre>
  </div>
</template>

<script setup lang="ts">
const fileUrl = ref<string | null>(null)
</script>

<style scoped></style>
