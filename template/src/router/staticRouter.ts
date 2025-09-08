
import type { RouteRecordRaw } from 'vue-router'
import main from '@/layout/main.vue'

export type Meta = {
    title: string
    icon: string
    menu_id?: string
    hideInMenu?: boolean
    parent_id?: boolean
}

export type Routers = RouteRecordRaw & {
    meta: Meta
    enable?: boolean
    sort?: number
}

const staticRouter: Routers[] = [
    {
        path: '/',
        name:'home',
        component: main,
        redirect: '/home',
        meta: {
            title: "根页",
            icon: ""
        },
        children: [{
            path: '/home',
            name: 'home_page',
            component: () => import('@/pages/home/index.vue'),
            meta: {
                title: "首页",
                icon: "HomeFilled"
            },
        },
        
        ]
    },
    {
        path: '/login',
        component: () => import('@/pages/login/index.vue'),
        meta: {
            title: "登陆",
            icon: ""
        }
    }
]

export default staticRouter