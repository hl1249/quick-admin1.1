// utils.service.ts
import { Injectable } from '@nestjs/common';

@Injectable()
export class UtilsService {
  someUtil() {
    return {
      text:'我是工具类的方法'
    };
  }

  treeToList(tree: any[], list: any[] = []): any[] {
    tree.forEach((node) => {
      list.push(node);
      if (node.children && node.children.length > 0) {
        this.treeToList(node.children, list);
      }
    });
    return list;
  }
}
