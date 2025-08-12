// db.types.ts
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


export  interface FindByWhereJsonParams  {
  dbName: string;              // 必填，表名
  whereJson: Record<string, any>; // 必填，查询条件
  fieldJson?: Record<string, any>; // 可选，投影字段
  sortArr?:  Record<string, any>[]; // 可选，排序
  db?: any;                    // 可选，指定数据库实例
}

export interface UpdateParams {
  dbName: string;              // 必填，表名
  whereJson: Record<string, any>; // 必填，查询条件
  dataJson?: Record<string, any>; // 可选，投影字段
  db?: any;      
}