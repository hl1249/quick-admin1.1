import { createRouter, createWebHistory } from 'vue-router'
import staticRouter from './staticRouter'
import { getDynamicMenu } from '@/api/auth'
import { useStore } from '@/store'
import type { TabItem } from '@/store/modules/menuStore'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'

NProgress.configure({ showSpinner: false, speed: 300 })

const router = createRouter({
  history: createWebHistory(),
  routes: [
    ...staticRouter,
  ],
})

// router.addRoute({
//   path: '/:pathMatch(.*)*',
//   name: 'NotFound',
//   component: () => import('@/pages/error/index.vue')
// })

let firstLoad = true

async function syncDynamicMenus(forceRefresh = false) {
  const { menuStore } = useStore()
  const res = await getDynamicMenu()
  const data = res.data?.data ?? {}
  const menus = Array.isArray(data.menus) ? data.menus : []
  const nextVersion = Number(data.authVersion) || 0
  const missingVersion = menuStore.menuVersion <= 0
  const versionChanged =
    menuStore.menuVersion > 0
    && nextVersion > 0
    && menuStore.menuVersion !== nextVersion
  const shouldReload =
    forceRefresh || missingVersion || versionChanged || menuStore.menuList.length <= 0

  if (versionChanged) {
    menuStore.resetMenuCache()
  }

  if (shouldReload) {
    menuStore.initMenu(menus)
  }
  menuStore.setMenuVersion(nextVersion)

  return { versionChanged }
}

router.beforeEach(async (to, from, next) => {
  NProgress.start()
  const { menuStore, authStore } = useStore()

  if (to.path === '/login') {
    try {
      const isLogin = await authStore.checkLogin()
      console.log('fucnking', isLogin)
      if (isLogin) {
        // 已登录，重定向到首页
        next({ path: '/' })
      } else {
        // 未登录，允许访问登录页
        next()
      }
    } catch (e) {
      // checkLogin 抛错（如 401）时仍放行到登录页，避免登录页被卡住
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
      const { versionChanged } = await syncDynamicMenus()
      // 菜单加载完成后继续导航
      next(versionChanged ? { path: '/home' } : { path: to.path, query: to.query })
    } catch (error) {
      console.error('Failed to load dynamic menu:', error)
      // 即使菜单加载失败也允许继续导航
      next()
    }
  } else {
    if (menuStore.menuList.length <= 0) {
      await syncDynamicMenus(true)
    }
    // 非首次加载，直接继续
    next()
  }
})
router.afterEach(() => {
  NProgress.done()
})

export default router