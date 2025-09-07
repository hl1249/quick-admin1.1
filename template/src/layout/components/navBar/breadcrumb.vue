<template>
    <div class=" flex justify-between items-center">
        <div class="flex items-center gap-5 px-4 h-16">   
            <el-icon size="1.5rem" @click="menuStore.changeIsCollapse"
             :class=" 'transition-all duration-200 ' + (menuStore.isCollapse ? 'rotate-90' : '')"
             >
            <Expand />
            </el-icon>
            <el-breadcrumb :separator-icon="ArrowRight">
                <el-breadcrumb-item :to="{ path: '/' }">homepage</el-breadcrumb-item>
                <el-breadcrumb-item>promotion management</el-breadcrumb-item>
                <el-breadcrumb-item>promotion list</el-breadcrumb-item>
                <el-breadcrumb-item>promotion detail</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="flex pr-4 items-center gap-[10px]">
            <Dark></Dark>
            <el-dropdown placement="top-start" class="focus-visible:!outline-none">
                <div
                class="flex flex-row items-center gap-5 focus-visible:!outline-none"
                >
                <el-avatar
                    :size="30"
                    :src="userInfo.avatar"
                />
                <el-icon>
                    <ArrowDown />
                </el-icon>
                </div>
                <template #dropdown>
                <el-dropdown-menu>
                    <el-dropdown-item @click="authStore.logout">退出登录</el-dropdown-item>
                </el-dropdown-menu>
                </template>
            </el-dropdown>
        </div>
    </div>
</template>

<script setup>

import { ArrowRight } from '@element-plus/icons-vue'
import Dark from './dark.vue'
import { useStore } from '@/store'
const { menuStore , authStore } = useStore()
const {userInfo} = authStore
console.log('userInfo',userInfo)
</script>