import { createRouter , createMemoryHistory, createWebHistory } from 'vue-router'


const defaultRouter = [
    {
        path:'/',
        component: () => import('@/pages/home/index.vue'),
    },
    {
        path:'/login',
        component: () => import('@/pages/login/index.vue')
    }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    ...defaultRouter
  ],
})

export default router