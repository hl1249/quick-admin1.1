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
        "path": "template",
        "children": [
            {
                "path": "template/upload",
                "menu_id": "template-table",
                "name": "基础用法",
                "icon": "tickets",
                "title": "基础用法",
                component: "/src/pages/template/form/index",
            },
            {
                "path": "template/upload",
                "menu_id": "template-table",
                "name": "表格渲染",
                "icon": "document-copy",
                "title": "表格渲染",
                component: "/src/pages/template/table/index",
            }
        ]
    },
    {
        "_id": "databaseDesign",
        "menu_id": "databaseDesign",
        "icon": "DocumentCopy",
        "title": "CRUD代码生成",
        "name":"数据表设计",
        "sort": 999,
        "path": "databaseDesign",
        component: "/src/pages/databaseDesign/index",
    },
    {
        "_id": "custom",
        "menu_id": "custom",
        "icon": "DocumentCopy",
        "title": "测试",
        "name":"custom",
        "sort": 999,
        "path": "custom",
        component: "/src/pages/custom/index",
    }
]