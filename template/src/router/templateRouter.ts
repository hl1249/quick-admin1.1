//
// import type { RouteRecordRaw } from 'vue-router'
// import main from '@/layout/main.vue'
//
// export type Meta = {
//     title: string
//     icon: string
//     menu_id?: string
//     hideInMenu?: boolean
//     parent_id?: boolean
// }
//
// export type Routers = RouteRecordRaw & {
//     meta: Meta
//     enable?: boolean
//     sort?: number
// }
//
// const templateRouter: Routers[] = [
//     {
//         path: '/template',
//         component: main,
//         meta: {
//             title: "组件演示",
//             icon: "House"
//         },
//         children: [{
//             path: '/template/table',
//             name: 'table',
//             component: () => import('@/pages/template/index.vue'),
//             meta: {
//                 title: "基础用法",
//                 icon: "HomeFilled"
//             },
//             }
//         ]
//     }
// ]
//
// export default templateRouter<el-icon><ElementPlus /></el-icon>


export default [
    {
        "_id": "template",
        "menu_id": "template",
        "icon": "ElementPlus",
        "title": "组件演示",
        "name":"组件演示",
        "sort": 999,
        "children": [
            {
                "menu_id": "template-table",
                "name": "基础用法",
                "icon": "grid",
                "title": "基础用法",
                component: "/src/pages/template/index",
            }
        ]
    }
]