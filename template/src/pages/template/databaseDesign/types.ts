export type BsonType =
  | 'string' | 'number' | 'int' | 'long' | 'decimal'
  | 'bool' | 'date' | 'objectId' | 'array' | 'object' | 'binData'

export interface FieldDef {
  id: string
  key: string
  bsonType: BsonType
  description: string
  required: boolean
  minLength?: number
  maxLength?: number
  pattern?: string
  enumStr?: string
  minimum?: number
  maximum?: number
  formType?: string
  formConfig?: Record<string, any>
}

export interface TypeDef {
  bsonType: BsonType
  label: string
  icon: string
  color: string
  desc: string
}

export interface FormTypeDef {
  value: string
  label: string
  group: string
}

export type ConfigFieldType =
  | 'text'
  | 'number'
  | 'switch'
  | 'select'
  | 'options-editor'
  | 'route-select'

export interface ConfigField {
  key: string
  label: string
  type: ConfigFieldType
  placeholder?: string
  tip?: string
  options?: { value: string; label: string }[]
  default?: any
}

export const TYPE_DEFS: TypeDef[] = [
  { bsonType: 'string',   label: 'String',   icon: 'T',  color: '#409EFF', desc: '文本字符串' },
  { bsonType: 'int',      label: 'Int32',    icon: '①',  color: '#67C23A', desc: '32位整数' },
  { bsonType: 'long',     label: 'Int64',    icon: 'L',  color: '#67C23A', desc: '64位整数' },
  { bsonType: 'number',   label: 'Double',   icon: '#',  color: '#E6A23C', desc: '双精度浮点' },
  { bsonType: 'decimal',  label: 'Decimal',  icon: 'D',  color: '#E6A23C', desc: '高精度小数' },
  { bsonType: 'bool',     label: 'Boolean',  icon: '✓',  color: '#909399', desc: '布尔值' },
  { bsonType: 'date',     label: 'Date',     icon: '📅', color: '#F56C6C', desc: '日期时间' },
  { bsonType: 'objectId', label: 'ObjectId', icon: '🔑', color: '#B39DDB', desc: 'MongoDB ID' },
  { bsonType: 'array',    label: 'Array',    icon: '[]', color: '#26C6DA', desc: '数组' },
  { bsonType: 'object',   label: 'Object',   icon: '{}', color: '#FF8A65', desc: '嵌套对象' },
  { bsonType: 'binData',  label: 'BinData',  icon: '⬛', color: '#78909C', desc: '二进制数据' },
]

export const FORM_TYPE_GROUPS: { name: string; types: FormTypeDef[] }[] = [
  {
    name: '基础输入',
    types: [
      { value: 'text', label: '文本输入', group: '基础输入' },
      { value: 'number', label: '数字输入', group: '基础输入' },
      { value: 'password', label: '密码输入', group: '基础输入' },
      { value: 'textarea', label: '多行文本', group: '基础输入' },
    ],
  },
  {
    name: '选择类',
    types: [
      { value: 'select', label: '下拉选择', group: '选择类' },
      { value: 'radio', label: '单选', group: '选择类' },
      { value: 'checkbox', label: '多选', group: '选择类' },
    ],
  },
  {
    name: '远程请求',
    types: [
      { value: 'remote-select', label: '远程搜索选择', group: '远程请求' },
      { value: 'cascader', label: '级联选择', group: '远程请求' },
      { value: 'tree-select', label: '树选择', group: '远程请求' },
      { value: 'table-select', label: '表格选择', group: '远程请求' },
    ],
  },
  {
    name: '日期 / 时间',
    types: [
      { value: 'date', label: '日期', group: '日期 / 时间' },
      { value: 'datetimerange', label: '日期时间范围', group: '日期 / 时间' },
      { value: 'time', label: '时间', group: '日期 / 时间' },
    ],
  },
  {
    name: '开关 / 滑块',
    types: [
      { value: 'switch', label: '开关', group: '开关 / 滑块' },
      { value: 'slider', label: '滑块', group: '开关 / 滑块' },
      { value: 'rate', label: '评分', group: '开关 / 滑块' },
    ],
  },
  {
    name: '文件 / 媒体',
    types: [
      { value: 'file', label: '文件上传', group: '文件 / 媒体' },
      { value: 'file-select', label: '素材选择', group: '文件 / 媒体' },
      { value: 'icon', label: '图标选择', group: '文件 / 媒体' },
      { value: 'color', label: '颜色选择', group: '文件 / 媒体' },
    ],
  },
  {
    name: '高级',
    types: [
      { value: 'editor', label: '富文本编辑器', group: '高级' },
      { value: 'json', label: 'JSON 编辑器', group: '高级' },
      { value: 'tag', label: '标签输入', group: '高级' },
      { value: 'address', label: '地址选择', group: '高级' },
      { value: 'map', label: '地图选择', group: '高级' },
    ],
  },
  {
    name: '数组类',
    types: [
      { value: 'array<string>', label: '字符串数组', group: '数组类' },
      { value: 'array<number>', label: '数字数组', group: '数组类' },
      { value: 'array<object>', label: '对象数组', group: '数组类' },
    ],
  },
]

export const FORM_TYPE_CONFIG: Record<string, ConfigField[]> = {
  text: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入…' },
  ],
  number: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入…' },
    { key: 'min', label: '最小值', type: 'number' },
    { key: 'max', label: '最大值', type: 'number' },
    { key: 'step', label: '步长', type: 'number', default: 1 },
    { key: 'precision', label: '精度（小数位数）', type: 'number' },
  ],
  password: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入密码' },
  ],
  textarea: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入…' },
    { key: 'rows', label: '行数', type: 'number', default: 3 },
  ],
  switch: [],
  rate: [
    { key: 'max', label: '最大分值', type: 'number', default: 5 },
    { key: 'allowHalf', label: '允许半选', type: 'switch' },
  ],
  color: [
    { key: 'showAlpha', label: '透明度', type: 'switch' },
  ],
  slider: [
    { key: 'min', label: '最小值', type: 'number', default: 0 },
    { key: 'max', label: '最大值', type: 'number', default: 100 },
    { key: 'step', label: '步长', type: 'number', default: 1 },
    { key: 'showInput', label: '显示输入框', type: 'switch' },
    { key: 'range', label: '范围选择', type: 'switch' },
  ],
  radio: [
    { key: 'data', label: '选项列表', type: 'options-editor', tip: '配置 radio 的可选项' },
  ],
  checkbox: [
    { key: 'data', label: '选项列表', type: 'options-editor', tip: '配置 checkbox 的可选项' },
  ],
  select: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    { key: 'multiple', label: '多选', type: 'switch' },
    { key: 'filterable', label: '可搜索', type: 'switch' },
    { key: 'data', label: '选项列表', type: 'options-editor', tip: '配置下拉选项' },
  ],
  'remote-select': [
    { key: 'action', label: '请求地址 (action)', type: 'route-select', placeholder: '/api/xxx/list', tip: '可从系统路由中级联选择叶子接口，或手动输入地址' },
    { key: 'filterable', label: '可搜索', type: 'switch' },
    { key: 'propsValue', label: 'props.value 字段名', type: 'text', placeholder: '默认 value', tip: '返回数据中作为 value 的字段' },
    { key: 'propsLabel', label: 'props.label 字段名', type: 'text', placeholder: '默认 label', tip: '返回数据中作为 label 的字段' },
  ],
  cascader: [
    { key: 'action', label: '请求地址 (action)', type: 'route-select', placeholder: '/api/xxx/tree', tip: '可从系统路由中级联选择叶子接口，或手动输入地址' },
    { key: 'propsValue', label: 'props.value 字段名', type: 'text', placeholder: '默认 value' },
    { key: 'propsLabel', label: 'props.label 字段名', type: 'text', placeholder: '默认 label' },
    { key: 'propsChildren', label: 'props.children 字段名', type: 'text', placeholder: '默认 children' },
    { key: 'lazy', label: '懒加载', type: 'switch' },
    { key: 'multiple', label: '多选', type: 'switch' },
  ],
  'tree-select': [
    { key: 'action', label: '请求地址 (action)', type: 'route-select', placeholder: '/api/xxx/tree', tip: '可从系统路由中级联选择叶子接口，或手动输入地址' },
    { key: 'propsValue', label: 'props.value 字段名', type: 'text', placeholder: '默认 value' },
    { key: 'propsLabel', label: 'props.label 字段名', type: 'text', placeholder: '默认 label' },
    { key: 'propsChildren', label: 'props.children 字段名', type: 'text', placeholder: '默认 children' },
  ],
  'table-select': [
    { key: 'action', label: '请求地址 (action)', type: 'route-select', placeholder: '/api/xxx/page', tip: '可从系统路由中级联选择叶子接口，或手动输入地址' },
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择' },
    { key: 'title', label: '弹窗标题', type: 'text', placeholder: '选择数据' },
    { key: 'multiple', label: '多选', type: 'switch' },
    { key: 'pageSize', label: '每页条数', type: 'number', default: 10 },
  ],
  date: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择日期' },
    { key: 'dateType', label: '日期类型', type: 'select', options: [
      { value: 'date', label: '日期 date' },
      { value: 'datetime', label: '日期时间 datetime' },
      { value: 'year', label: '年 year' },
      { value: 'month', label: '月 month' },
      { value: 'week', label: '周 week' },
    ]},
    { key: 'format', label: '显示格式', type: 'text', placeholder: 'YYYY-MM-DD' },
    { key: 'valueFormat', label: '值格式', type: 'text', placeholder: 'YYYY-MM-DD', tip: '如 x 为时间戳' },
  ],
  datetimerange: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择时间范围' },
    { key: 'dateType', label: '日期类型', type: 'select', options: [
      { value: 'datetimerange', label: '日期时间范围' },
      { value: 'daterange', label: '日期范围' },
      { value: 'monthrange', label: '月份范围' },
    ]},
    { key: 'format', label: '显示格式', type: 'text', placeholder: 'YYYY-MM-DD HH:mm:ss' },
    { key: 'valueFormat', label: '值格式', type: 'text', placeholder: 'x', tip: '如 x 为时间戳' },
  ],
  time: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择时间' },
  ],
  file: [
    { key: 'multiple', label: '多文件', type: 'switch' },
    { key: 'limit', label: '最大文件数', type: 'number' },
    { key: 'fileSize', label: '文件大小限制', type: 'number' },
    { key: 'sizeUnit', label: '大小单位', type: 'select', default: 'MB', options: [
      { value: 'KB', label: 'KB' },
      { value: 'MB', label: 'MB' },
      { value: 'GB', label: 'GB' },
    ]},
    { key: 'buttonText', label: '按钮文字', type: 'text', placeholder: '点击上传' },
    { key: 'autoUpload', label: '自动上传', type: 'switch', default: true },
  ],
  'file-select': [
    { key: 'fileType', label: '文件类型', type: 'select', options: [
      { value: 'image', label: '图片' },
      { value: 'video', label: '视频' },
      { value: 'other', label: '其他' },
    ]},
    { key: 'multiple', label: '多选', type: 'switch' },
    { key: 'multipleLimit', label: '多选上限', type: 'number' },
    { key: 'returnType', label: '返回类型', type: 'select', default: 'url', options: [
      { value: 'url', label: 'URL 地址' },
      { value: 'id', label: '文件 ID' },
    ]},
    { key: 'fileSize', label: '文件大小限制', type: 'number' },
    { key: 'sizeUnit', label: '大小单位', type: 'select', default: 'MB', options: [
      { value: 'KB', label: 'KB' },
      { value: 'MB', label: 'MB' },
      { value: 'GB', label: 'GB' },
    ]},
  ],
  icon: [],
  editor: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入内容…' },
  ],
  json: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入 JSON…' },
  ],
  tag: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '输入后回车添加' },
  ],
  address: [],
  'area-cascader': [],
  map: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择位置' },
  ],
  'array<string>': [],
  'array<number>': [],
  'array<object>': [],
}

export const getTypeDef = (bsonType: BsonType) =>
  TYPE_DEFS.find(t => t.bsonType === bsonType)!

export const isNumericType = (t: BsonType) =>
  ['number', 'int', 'long', 'decimal'].includes(t)

export const isStringType = (t: BsonType) => t === 'string'
