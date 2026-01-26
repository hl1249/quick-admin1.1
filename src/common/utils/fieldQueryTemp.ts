import { MongoAggBuilder , CondExpr} from './utils.types'

// 常量定义
const COMPARISON_OPERATORS = ['gte', 'lte', 'gt', 'lt', 'eq', 'ne'] as const;
const LOGICAL_OPERATORS = ['and', 'or', 'not'] as const;

export class FieldQueryTemp {
  private ops: Record<string, any> = {};

  constructor(op?: string, value?: any) {
    if (op) {
      this.ops[op] = value;
    }
  }

  // Helper method to get the first operator and its value
  private getOperator(): { operator: string; value: any } {
    const operator = Object.keys(this.ops)[0];
    return { operator, value: this.ops[operator] };
  }


  /**
   * and 用于同字段多条件合并
   * 参数是多个 FieldQueryTemp 实例
   */
  and(...args: FieldQueryTemp[]) {
    for (const arg of args) {
      Object.assign(this.ops, arg.getOps());
    }
    return this;
  }

  or(...args: FieldQueryTemp[]) {
    // or 不能合并，必须构造数组形式
    return LogicQuery.or([this, ...args]);
  }
  getOps() {
    return this.ops;
  }

  buildWithField(field: string) {
  
    if ('$expr' in this.ops) {
      return { $expr: this.ops['$expr'] };
    }
    
    return { [field]: this.ops };
  }

  buildDataJsonWithField(field: string) {
    // // 处理 remove 操作
    if ('$unset' in this.ops) {
      return { $unset: field };
    }
    // 处理 push 操作
    if ('$push' in this.ops) {
      return { $push: { [field]: this.ops['$push'] } };
    }
    // 默认处理其他操作
    return { [field]: this.ops };
  }

  // 对于selects第一层里面AddFields转换
  buildAddFieldsWithField(field: string) {
    const { operator, value } = this.getOperator();

    // 处理带点号的路径（如 'roles.sex'）
    if (field.includes('.')) {
      const [arrayField, nestedField] = field.split('.');
      return {
        $anyElementTrue: {
          $map: {
            input: `$${arrayField}`,  // 输入数组字段
            as: "r",                 // 别名
            in: {
              [operator]: [`$$r.${nestedField}`, value]  // 应用操作符到嵌套字段
            }
          }
        }
      };
    }

    // 默认处理简单字段
    return {
      $anyElementTrue: {
        $map: {
          input: `$${field}`,
          as: "item",
          in: { [operator]: ["$$item", value] }
        }
      }
    };
  }

  // 对于selects里Foreign层里面AddFields转换
  buildForeignAddFieldsWithField(field: string) {
    const { operator, value } = this.getOperator();
    return {
      [operator]: [`$${field}`, value]
    };
  }

  // 对于selects里Foreign层里面WhereJson转换
  buildForeignWhereJsonWithField(field: string) {
    if ('$expr' in this.ops) {
      return { $expr: this.ops['$expr'] };
    }

    const { operator, value } = this.getOperator();
    return {
      [operator]: [`$${field}`, value]
    };
  }
}

class LogicQuery {
  // 提取公共逻辑，减少代码重复
  private static buildLogicQuery(operator: '$and' | '$or', ...args: any[]) {
    const arr = args.length === 1 && Array.isArray(args[0]) ? args[0] : args;
    const hasPlainObject = arr.some(item => !(item instanceof FieldQueryTemp));

    if (hasPlainObject) {
      return {
        [operator]: arr.map(item =>
          item instanceof FieldQueryTemp ? item.getOps() : item
        ),
      };
    }

    const mergedOps: Record<string, any> = {};
    for (const item of arr) {
      Object.assign(mergedOps, item.getOps());
    }
    return mergedOps;
  }

  static and(...args: any[]) {
    return this.buildLogicQuery('$and', ...args);
  }

  static or(...args: any[]) {
    return this.buildLogicQuery('$or', ...args);
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
  // remove: () => ({ $unset: '' }), // 直接返回 $unset 操作
  remove: () => new FieldQueryTemp('$unset', ''),
  // push 操作
  push: (vals: any) => new FieldQueryTemp('$push', vals),
  // 这里用 rest 参数转发，支持两种写法
  and: (...args: any[]) => LogicQuery.and(...args),
  or: (...args: any[]) => LogicQuery.or(...args),
};

export const $: MongoAggBuilder = new Proxy({} as MongoAggBuilder, {
  get(target, prop: string) {
    // 处理特殊操作符（如 cond 需要特殊结构）
    if (prop === 'cond') {
      return ({ if: condition, then: thenExpr, else: elseExpr }: CondExpr) => ({
        $cond: { if: condition, then: thenExpr, else: elseExpr }
      });
    }

    // 处理 arrayElemAt 操作符
    if (prop === 'arrayElemAt') {
      return (arrOrFirstArg: unknown[] | unknown, index?: number) => {
        // 处理两种调用方式：
        // 1. $.arrayElemAt(['$arr', 0])
        // 2. $.arrayElemAt('$arr', 0)
        const args = index !== undefined
          ? [arrOrFirstArg, index]
          : arrOrFirstArg;
        return { $arrayElemAt: args };
      };
    }


    // 处理比较操作符（如 gte, lte 等）
    if (COMPARISON_OPERATORS.includes(prop as any)) {
      return (expr: unknown | unknown[]) => {
        // 如果传入的是数组，直接使用；否则包装成数组
        const args = Array.isArray(expr) ? expr : [expr];
        return { [`$${prop}`]: args };
      };
    }

    // 处理逻辑操作符（如 and, or, not）
    if (LOGICAL_OPERATORS.includes(prop as any)) {
      return (expr: unknown) => ({ [`$${prop}`]: expr });
    }

    // 默认处理：累加器操作符（如 sum, avg, first 等）
    return (expr: unknown) => ({ [`$${prop}`]: expr });
  }
});