// 排序规则
export interface SortRule {
  name: string; // 排序字段名
  type: 'desc' | 'asc'; // 排序方向：1 升序，-1 降序
}

// 聚合查询的外联配置
export interface ForeignDB {
  dbName: string;
  localKey: string;
  foreignKey: string;
  as: string;
  whereJson?: Record<string, any>;
  sortArr?: SortRule[];
  limit?: number;
  foreignDB?: ForeignDB[];
  addFields?: Record<string, any>;
  fieldJson?: Record<string, any>;
}

// 聚合查询分组配置
export interface GroupJson {
  _id: string;
  [key: string]: any;    
}


export interface AddParams {
  dbName: string;              // 必填，表名
  dataJson: Record<string, any>; // 必填，数据对象
  cancelAddTime?: boolean;     // 可选，取消自动生成 _add_time 和 _add_time_str 字段
  cancelAddTimeStr?: boolean;  // 可选，取消自动生成 _add_time_str 字段
  db?: any;                   // 可选，指定数据库实例，类型这里先用 any，或者你具体库的类型
}

export interface AddsParams {
  dbName: string;              // 必填，表名
  dataJson: Record<string, any>[]; // 必填，数据数组对象
  cancelAddTime?: boolean;     // 可选，取消自动生成 _add_time 和 _add_time_str 字段
  cancelAddTimeStr?: boolean;  // 可选，取消自动生成 _add_time_str 字段
  db?: any;
}

export interface DelParams {
  dbName: string;              // 必填，表名
  whereJson: Record<string, any>; // 必填，删除条件
  db?: any;
}

export interface DelByIdParams {
  dbName: string;              // 必填，表名
  id: string; // 必填，删除条件
  db?: any;
}
export interface FindById {
  dbName: string;              // 必填，表名
  id: string; // 必填，查询条件
  fieldJson?: Record<string, any>; // 可选，投影字段
  db?: any;                    // 可选，指定数据库实例
}

export interface FindByWhereJsonParams {
  dbName: string;              // 必填，表名
  whereJson: Record<string, any>; // 必填，查询条件
  fieldJson?: Record<string, any>; // 可选，投影字段
  db?: any;                    // 可选，指定数据库实例
}



export interface SelectsParams {
  dbName: string;              // 必填，表名
  whereJson?: Record<string, any>; // 可选，查询条件
  pageIndex?: number; // 可选，分页索引
  pageSize?: number; // 可选，分页大小
  getOne?: boolean; // 可选，排序
  getMain?: boolean; // 可选，是否只返回 rows 数据
  getCount?: boolean; // 必填，查询条件
  hasMore?: boolean; // 可选，是否有更多数据
  groupJson?: GroupJson; // 可选，分组字段
  sortArr?: SortRule[]; // 可选，排序
  foreignDB?: ForeignDB[]; // 可选，是否是外部数据库
  lastWhereJson?: Record<string, any>; // 可选，最后的查询条件
  lastSortArr?: SortRule[]; // 可选，最后的排序条件
  addFields?: Record<string, any>; // 可选，添加字段
  fieldJson?: Record<string, any>; // 可选，投影字段
  db?: any;                    // 可选，指定数据库实例
}


export interface SelectParams {
  dbName: string;              // 必填，表名
  getCount?: boolean; // 必填，查询条件
  hasMore?: boolean; // 可选，是否有更多数据
  getMain?: boolean; // 可选，是否只返回 rows 数据
  getOne?: boolean; // 可选，排序
  pageIndex?: number; // 可选，分页索引
  pageSize?: number; // 可选，分页大小
  whereJson?: Record<string, any>; // 可选，查询条件
  fieldJson?: Record<string, any>; // 可选，投影字段
  sortArr?: SortRule[]; // 可选，排序
  db?: any;                    // 可选，指定数据库实例
}

export interface CountParams {
  dbName: string;              // 必填，表名
  whereJson?: Record<string, any>; // 可选，查询条件
  foreignDB?: ForeignDB[]; // 可选，是否是外部数据库
  groupJson?: Record<string, any>; // 可选，分组字段
  lastWhereJson?: Record<string, any>; // 可选，最后的查询条件
  db?: any;                    // 可选，指定数据库实例
}

export interface SelectResult {
  rows: Document[]; // 查询结果数据
  count?: number; // 总记录数
  hasMore?: boolean; // 是否有更多数据
  total?: number; // 总记录数（如果有）
  getCount?: boolean; // 是否查询总数
  pagination?: {
    pageIndex: number; // 当前页码
    pageSize: number; // 每页大小
  },
  msg: string; // 可选，返回消息
  code: number; // 可选，返回状态码
}

export interface UpdateParams {
  dbName: string;              // 必填，表名
  whereJson: Record<string, any>; // 必填，查询条件
  dataJson?: Record<string, any>; // 可选，投影字段
  db?: any;
}

export interface UpdateByIdParams {
  dbName: string;              // 必填，表名
  id: string; // 必填，查询条件
  dataJson?: Record<string, any>; // 可选，投影字段
  db?: any;
}

export interface UpdateAndReturnParams {
  dbName: string;              // 必填，表名
  whereJson: Record<string, any>; // 必填，查询条件
  dataJson?: Record<string, any>; // 可选，投影字段
  db?: any;                    // 可选，指定数据库实例
}

export interface SetByIdParams {
  dbName: string;              // 必填，表名
  id: string;                  // 必填，查询条件
  dataJson?: Record<string, any>; // 可选，投影字段
  db?: any;                    // 可选，指定数据库实例
}