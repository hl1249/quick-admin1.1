export class FieldQueryTemp {
  private ops: Record<string, any> = {};

  constructor(op?: string, value?: any) {
    if (op) {
      this.ops[op] = value;
    }
  }

  eq(value: any) {
    return new FieldQueryTemp('$eq', value);
  }
  neq(value: any) {
    return new FieldQueryTemp('$ne', value);
  }
  gt(value: any) {
    return new FieldQueryTemp('$gt', value);
  }
  gte(value: any) {
    return new FieldQueryTemp('$gte', value);
  }
  lt(value: any) {
    return new FieldQueryTemp('$lt', value);
  }
  lte(value: any) {
    return new FieldQueryTemp('$lte', value);
  }
  in(values: any[]) {
    return new FieldQueryTemp('$in', values);
  }
  nin(values: any[]) {
    return new FieldQueryTemp('$nin', values);
  }
  expr(value: any) {
    return new FieldQueryTemp('$expr', value);
  }
  exists(value: boolean) {
    return new FieldQueryTemp('$exists', value);
  }

  // dataJson 中的 _.remove() 操作
  remove() {
    return new FieldQueryTemp('$unset', '');
  }

  /**
   * and 支持两种用法：
   * 1. 同字段多条件合并，参数是多个 FieldQueryTemp 实例
   * 2. 跨字段条件组合，参数是数组，数组里可以是普通对象或 FieldQueryTemp
   */
  and(...args: FieldQueryTemp[]) {
    // 如果所有参数都是 FieldQueryTemp，合并ops（单字段多个条件）
    if (args.every(arg => arg instanceof FieldQueryTemp)) {
      for (const arg of args) {
        Object.assign(this.ops, arg.getOps());
      }
      return this;
    }
    // 否则返回逻辑组合
    return LogicQuery.and(args);
  }

  or(...args: FieldQueryTemp[]) {
    // or 不能合并，必须构造数组形式
    return LogicQuery.or([this, ...args]);
  }
  getOps() {
    return this.ops;
  }

  buildWithField(field: string) {
    // Special handling for $unset
    if ('$unset' in this.ops) {
      return { $unset: { [field]: this.ops['$unset'] } };
    }
    if ('$expr' in this.ops) {
    return { $expr: this.ops['$expr'] };
  }
    return { [field]: this.ops };
  }
}

class LogicQuery {
  static and(...args: any[]) {
    // 参数只有一个且是数组，直接用它
    const arr = args.length === 1 && Array.isArray(args[0]) ? args[0] : args;

    // 如果数组里有纯对象（非 FieldQueryTemp），说明是跨字段条件，生成 $and 包裹数组
    const hasPlainObject = arr.some(
      item => !(item instanceof FieldQueryTemp)
    );

    if (hasPlainObject) {
      return {
        $and: arr.map(item => {
          if (item instanceof FieldQueryTemp) {
            return item.getOps();
          }
          return item;
        }),
      };
    }

    // 如果全是 FieldQueryTemp，合并成一个对象（单字段多条件）
    const mergedOps: Record<string, any> = {};
    for (const item of arr) {
      Object.assign(mergedOps, item.getOps());
    }
    return mergedOps;
  }

  static or(...args: any[]) {
    // 参数只有一个且是数组，直接用它
    const arr = args.length === 1 && Array.isArray(args[0]) ? args[0] : args;

    // 如果数组里有纯对象（非 FieldQueryTemp），说明是跨字段条件，生成 $or 包裹数组
    const hasPlainObject = arr.some(
      item => !(item instanceof FieldQueryTemp)
    );

    if (hasPlainObject) {
      return {
        $or: arr.map(item => {
          if (item instanceof FieldQueryTemp) {
            return item.getOps();
          }
          return item;
        }),
      };
    }

    // 如果全是 FieldQueryTemp，合并成一个对象（单字段多条件）
    const mergedOps: Record<string, any> = {};
    for (const item of arr) {
      Object.assign(mergedOps, item.getOps());
    }
    return mergedOps;
  }
}

export const _ = {
  eq: (val: any) => new FieldQueryTemp('$eq', val),
  neq: (val: any) => new FieldQueryTemp('$ne', val),
  gt: (val: any) => new FieldQueryTemp('$gt', val),
  gte: (val: any) => new FieldQueryTemp('$gte', val),
  lt: (val: any) => new FieldQueryTemp('$lt', val),
  lte: (val: any) => new FieldQueryTemp('$lte', val),
  in: (vals: any[]) => new FieldQueryTemp('$in', vals),
  nin: (vals: any[]) => new FieldQueryTemp('$nin', vals),
  // 用于查出表中字段a等于字段b的数据
  expr: (val: any) => new FieldQueryTemp('$expr', val),
  // 用于判断字段是否存在
  exists: (val: boolean) => new FieldQueryTemp('$exists', val),
  // dataJson 中的 _.remove() 操作
  remove: () => ({ $unset: '' }), // 直接返回 $unset 操作
  // 这里用 rest 参数转发，支持两种写法
  and: (...args: any[]) => LogicQuery.and(...args),
  or: (...args: any[]) => LogicQuery.or(...args),
};