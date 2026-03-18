
const pagesModule = import.meta.glob('@/pages/**/*.vue')
// utils/renderComponent.ts
import { createVNode, render} from 'vue'

// 后端传来的菜单构建动态路由
export const buildAsyncMenus = (menus: any) => {
    return menus.map((menu: any) => {
        // 如果有子菜单（无论数量多少）
        if (menu.children && menu.children.length > 0) {
            return {
                path: `/${menu.path || ''}`,
                name: menu.name,
                meta: {
                    title: menu.title,
                    icon: menu.icon,
                },
                children: buildAsyncMenus(menu.children),
            }
        } 
        // 没有子菜单的情况
        else {
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
}


// 数组转树

interface TreeNode {
    [key: string]: any;
    children?: TreeNode[];
}

interface TreeProps {
    id: string;
    parent_id: string;
    children: string;
}

// 数组转树函数
export const arrayToTree = (arrayData: TreeNode[], treeProps: TreeProps): TreeNode[] => {
    const { id, parent_id, children } = treeProps;

    // 创建映射表，用于快速查找节点
    const nodeMap = new Map<string, TreeNode>();
    const result: TreeNode[] = [];

    // 第一遍遍历：创建所有节点的映射
    arrayData.forEach(item => {
        const nodeId = item[id];
        nodeMap.set(nodeId, { ...item });
    });

    // 第二遍遍历：构建树结构
    arrayData.forEach(item => {
        const node = nodeMap.get(item[id])!;
        const parentId = item[parent_id];

        if (parentId) {
            const parentNode = nodeMap.get(parentId);
            if (parentNode) {
                if (!parentNode[children]) {
                    parentNode[children] = [];
                }
                parentNode[children].push(node);
            }
        } else {
            // 没有父节点，说明是根节点
            result.push(node);
        }
    });

    // 第三遍遍历：移除空的 children 数组
    const removeEmptyChildren = (node: TreeNode): TreeNode => {
        const newNode = { ...node };

        if (newNode[children] && Array.isArray(newNode[children])) {
            if (newNode[children].length === 0) {
                delete newNode[children];
            } else {
                // 递归处理子节点
                newNode[children] = newNode[children].map(removeEmptyChildren);
            }
        }

        return newNode;
    };

    return result.map(removeEmptyChildren);
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
            return {
                icon: (item.meta && item.meta.icon) || '',
                name: item.name,
                meta: meta,
            }
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

export const cloneDeep = <T>(value: T): T =>{
  if (value === null || typeof value !== 'object') {
    return value;
  }

  if (value instanceof Date) {
    return new Date(value.getTime()) as any;
  }

  if (Array.isArray(value)) {
    return value.map(item => cloneDeep(item)) as any;
  }

  const objCopy: any = {};
  for (const key in value) {
    if (Object.prototype.hasOwnProperty.call(value, key)) {
      objCopy[key] = cloneDeep((value as any)[key]);
    }
  }
  return objCopy;
}

export const debounce  = <T extends (...args: any[]) => void> (fn: T, delay = 300) => {
  let timer: number | undefined

  const debounced = (...args: Parameters<T>) => {
    if (timer) {
      clearTimeout(timer)
    }
    timer = window.setTimeout(() => {
      fn(...args)
    }, delay)
  }

  debounced.cancel = () => {
    if (timer) {
      clearTimeout(timer)
      timer = undefined
    }
  }

  return debounced as T & { cancel: () => void }
}


interface DayTimeRange {
  start: number;
  end: number;
}

interface MonthTimeRange {
  start: number;
  end: number;
}

interface TimeRangeObject {
  // 基础时间范围
  todayStart: number;
  todayEnd: number;
  today12End: number;
  monthStart: number;
  monthEnd: number;
  yearStart: number;
  yearEnd: number;
  weekStart: number;
  weekEnd: number;
  hourStart: number;
  hourEnd: number;
  
  // 历史时间范围
  yesterdayStart: number;
  yesterday12End: number;
  yesterdayEnd: number;
  lastMonthStart: number;
  lastMonthEnd: number;
  
  // 当前时间
  now: number;
  
  // 详细数据
  months: { [month: number]: MonthTimeRange };
  days: { [day: number]: DayTimeRange };
}

/**
 * 获取时间范围
 * @param {Date} date 日期对象 可以指定时间计算节点，默认使用当前时间进行计算
 * @param {number} targetTimezone 时区 默认东8区 正数代表东 负数代表西
 * @return {TimeRangeObject} timeObj
 */
export const getCommonTime = (date: Date = new Date(), targetTimezone: number = 8): TimeRangeObject => {
  // 创建日期对象的副本，避免修改原对象
  const baseDate = new Date(date);
  
  // 调整时区
  const adjustForTimezone = (d: Date): Date => {
    const timezoneOffset = d.getTimezoneOffset(); // 分钟
    const targetOffset = targetTimezone * 60; // 分钟
    const diff = timezoneOffset + targetOffset; // 分钟
    return new Date(d.getTime() + diff * 60 * 1000);
  };
  
  const currentDate = adjustForTimezone(baseDate);
  
  // 获取时间戳
  const getTimestamp = (d: Date): number => d.getTime();
  
  // 工具函数：设置时间
  const setTime = (
    d: Date, 
    hours: number = 0, 
    minutes: number = 0, 
    seconds: number = 0, 
    ms: number = 0
  ): Date => {
    const newDate = new Date(d);
    newDate.setHours(hours, minutes, seconds, ms);
    return newDate;
  };
  
  // 今日开始和结束
  const todayStart = getTimestamp(setTime(currentDate, 0, 0, 0, 0));
  const todayEnd = getTimestamp(setTime(currentDate, 23, 59, 59, 999));
  const today12End = getTimestamp(setTime(currentDate, 11, 59, 59, 999));
  
  // 当前小时开始和结束
  const hourStart = getTimestamp(setTime(currentDate, currentDate.getHours(), 0, 0, 0));
  const hourEnd = getTimestamp(setTime(currentDate, currentDate.getHours(), 59, 59, 999));
  
  // 本月开始和结束
  const monthStartDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
  const monthEndDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
  const monthStart = getTimestamp(setTime(monthStartDate, 0, 0, 0, 0));
  const monthEnd = getTimestamp(setTime(monthEndDate, 23, 59, 59, 999));
  
  // 本年开始和结束
  const yearStart = getTimestamp(setTime(new Date(currentDate.getFullYear(), 0, 1), 0, 0, 0, 0));
  const yearEnd = getTimestamp(setTime(new Date(currentDate.getFullYear(), 11, 31), 23, 59, 59, 999));
  
  // 本周开始和结束（周一到周日）
  const weekStartDate = new Date(currentDate);
  const dayOfWeek = currentDate.getDay() || 7; // 将周日(0)转换为7
  weekStartDate.setDate(currentDate.getDate() - dayOfWeek + 1);
  const weekEndDate = new Date(weekStartDate);
  weekEndDate.setDate(weekStartDate.getDate() + 6);
  const weekStart = getTimestamp(setTime(weekStartDate, 0, 0, 0, 0));
  const weekEnd = getTimestamp(setTime(weekEndDate, 23, 59, 59, 999));
  
  // 昨天开始和结束
  const yesterdayDate = new Date(currentDate);
  yesterdayDate.setDate(currentDate.getDate() - 1);
  const yesterdayStart = getTimestamp(setTime(yesterdayDate, 0, 0, 0, 0));
  const yesterdayEnd = getTimestamp(setTime(yesterdayDate, 23, 59, 59, 999));
  const yesterday12End = getTimestamp(setTime(yesterdayDate, 11, 59, 59, 999));
  
  // 上月开始和结束
  const lastMonthStartDate = new Date(currentDate.getFullYear(), currentDate.getMonth() - 1, 1);
  const lastMonthEndDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), 0);
  const lastMonthStart = getTimestamp(setTime(lastMonthStartDate, 0, 0, 0, 0));
  const lastMonthEnd = getTimestamp(setTime(lastMonthEndDate, 23, 59, 59, 999));
  
  // 本年度每月的开始和结束时间
  const months: { [month: number]: MonthTimeRange } = {};
  for (let i = 0; i < 12; i++) {
    const monthStart = getTimestamp(setTime(new Date(currentDate.getFullYear(), i, 1), 0, 0, 0, 0));
    const monthEnd = getTimestamp(setTime(new Date(currentDate.getFullYear(), i + 1, 0), 23, 59, 59, 999));
    months[i + 1] = { start: monthStart, end: monthEnd };
  }
  
  // 本月每天的开始和结束时间
  const days: { [day: number]: DayTimeRange } = {};
  const daysInMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getDate();
  for (let i = 1; i <= daysInMonth; i++) {
    const dayStart = getTimestamp(setTime(new Date(currentDate.getFullYear(), currentDate.getMonth(), i), 0, 0, 0, 0));
    const dayEnd = getTimestamp(setTime(new Date(currentDate.getFullYear(), currentDate.getMonth(), i), 23, 59, 59, 999));
    days[i] = { start: dayStart, end: dayEnd };
  }
  
  return {
    todayStart,
    todayEnd,
    today12End,
    monthStart,
    monthEnd,
    yearStart,
    yearEnd,
    weekStart,
    weekEnd,
    hourStart,
    hourEnd,
    yesterdayStart,
    yesterday12End,
    yesterdayEnd,
    lastMonthStart,
    lastMonthEnd,
    now: getTimestamp(currentDate),
    months,
    days
  };
}

// 动态渲染组件 - show=false 时自动卸载（挂载到 body，需包一层 ConfigProvider 才能拿到中文等全局配置）
import { ElConfigProvider } from 'element-plus'
import zhCn from 'element-plus/es/locale/lang/zh-cn'

export function renderComponent(Component :any, props = {}, container?:any) {
  const el = container || document.createElement('div')
  if (!container) document.body.appendChild(el)

  const state = reactive({
    visible: true
  })

  const destroy = () => {
    render(null, el)
    if (!container) el.remove()
  }

  const renderVNode = () => {
    const vnode = createVNode(ElConfigProvider, { locale: zhCn }, () =>
      createVNode(Component, {
        ...props,
        show: state.visible,
        'onUpdate:show': (val: boolean) => {
          state.visible = val
        },
        onClosed: destroy
      })
    )
    render(vnode, el)
  }

  // 👇 状态变 → 重新 render
  watch(() => state.visible, renderVNode, { immediate: true })

  return {
    close: () => {
      state.visible = false
    }
  }
}


// 单位转换
export const realUnitConversion = (unit: string | number | undefined): string | undefined => {
  if (unit == null || unit === '') return undefined;
  
  if (typeof unit === 'string') {
    // 检查字符串是否已经包含 CSS 单位
    const hasUnit = /^(auto|calc\(.*\)|[-+]?[\d.]+(px|rem|em|%|vw|vh|vmin|vmax|ex|ch|mm|cm|in|pt|pc))$/i.test(unit.trim());
    return hasUnit ? unit : unit; // 或者可以根据需要添加默认单位
  }
  
  // 数字默认添加 px 单位
  return `${unit}px`;
}
