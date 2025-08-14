// utils.service.ts
import { Injectable } from '@nestjs/common';

@Injectable()
export class UtilsService {
  treeToList(tree: any[], list: any[] = []): any[] {
    tree.forEach((node) => {
      list.push(node);
      if (node.children && node.children.length > 0) {
        this.treeToList(node.children, list);
      }
    });
    return list;
  }

  formatTimestamp(date: Date | string | number, fmt = 'yyyy-MM-dd hh:mm:ss'): string {
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
}


