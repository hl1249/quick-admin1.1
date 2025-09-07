export const treeToList = (tree: any[], list: any[] = []): any[] => {
    tree.forEach((node) => {
        list.push(node);
        if (node.children && node.children.length > 0) {
            treeToList(node.children, list);
        }
    });
    return list;
}

export const formatTimestamp = (date: Date | string | number, fmt = 'yyyy-MM-dd hh:mm:ss'): string => {
    if (!date) return "";
    let nowDate = new Date(date);

    const opt: { [key: string]: number } = {
        "M+": nowDate.getMonth() + 1,                 // 月份
        "d+": nowDate.getDate(),                      // 日
        "h+": nowDate.getHours(),                     // 小时
        "m+": nowDate.getMinutes(),                   // 分钟
        "s+": nowDate.getSeconds(),                   // 秒
        "q+": Math.floor((nowDate.getMonth() + 3) / 3), // 季度
        "S": nowDate.getMilliseconds()                // 毫秒
    };

    // 处理年份
    fmt = fmt.replace(/(y+)/g, (match) => {
        return (nowDate.getFullYear() + "").substr(4 - match.length);
    });

    // 处理其他格式
    for (let k in opt) {
        fmt = fmt.replace(new RegExp("(" + k + ")", "g"), (match) => {
            return match.length === 1 ? opt[k].toString() : ("00" + opt[k]).substr(opt[k].toString().length);
        });
    }

    return fmt;
}


export const sleep = (duration: number = 1000): Promise<void> => {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve()
        }, duration)
    })
}

// 过滤对象属性 let obj = {a:1,b:2}  filterObject(obj,'a',false) => {b:2}
export const filterObject = <T extends Record<string, any>>(
    obj: T,
    keys: (keyof T)[],
    include: boolean
): Partial<T> => {
    const result = {} as Partial<T>;

    for (const key in obj) {
        if (Object.prototype.hasOwnProperty.call(obj, key)) {
            const typedKey = key as keyof T;
            if ((include && keys.includes(typedKey)) || (!include && !keys.includes(typedKey))) {
                result[typedKey] = obj[typedKey];
            }
        }
    }

    return result;
}



interface TreeNode {
    [key: string]: any;
    children?: TreeNode[];
}

interface TreeProps {
    id: string;
    parent_id: string;
    children: string;
}

// 数组转树
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