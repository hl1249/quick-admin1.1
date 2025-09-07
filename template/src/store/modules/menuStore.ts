import { defineStore } from 'pinia'

import type { Ref } from 'vue'
import type { Routers } from '@/router/staticRouter'

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
  isCollapse: Ref<boolean>
  changeIsCollapse: (val: boolean) => void
    openeds: Ref<any[]>
  //   setOpeneds: (value: any[]) => void
    activeName: Ref<any>
  //   setActiveName: (name: string) => void
  //   setBreadCrumb: (to: any, route: any[]) => void
  //   brendCrumbList: Ref<any[]>
}

export const useMenuStore = defineStore(
  'menuConfig',
  (): MenuState => {

    const isCollapse = ref(true)
    const changeIsCollapse = () => {
      isCollapse.value = !isCollapse.value
    }


    const menuList:MenuState['menuList'] = ref([])
    const initMenu:MenuState['initMenu'] = (newMenuList) => {
      menuList.value = newMenuList
    }

    const openeds:MenuState['openeds'] = ref([])
    const activeName:MenuState['activeName'] = ref('')

    return {
      isCollapse, changeIsCollapse, menuList, initMenu,
      openeds,
      activeName
    }
  },
  {
    persist: true,
  },
)
