
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


export const getHomeRoute = (routers: any[], homeName = 'home_page') => {
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

export const timeFormat = (date: Date | string | number, fmt = 'yyyy-MM-dd hh:mm:ss'): string => {
  if (!date) return "";

  if (!date) return "";

  // 确保传入的date是Date类型，如果是数字或字符串则转换为Date
  if (typeof date === 'number' || typeof date === 'string') {
    date = new Date(date);
  }

  // 确保date是有效的Date对象
  if (!(date instanceof Date) || isNaN(date.getTime())) {
    return "";
  }

  let nowDate = date;

  // 格式化选项
  let opt: { [key: string]: number | string } = {
    "M+": nowDate.getMonth() + 1, // 月份
    "d+": nowDate.getDate(), // 日
    "h+": nowDate.getHours(), // 小时
    "m+": nowDate.getMinutes(), // 分钟
    "s+": nowDate.getSeconds(), // 秒
    "q+": Math.floor((nowDate.getMonth() + 3) / 3), // 季度
    "S": nowDate.getMilliseconds(), // 毫秒
  };

  // 处理年份（特殊情况，年份可以是两位或四位）
  let regex = new RegExp("(y+)");
  let fmtMatch = fmt.match(regex);
  if (fmtMatch) {
    fmt = fmt.replace(fmtMatch[1], (nowDate.getFullYear() + "").substr(4 - fmtMatch[1].length));
  }

  // 遍历并替换格式中的其他部分（M、d、h、m、s、q、S）
  for (let k in opt) {
    let regex = new RegExp("(" + k + ")");
    let fmtMatch = fmt.match(regex);
    if (fmtMatch) {
      fmt = fmt.replace(fmtMatch[1],
        (fmtMatch[1].length == 1) ? (opt[k] as string) : (("00" + (opt[k] as string)).substr(("" + opt[k]).length))
      );
    }
  }

  return fmt;
};