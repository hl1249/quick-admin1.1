export type BsonType =
  | 'string' | 'number' | 'int' | 'long' | 'decimal'
  | 'bool' | 'date' | 'objectId' | 'array' | 'object' | 'binData'

export type BsonTypeValue = BsonType | BsonType[]

export interface FieldTypeRule {
  minLength?: number
  maxLength?: number
  pattern?: string
  minimum?: number
  maximum?: number
}

export interface FieldDef {
  id: string
  key: string
  bsonType: BsonTypeValue
  description: string
  required: boolean
  typeRules?: Partial<Record<BsonType, FieldTypeRule>>
  // 兼容旧数据结构，打开已有字段时会迁移到 typeRules
  minLength?: number
  maxLength?: number
  pattern?: string
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
  | 'object-array-editor'

export type ConfigArrayFieldType =
  | 'text'
  | 'number'
  | 'switch'
  | 'select'

export type SwitchValueType = 'string' | 'number' | 'boolean'

export interface ConfigArrayField {
  key: string
  label: string
  type: ConfigArrayFieldType
  placeholder?: string
  options?: { value: string; label: string }[]
  default?: any
  uniqueTrue?: boolean
}

export interface ConfigField {
  key: string
  label: string
  type: ConfigFieldType
  placeholder?: string
  tip?: string
  options?: { value: string; label: string }[]
  default?: any
  addText?: string
  itemFields?: ConfigArrayField[]
  visibleWhen?: {
    key: string
    value: any
  }
}

export interface BuiltFieldSpec {
  bsonType?: BsonTypeValue
  anyOf?: Record<string, unknown>[]
  description?: string
}

/** select / radio / checkbox 的选项 data[].value 使用字符串或数字（影响生成代码中的字面量类型） */
export type OptionDataValueType = 'string' | 'number'

export function inferOptionDataValueType(data: unknown[] | undefined): OptionDataValueType {
  if (!Array.isArray(data) || !data.length) return 'string'
  const v = (data[0] as { value?: unknown })?.value
  return typeof v === 'number' && Number.isFinite(v) ? 'number' : 'string'
}

export function getOptionDataValueType(cfg: Record<string, any> | undefined): OptionDataValueType {
  if (!cfg) return 'string'
  if (cfg.dataValueType === 'number' || cfg.dataValueType === 'string') return cfg.dataValueType
  return inferOptionDataValueType(cfg.data)
}

export function coerceOptionDataValues(
  data: { value: unknown; label?: string }[] | undefined,
  valueType: OptionDataValueType,
): void {
  if (!Array.isArray(data)) return
  if (valueType === 'number') {
    for (const item of data) {
      const n = Number(item.value)
      item.value = Number.isFinite(n) ? n : 0
    }
  } else {
    for (const item of data) {
      item.value = item.value === undefined || item.value === null ? '' : String(item.value)
    }
  }
}

export function inferSwitchValueType(cfg: Record<string, any> | undefined): SwitchValueType {
  if (!cfg) return 'string'
  if (cfg.switchValueType === 'number' || cfg.switchValueType === 'string' || cfg.switchValueType === 'boolean') {
    return cfg.switchValueType
  }
  const sample = cfg.activeValue ?? cfg.inactiveValue
  if (typeof sample === 'number' && Number.isFinite(sample)) return 'number'
  if (typeof sample === 'boolean') return 'boolean'
  return 'string'
}

function coerceSingleSwitchValue(value: unknown, valueType: SwitchValueType): unknown {
  if (value === undefined || value === null || value === '') return value
  if (valueType === 'number') {
    const n = Number(value)
    return Number.isFinite(n) ? n : value
  }
  if (valueType === 'boolean') {
    if (typeof value === 'boolean') return value
    const normalized = String(value).trim().toLowerCase()
    if (['true', '1', 'yes', 'y'].includes(normalized)) return true
    if (['false', '0', 'no', 'n'].includes(normalized)) return false
    return value
  }
  return String(value)
}

export function coerceSwitchValues(cfg: Record<string, any> | undefined): void {
  if (!cfg) return
  const valueType = inferSwitchValueType(cfg)
  cfg.activeValue = coerceSingleSwitchValue(cfg.activeValue, valueType)
  cfg.inactiveValue = coerceSingleSwitchValue(cfg.inactiveValue, valueType)
}

export function isSwitchCustomValueEnabled(cfg: Record<string, any> | undefined): boolean {
  if (!cfg) return false
  if (typeof cfg.useCustomSwitchValue === 'boolean') return cfg.useCustomSwitchValue
  return cfg.activeValue !== undefined || cfg.inactiveValue !== undefined
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
  switch: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    {
      key: 'useCustomSwitchValue',
      label: '自定义激活值',
      type: 'switch',
      default: false,
      tip: '关闭时使用默认 true / false；开启后可自定义激活值和关闭值',
    },
    {
      key: 'switchValueType',
      label: '值类型',
      type: 'select',
      default: 'number',
      options: [
        { value: 'string', label: '字符串' },
        { value: 'number', label: '数字' },
        { value: 'boolean', label: '布尔值' },
      ],
      tip: '激活值 / 关闭值将按此类型输出到生成代码',
      visibleWhen: { key: 'useCustomSwitchValue', value: true },
    },
    { key: 'activeValue', label: '激活值', type: 'text', placeholder: '如 100 / Y / true', visibleWhen: { key: 'useCustomSwitchValue', value: true } },
    { key: 'inactiveValue', label: '关闭值', type: 'text', placeholder: '如 0 / N / false', visibleWhen: { key: 'useCustomSwitchValue', value: true } },
  ],
  rate: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择评分' },
    { key: 'max', label: '最大分值', type: 'number', default: 5 },
    { key: 'allowHalf', label: '允许半选', type: 'switch' },
  ],
  color: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择颜色' },
    { key: 'showAlpha', label: '透明度', type: 'switch' },
  ],
  slider: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入数值' },
    { key: 'min', label: '最小值', type: 'number', default: 0 },
    { key: 'max', label: '最大值', type: 'number', default: 100 },
    { key: 'step', label: '步长', type: 'number', default: 1 },
    { key: 'showInput', label: '显示输入框', type: 'switch' },
    { key: 'range', label: '范围选择', type: 'switch' },
  ],
  radio: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    {
      key: 'dataValueType',
      label: '选项 value 类型',
      type: 'select',
      default: 'string',
      options: [
        { value: 'string', label: '字符串' },
        { value: 'number', label: '数字' },
      ],
      tip: '切换后会把当前列表中的 value 转为对应类型',
    },
    { key: 'data', label: '选项列表', type: 'options-editor', tip: '配置 radio 的可选项' },
  ],
  checkbox: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    {
      key: 'dataValueType',
      label: '选项 value 类型',
      type: 'select',
      default: 'string',
      options: [
        { value: 'string', label: '字符串' },
        { value: 'number', label: '数字' },
      ],
      tip: '切换后会把当前列表中的 value 转为对应类型',
    },
    { key: 'data', label: '选项列表', type: 'options-editor', tip: '配置 checkbox 的可选项' },
  ],
  select: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    {
      key: 'dataValueType',
      label: '选项 value 类型',
      type: 'select',
      default: 'string',
      options: [
        { value: 'string', label: '字符串' },
        { value: 'number', label: '数字' },
      ],
      tip: '切换后会把当前列表中的 value 转为对应类型',
    },
    { key: 'multiple', label: '多选', type: 'switch' },
    { key: 'filterable', label: '可搜索', type: 'switch' },
    { key: 'data', label: '选项列表', type: 'options-editor', tip: '配置下拉选项' },
  ],
  'remote-select': [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    { key: 'action', label: '请求地址 (action)', type: 'route-select', placeholder: '请选择接口地址', tip: '可从系统路由中级联选择叶子接口，或手动输入地址' },
    { key: 'filterable', label: '可搜索', type: 'switch' },
    { key: 'propsValue', label: 'props.value 字段名', type: 'text', placeholder: '默认 value', tip: '返回数据中作为 value 的字段' },
    { key: 'propsLabel', label: 'props.label 字段名', type: 'text', placeholder: '默认 label', tip: '返回数据中作为 label 的字段' },
  ],
  cascader: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    { key: 'action', label: '请求地址 (action)', type: 'route-select', placeholder: '/api/xxx/tree', tip: '可从系统路由中级联选择叶子接口，或手动输入地址' },
    { key: 'propsList', label: '数据属性 (props.list)', type: 'text', placeholder: '默认 rows' },
    { key: 'propsValue', label: 'props.value 字段名', type: 'text', placeholder: '默认 value' },
    { key: 'propsLabel', label: 'props.label 字段名', type: 'text', placeholder: '默认 label' },
    { key: 'propsChildren', label: 'props.children 字段名', type: 'text', placeholder: '默认 children' },
    { key: 'lazy', label: '懒加载', type: 'switch' },
    { key: 'multiple', label: '多选', type: 'switch' },
  ],
  'tree-select': [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    { key: 'action', label: '请求地址 (action)', type: 'route-select', placeholder: '/api/xxx/tree', tip: '可从系统路由中级联选择叶子接口，或手动输入地址' },
    { key: 'propsList', label: '数据属性 (props.list)', type: 'text', placeholder: '默认 rows' },
    { key: 'propsValue', label: 'props.value 字段名', type: 'text', placeholder: '默认 value' },
    { key: 'propsLabel', label: 'props.label 字段名', type: 'text', placeholder: '默认 label' },
    { key: 'propsChildren', label: 'props.children 字段名', type: 'text', placeholder: '默认 children' },
  ],
  'table-select': [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择…' },
    { key: 'action', label: '请求地址 (action)', type: 'route-select', placeholder: '/api/xxx/page', tip: '可从系统路由中级联选择叶子接口，或手动输入地址' },
    {
      key: 'columns',
      label: '表格列配置',
      type: 'object-array-editor',
      default: [],
      addText: '添加表格列',
      tip: '配置弹窗表格展示列，可标记显示字段和取值字段',
      itemFields: [
        { key: 'key', label: '字段 key', type: 'text', placeholder: '字段 key' },
        { key: 'title', label: '列标题', type: 'text', placeholder: '列标题' },
        { key: 'nameKey', label: '显示名字段', type: 'switch', uniqueTrue: true },
        { key: 'idKey', label: '值字段', type: 'switch', uniqueTrue: true },
      ],
    },
    {
      key: 'queryColumns',
      label: '查询条件配置',
      type: 'object-array-editor',
      default: [],
      addText: '添加查询条件',
      tip: '配置表格弹窗顶部的搜索条件',
      itemFields: [
        { key: 'key', label: '字段 key', type: 'text', placeholder: '字段 key' },
        { key: 'title', label: '标题', type: 'text', placeholder: '标题' },
        {
          key: 'mode',
          label: '查询方式',
          type: 'select',
          options: [
            { value: '=', label: '= 完全匹配' },
            { value: '!=', label: '!= 不等于' },
            { value: '%%', label: '%% 模糊匹配' },
            { value: '%*', label: '%* 以 xxx 开头' },
            { value: '*%', label: '*% 以 xxx 结尾' },
            { value: '>', label: '> 大于' },
            { value: '>=', label: '>= 大于等于' },
            { value: '<', label: '< 小于' },
            { value: '<=', label: '<= 小于等于' },
            { value: 'in', label: 'in 在数组里' },
            { value: 'nin', label: 'nin 不在数组里' },
            { value: '[]', label: '[] 范围 arr[0] <= x <= arr[1]' },
            { value: '[)', label: '[) 范围 arr[0] <= x < arr[1]' },
            { value: '(]', label: '(] 范围 arr[0] < x <= arr[1]' },
            { value: '()', label: '() 范围 arr[0] < x < arr[1]' },
            { value: 'custom', label: 'custom 不自动参与 where 条件' },
          ],
        },
      ],
    },
    { key: 'multiple', label: '多选', type: 'switch' },
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
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择文件' },
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
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择素材' },
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
  icon: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择图标' },
  ],
  editor: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入内容…' },
  ],
  json: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入 JSON…' },
  ],
  tag: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '输入后回车添加' },
  ],
  address: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择地址' },
  ],
  'area-cascader': [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择地区' },
  ],
  map: [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请选择位置' },
  ],
  'array<string>': [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入内容' },
  ],
  'array<number>': [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入数值' },
  ],
  'array<object>': [
    { key: 'placeholder', label: '占位提示', type: 'text', placeholder: '请输入内容' },
  ],
}

export function getBsonTypeList(value: BsonTypeValue | null | undefined): BsonType[] {
  if (Array.isArray(value)) return [...new Set(value)]
  return value ? [value] : []
}

export function supportsStringRule(type: BsonType): boolean {
  return type === 'string'
}

export function supportsNumericRule(type: BsonType): boolean {
  return ['number', 'int', 'long', 'decimal'].includes(type)
}

export function supportsTypeRuleEditor(type: BsonType): boolean {
  return supportsStringRule(type) || supportsNumericRule(type)
}

export function ensureFieldTypeRules(field: FieldDef | null | undefined): Partial<Record<BsonType, FieldTypeRule>> {
  if (!field) return {}
  if (!field.typeRules) field.typeRules = {}

  for (const type of getBsonTypeList(field.bsonType)) {
    if (!field.typeRules[type]) field.typeRules[type] = {}
    const rule = field.typeRules[type]!
    if (supportsStringRule(type)) {
      if (rule.minLength === undefined && field.minLength !== undefined) rule.minLength = field.minLength
      if (rule.maxLength === undefined && field.maxLength !== undefined) rule.maxLength = field.maxLength
      if (rule.pattern === undefined && field.pattern !== undefined) rule.pattern = field.pattern
    }
    if (supportsNumericRule(type)) {
      if (rule.minimum === undefined && field.minimum !== undefined) rule.minimum = field.minimum
      if (rule.maximum === undefined && field.maximum !== undefined) rule.maximum = field.maximum
    }
  }

  return field.typeRules
}

export function getPrimaryBsonType(value: BsonTypeValue | null | undefined): BsonType {
  return getBsonTypeList(value)[0] ?? 'string'
}

export function normalizeBsonTypeValue(value: BsonTypeValue | null | undefined): BsonTypeValue {
  const types = getBsonTypeList(value)
  if (types.length <= 1) return types[0] ?? 'string'
  return types
}

export const getTypeDef = (bsonType: BsonType) =>
  TYPE_DEFS.find(t => t.bsonType === bsonType)!

export function formatBsonTypeLabel(value: BsonTypeValue | null | undefined): string {
  return getBsonTypeList(value).map(type => getTypeDef(type).label).join(' | ')
}

export const isNumericType = (t: BsonTypeValue) =>
  getBsonTypeList(t).some(type => ['number', 'int', 'long', 'decimal'].includes(type))

export const isStringType = (t: BsonTypeValue) => getBsonTypeList(t).includes('string')

function buildTypeRuleSpec(type: BsonType, rule: FieldTypeRule | undefined): Record<string, unknown> {
  const spec: Record<string, unknown> = { bsonType: type }
  if (supportsStringRule(type)) {
    if (rule?.minLength !== undefined) spec.minLength = rule.minLength
    if (rule?.maxLength !== undefined) spec.maxLength = rule.maxLength
    if (rule?.pattern) spec.pattern = rule.pattern
  }
  if (supportsNumericRule(type)) {
    if (rule?.minimum !== undefined) spec.minimum = rule.minimum
    if (rule?.maximum !== undefined) spec.maximum = rule.maximum
  }
  return spec
}

function typeSpecHasRule(spec: Record<string, unknown>): boolean {
  return Object.keys(spec).some(key => key !== 'bsonType')
}

export function buildFieldSpec(field: FieldDef): BuiltFieldSpec {
  const types = getBsonTypeList(field.bsonType)
  const typeRules = ensureFieldTypeRules(field)

  if (types.length > 1) {
    const anyOf = types.map(type => buildTypeRuleSpec(type, typeRules[type]))
    const built: BuiltFieldSpec = {}
    if (field.description) built.description = field.description
    if (anyOf.some(typeSpecHasRule)) {
      built.anyOf = anyOf
    } else {
      built.bsonType = normalizeBsonTypeValue(types)
    }
    return built
  }

  const type = types[0] ?? 'string'
  const built = buildTypeRuleSpec(type, typeRules[type]) as BuiltFieldSpec
  if (field.description) built.description = field.description
  return built
}
