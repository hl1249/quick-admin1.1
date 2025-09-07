<template>
    <el-sub-menu :index="item.name" v-if="item?.children">
        <template #title>
            <el-icon :size="20">
                <component :is="item.icon"></component>
            </el-icon>
            <span>{{ item.title }}</span>
        </template>

        <side-item v-for="child in item.children" :key="child._id" :item="child" />
    </el-sub-menu>
    <el-menu-item :index="item.name" v-else-if="item?.children" @click="handleClick(item)">
        <el-icon :size="20">
            <component :is="item.icon"></component>
        </el-icon>
        <span>{{ item.title }}</span>
    </el-menu-item>

    <el-menu-item :index="item.name" @click="handleClick(item)" v-else>
        <el-icon :size="20">
            <component :is="item.icon"></component>
        </el-icon>
        <span>{{ item.title }}</span>
    </el-menu-item>
</template>

<script setup lang="ts">
defineOptions({
  name: 'SideItem'  // 让递归识别自己
})
import { useRouter } from 'vue-router';

const props = defineProps<{
  item: { [key: string]: any } // 不再标记为可选
}>();

const router = useRouter()

const handleClick = (item: any) => {
    router.push({name:item.name})
}
</script>

<style scoped></style>
