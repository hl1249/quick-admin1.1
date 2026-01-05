import { defineStore } from 'pinia'

import type { Ref } from 'vue'
import type { Routers } from '@/router/staticRouter'
import router from '@/router'
import { buildAsyncMenus, getHomeRoute, getBreadCrumbList } from '@/utils/index'

import templateRouter from '@/router/templateRouter'

export interface TabItem {
  name: string
  path: string
  params?: any,
  query?: any
  meta?: any
  noClosable?: boolean
}

export type MenuList = Routers & {
  _id: string,
  title: string | string[]
  icon: string
  enable: boolean
  sort: number
  menu_id: string
  parent_id?: string
  comment?: string
  [key: string]: any; // 允许其他字段存在
}

export interface MenuState {
  menuList: Ref<MenuList[]>
  initMenu: (menus: MenuList[]) => void
  clearMenuList: () => void
  isCollapse: Ref<boolean>
  changeIsCollapse: (val: boolean) => void
  openeds: Ref<any[]>
  initOpends: (value: any[]) => void
  activeName: Ref<string | number>
  initActiveName: (name: string) => void
  brendCrumbList: Ref<any[]>
  initBreadCrumbList: (to: any, route: any[]) => void
  currentTagName: Ref<string>
  tabsList: Ref<TabItem[]>
  initTabsList: (tabsList: TabItem[]) => void
  addTabs: (tabItem: TabItem) => void
  removeTabs: (index: number, targetName: string | number) => void
  removeAllTabs: () => void
  tabsNavTo: (tabItem: TabItem) => void
  tabsActiveIndex: Number
  closeLeftNavTab: () => void
  closeRightNavTab: () => void
  closeOtherNavTab: () => void
}

export const useMenuStore = defineStore(
  'menuConfig',
  () => {
    // 左侧菜单隐藏状态
    const isCollapse = ref(true)
    const changeIsCollapse = () => {
      isCollapse.value = !isCollapse.value
    }

    // 身份动态菜单
    const menuList: MenuState['menuList'] = ref([])
    const initMenu: MenuState['initMenu'] = (newMenuList: MenuList[]) => {
      menuList.value = [...newMenuList,...templateRouter as unknown as MenuList[]]
      router.addRoute({
        path: '/',
        component: () => import('@/layout/main.vue'),
        children: buildAsyncMenus(menuList.value),
      })
    }

    // 动态添加菜单
      const addMnes:(staticMenuList:any) => void = (staticMenuList) => {
        menuList.value = [
            ...menuList.value,
            ...staticMenuList
        ]
        //   menuList.value = staticMenuList
        // console.log('staticMenuList',staticMenuList)
        // router.addRoute(staticMenuList)
        //   console.log('原格式',staticMenuList)
      }

    const clearMenuList: MenuState['clearMenuList'] = () => {
      menuList.value = []
    }

    // 左侧菜单树状展开状态
    const openeds: MenuState['openeds'] = ref([])
    const initOpends: MenuState['initOpends'] = (newOpeneds) => {
      openeds.value = newOpeneds
    }

    // 左侧菜单激活选项
    const activeName = ref<string>('')
    const initActiveName: MenuState['initActiveName'] = (newActiveName) => {
      activeName.value = newActiveName
    }

    // 面包屑
    const brendCrumbList: MenuState['brendCrumbList'] = ref([])
    const initBreadCrumbList: MenuState['initBreadCrumbList'] = (to, route) => {
      // brendCrumbList.value = newBreadCrumbList const homeItem = getHomeRoute(route)
      const homeItem = getHomeRoute(route)
      const BreadCrumbList = getBreadCrumbList(to, homeItem)
      brendCrumbList.value = BreadCrumbList
    }

    // tag历史记录
    const currentTagName: MenuState['currentTagName'] = ref("home")
    // tag当前下标
    const tabsActiveIndex = computed(()=>{
      return tabsList.value.findIndex(item => item.name === activeName.value)
    })

    const homeRoute = getHomeRoute(router.getRoutes())
    // tags列表
    const tabsList: MenuState['tabsList'] = ref([{ ...homeRoute, noClosable: true }])
    const initTabsList: MenuState['initTabsList'] = (newTabsList) => {
      tabsList.value = newTabsList
    }


    const addTabs: MenuState['addTabs'] = (tabsItem) => {
      const exists = tabsList.value.some(tab => tab.name === tabsItem.name)
      if (!exists && tabsItem.name != 'NotFound') {
         tabsList.value.push({
            name:String(tabsItem.name),
            path:tabsItem.path,
            meta:tabsItem.meta,
            query:tabsItem.query
        })
      }
    }
    const removeTabs: MenuState['removeTabs'] = (index, targetName) => {
      const currentRoute = router.currentRoute.value

      if (currentRoute.name === targetName) {
        if (tabsList.value[index + 1]) {
          tabsNavTo(tabsList.value[index + 1] as TabItem)
        } else {
          tabsNavTo(tabsList.value[index - 1] as TabItem)
        }
      }
      tabsList.value.splice(index, 1)
    }
    const removeAllTabs: MenuState['removeAllTabs'] = () => {
      tabsNavTo(tabsList.value[0] as TabItem)
      tabsList.value.splice(1, tabsList.value.length)
    }

    const tabsNavTo = (tabsItem: TabItem) => {
      if (tabsItem.name === currentTagName.value) {
        router.replace({
          name: 'redirect',
          params: {
            params: JSON.stringify(tabsItem.params),
            __name: tabsItem.name as string,
          },
          query: tabsItem.query,
        })
        currentTagName.value = tabsItem.name
      } else {
        router.push({
          ...tabsItem
        })
      }

    }

    const closeLeftNavTab = () => {
       tabsList.value =  [tabsList.value[0],...tabsList.value.slice(tabsActiveIndex.value,tabsList.value.length)]
    }

    const closeRightNavTab = () => {
       tabsList.value =  tabsList.value.slice(0,tabsActiveIndex.value+1)
    }

    const closeOtherNavTab = () => {
      if( tabsActiveIndex.value === 0) tabsList.value = [tabsList.value[0]]
      else tabsList.value =  [tabsList.value[0],tabsList.value[tabsActiveIndex.value]]
    }

    return {
      menuList, initMenu,clearMenuList,
        addMnes,
      isCollapse, changeIsCollapse, 
      openeds,
      initOpends,
      activeName, initActiveName,
      brendCrumbList, initBreadCrumbList,
      currentTagName,
      tabsList, initTabsList,
      addTabs,
      removeTabs,
      removeAllTabs,
      tabsNavTo,
      tabsActiveIndex,
      closeLeftNavTab,
      closeRightNavTab,
      closeOtherNavTab
    }
  },
  {
    persist: true,
  },
)
