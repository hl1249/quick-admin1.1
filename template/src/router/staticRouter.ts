
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
        name:'root',
        component: main,
        redirect: '/home',
        meta: {
            title: "首页",
            icon: ""
        },
        children: [{
            path: 'home',
            name: 'home',
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