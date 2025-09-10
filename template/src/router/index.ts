import { createRouter, createMemoryHistory, createWebHistory } from 'vue-router'
import staticRouter from './staticRouter'
import { getDynamicMenu } from '@/api/auth'
import { useStore } from '@/store'
import type { TabItem } from '@/store/modules/menuStore'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    ...staticRouter
  ],
})

// router.addRoute({
//   path: '/:pathMatch(.*)*',
//   name: 'NotFound',
//   component: () => import('@/pages/error/index.vue')
// })

let firstLoad = true

router.beforeEach(async (to, from, next) => {
  const { menuStore, authStore } = useStore()
  if (to.path === '/login') {
    const isLogin = await authStore.checkLogin()
    if (isLogin) {
      // 已登录，重定向到首页
      next({path:'/'})
    } else {
      // 未登录，允许访问登录页
      next()
    }
    return
  }

  menuStore.initActiveName(to.name as string)
  menuStore.initBreadCrumbList(to, router.getRoutes())
  menuStore.addTabs(to as TabItem)

  if (firstLoad) {
    firstLoad = false
    try {
      // 获取动态菜单
      const res = await getDynamicMenu()
      menuStore.initMenu(res.data.data.menus)
      // 菜单加载完成后继续导航
      next({ path: to.path, query: to.query })
    } catch (error) {
      console.error('Failed to load dynamic menu:', error)
      // 即使菜单加载失败也允许继续导航
      next()
    }
  } else {
    if (menuStore.menuList.length <= 0) {
      const res = await getDynamicMenu()
      menuStore.initMenu(res.data.data.menus)
    }
    // 非首次加载，直接继续
    next()
  }
})
export default router