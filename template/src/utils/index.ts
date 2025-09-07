
const pagesModule = import.meta.glob('@/pages/**/*.vue')

// 后端传来的菜单构建动态路由
export const buildAsyncMenus = (menus: any) => {
    const routeMenu = menus.map((menu: any) => {

        if (menu.children && menu.children.length > 1) {
            return {
                path: `/${menu.path || ''}`,
                name: menu.name,
                meta: {
                    title: menu.title,
                    icon: menu.icon,
                },
                children: buildAsyncMenus(menu.children),
            }
        } else if (menu.children && menu.children.length === 1) {
            return {
                path: `/${menu.path || ''}`,
                name: menu.name,
                meta: {
                    title: menu.title,
                    icon: menu.icon,
                },
                children: buildAsyncMenus(menu.children),
            }
        } else {
            return {
                path: `/${menu.path}`,
                name: menu.name,
                icon: menu.icon,
                meta: {
                    title: menu.title,
                    icon: menu.icon,
                },
                component: pagesModule[menu.component + '.vue'],
            }
        }
    })

    return routeMenu
}


export const getBreadCrumbList = (route: any, homeRoute: any) => {
    let homeItem = { ...homeRoute, icon: homeRoute.meta.icon }
    let routeMetched = route.matched
    if (routeMetched.some((item: { name: any }) => item.name === homeRoute.name))
        return [homeItem]
    let res = routeMetched
        .filter((item: { name: undefined }) => {
            return item.name !== undefined
        })
        .map((item: { meta: { icon: any }; name: any }) => {
            let meta = { ...item.meta }
            let obj = {
                icon: (item.meta && item.meta.icon) || '',
                name: item.name,
                meta: meta,
            }

            return obj
        })
    return [{ ...homeItem, to: homeRoute.path }, ...res]
}


export const getHomeRoute = (routers: any[], homeName = 'home') => {
    let i = -1
    let len = routers.length
    let homeRoute = {}
    while (++i < len) {
        let item = routers[i]
        if (item.children && item.children.length) {
            let res: any = getHomeRoute(item.children, homeName)
            if (res.name) return res
        } else {
            if (item.name === homeName) homeRoute = item
        }
    }
    return homeRoute
}