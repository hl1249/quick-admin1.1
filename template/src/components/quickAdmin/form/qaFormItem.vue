<script lang="tsx">
// Vue
import { defineComponent, type PropType } from 'vue'
import type { JSX } from 'vue/jsx-runtime'

// Element Plus
import type { FormItemRule } from 'element-plus'
import { CircleClose } from '@element-plus/icons-vue'
import * as ElIcons from '@element-plus/icons-vue'

// 内部组件类型
import type { QueryColumns } from '../table/qaTableQuery.vue'
import type { Columns } from '../table/qaTable.vue'

// 工具 / HTTP
import { realUnitConversion } from '@/utils'

/** 仅克隆 path 经过的节点，其余引用保持不变，避免整表深拷贝导致子组件反复同步触发递归更新 */
function setByPathImmutable(root: Record<string, any>, path: string, value: any): Record<string, any> {
  const parts = path.split('.').filter(Boolean)
  if (parts.length === 0) return { ...root }

  const walk = (node: any, i: number): any => {
    const key = parts[i]
    const isLast = i === parts.length - 1
    if (isLast) {
      if (Array.isArray(node)) {
        const idx = Number(key)
        const next = [...node]
        next[idx] = value
        return next
      }
      return { ...node, [key]: value }
    }
    const child = Array.isArray(node) ? node[Number(key)] : node?.[key]
    const nextSeg = parts[i + 1]
    const emptyChild = nextSeg !== undefined && /^\d+$/.test(nextSeg) ? [] : {}
    const clonedChild = walk(child ?? emptyChild, i + 1)
    if (Array.isArray(node)) {
      const idx = Number(key)
      const next = [...node]
      next[idx] = clonedChild
      return next
    }
    return { ...node, [key]: clonedChild }
  }

  return walk(root, 0) as Record<string, any>
}

/** 日期选择器 pickerOptions */
interface DatePickerOptions {
  defaultTime?: (string | Date)[]
  shortcuts?: { text: string; value: () => void | Date | [Date, Date] }[]
}

/** 选项项（radio/select/tag 等；与 qaTable Columns.data 的 Data 对齐，label 可缺省） */
interface OptionItem {
  value: any
  label?: string
  [key: string]: any
}

/** 树 defaultProps */
interface TreeDefaultProps {
  value?: string
  label?: string
  children?: string
  list?: string
  desc?: 'asc' | 'desc'
  lazy?: boolean
  multiple?: boolean
}

/** 渲染器入参 */
interface RendererParams {
  value: any
  label?: string
  placeholder?: string
  title?: string
  onChange: (val: any) => void
  width?: string | number
  data?: OptionItem[]
  actionData?: Record<string, any>
  dateType?: string
  format?: string
  valueFormat?: string
  pickerOptions?: DatePickerOptions

  columns: Columns[]
  enable: boolean
  formData: Record<string, any>
  queryColumns: QueryColumns[]
  multiple: boolean
  pageSize: number

  nameKey?: string
  idKey?: string

  limit?: number
  uploadProps?: Record<string, any>
  fileSize?: number
  sizeUnit?: 'KB' | 'MB' | 'GB'
  buttonText?: string
  categoryId?: string
  needSave?: boolean
  autoUpload?: boolean
  tempFileType?: 'tempPath' | 'base64'
  httpRequest?: (file: File) => Promise<string>

  action?: string
  itemProps?: TreeDefaultProps
  fileType?: string
  multipleLimit?: number
  defaultCategory?: string
  upload?: boolean
  updateCategory?: boolean
  imageFit?: string
  returnType?: 'url' | 'id'
}

export default defineComponent({
  name: 'qaFormItem',
  props: {
    action: String,
    props: Object as PropType<TreeDefaultProps>,
    modelValue: {
      type: Object as PropType<Record<string, any>>,
      default: () => ({}),
    },
    formType: String,
    label: String,
    title: String,
    itemKey: {
      type: String,
      required: true,
    },
    type: String,
    placeholder: String,
    tips: String,
    showLabel: {
      type: Boolean,
      default: true,
    },
    labelWidth: {
      type: [String, Number],
      default: '80px',
    },
    width: {
      type: [String, Number],
      default: '100%',
    },
    data: [Array, Function] as PropType<OptionItem[] | (() => OptionItem[])>,
    dateType: String,
    valueFormat: String,
    format: String,
    pickerOptions: Object as PropType<DatePickerOptions>,

    columns: Array as PropType<Columns[]>,
    enable: Boolean,
    formData: Object as PropType<Record<string, any>>,
    queryColumns: Array as PropType<QueryColumns[]>,
    multiple: Boolean,
    pageSize: Number,
    nameKey: String,
    idKey: String,
    limit: Number,
    uploadProps: Object as PropType<Record<string, any>>,
    fileSize: Number,
    sizeUnit: { type: String as PropType<'KB' | 'MB' | 'GB'>, default: 'MB' },
    buttonText: String,
    categoryId: String,
    needSave: Boolean,
    autoUpload: { type: Boolean, default: true },
    tempFileType: String as PropType<'tempPath' | 'base64'>,
    httpRequest: Function as PropType<(file: File) => Promise<string>>,
    actionData: [Object, Function] as PropType<Record<string, any> | (() => Record<string, any>)>,
    filterable: Boolean,
    fileType: String as PropType<'image' | 'video' | 'other'>,
    multipleLimit: Number,
    defaultCategory: String,
    upload: { type: Boolean, default: true },
    updateCategory: { type: Boolean, default: true },
    imageFit: { type: String as PropType<'fill' | 'contain' | 'cover' | 'none' | 'scale-down'>, default: 'cover' },
    returnType: { type: String as PropType<'url' | 'id'>, default: 'url' },
    defaultLocation: Object as PropType<{ latitude: number; longitude: number }>,

    show: Array as PropType<string[]>,
    showRule: [Function, String] as PropType<((model: Record<string, any>) => boolean) | string>,
    disabled: [Function, String] as PropType<((model: Record<string, any>) => boolean) | string>,
    watch: Function as PropType<(val: any, ...args: any[]) => void>,
    rules: [Object, Array] as PropType<FormItemRule | FormItemRule[]>,

    /** array<object> 等扩展配置（由列配置透传） */
    defaultValue: Object as PropType<Record<string, any>>,
    showAdd: Boolean,
    showClear: Boolean,
    showSort: Boolean,
    rightBtns: Array as PropType<string[]>,
    itemWidth: [String, Number],
  },
  emits: {
    'update:modelValue': (val: Record<string, unknown>) => true,
    'update:formData': (val: Record<string, unknown>) => true,
    'search': () => true,
  },
  setup(props, { emit, slots }) {
    /* ---------------- v-model ---------------- */
    const { formType, showRule, disabled } = toRefs(props)

    const getByPath = (obj: Record<string, any> | undefined, path: string): any => {
      if (!obj || path == null || path === '') return undefined
      if (!path.includes('.')) return obj[path]
      return path.split('.').reduce((o: any, k) => (o == null ? undefined : o[k]), obj)
    }

    const currentValue = computed({
      get: () => getByPath(props.modelValue, props.itemKey),
      set: (v) => {
        const base = props.modelValue ?? {}
        const prev = getByPath(base, props.itemKey)
        if (Object.is(v, prev)) return
        if (props.itemKey.includes('.')) {
          emit('update:modelValue', setByPathImmutable(base, props.itemKey, v))
          return
        }
        emit('update:modelValue', { ...base, [props.itemKey]: v })
      },
    })

    /** 点路径多为行内叶子字段：deep 会在兄弟字段 patch 整行时反复触发 user watch */
    const watchDeep = !props.itemKey.includes('.')

    watch(
      () => getByPath(props.modelValue, props.itemKey),
      (val, oldVal) => {
        if (!props.watch) return
        if (props.itemKey.includes('.') && Object.is(val, oldVal)) return
        props.watch(val)
      },
      { deep: watchDeep, flush: 'post' }
    )

    /* ---------------- 通用逻辑（computed 缓存，避免重复计算） ---------------- */

    const resolvedWidth = computed(() => realUnitConversion(props.width))

    /** 支持操作符：==  != */
    const evalStringExpr = (expr: string, model: Record<string, any> | undefined): boolean | null => {
      const match = expr.match(/^(\w+)\s*(==|!=)\s*(.+)$/)
      if (!match) return null
      const [, key, op, value] = match
      const actual = model?.[key]
      if (op === '==') return actual == value
      if (op === '!=') return actual != value
      return null
    }

    const isShow = computed(() => {
      if (formType.value === 'query') return true
      if (!props.show) return true
      return formType.value != null && props.show.includes(formType.value)
    })

    const isShowRule = computed(() => {
      if (typeof showRule.value === 'function') {
        return showRule.value(props.modelValue)
      }
      if (typeof showRule.value === 'string') {
        const result = evalStringExpr(showRule.value, props.modelValue)
        return result ?? true
      }
      return true
    })

    const isDisabled = computed(() => {
      if (typeof disabled.value === 'function') {
        return !!disabled.value(props.modelValue)
      }
      if (typeof disabled.value === 'string') {
        const result = evalStringExpr(disabled.value, props.modelValue)
        return result ?? false
      }
      return false
    })

    /* ---------------- renderers ---------------- */

    const renderText = (p: RendererParams) => (
      <el-input
        modelValue={p.value}
        clearable
        disabled={isDisabled.value}
        placeholder={p.placeholder || `请输入${p.label}`}
        style={{ width: resolvedWidth.value }}
        onUpdate:modelValue={p.onChange}
        onClear={() => emit('search')}
      />
    )

    const renderNumber = (p: RendererParams) => (
      <el-input-number
        modelValue={p.value}
        disabled={isDisabled.value}
        placeholder={p.placeholder || `请输入${p.label}`}
        style={{ width: resolvedWidth.value }}
        controls-position="right"
        onUpdate:modelValue={(v: number | null) => p.onChange(v)}
        onChange={() => emit('search')}
        {...(p.itemProps ?? {})}
      />
    )

    const renderPassword = (p: RendererParams) => (
      <el-input
        modelValue={p.value}
        clearable
        disabled={isDisabled.value}
        show-password
        placeholder={p.placeholder || `请输入${p.label}`}
        style={{ width: resolvedWidth.value }}
        onUpdate:modelValue={p.onChange}
        onClear={() => emit('search')}
        name="resetPassword"
        autocomplete="off"
      />
    )

    const renderTextarea = (p: RendererParams) => (
      <el-input
        type="textarea"
        modelValue={p.value}
        clearable
        disabled={isDisabled.value}
        placeholder={p.placeholder || `请输入${p.label}`}
        style={{ width: resolvedWidth.value }}
        onUpdate:modelValue={p.onChange}
      />
    )

    const renderSwitch = (p: RendererParams) => (
      <el-switch
        modelValue={p.value}
        disabled={isDisabled.value}
        onUpdate:modelValue={p.onChange}
      />
    )

    const renderRate = (p: RendererParams) => (
      <el-rate
        modelValue={p.value}
        disabled={isDisabled.value}
        onUpdate:modelValue={p.onChange}
      />
    )

    const renderRadio = (p: RendererParams) => (
      <el-radio-group modelValue={p.value} onUpdate:modelValue={p.onChange}>
        {(p.data ?? []).map((item) => (
          <el-radio key={item.value} value={item.value}>
            {item.label ?? String(item.value)}
          </el-radio>
        ))}
      </el-radio-group>
    )

    const renderCheckbox = (p: RendererParams) => (
      <el-checkbox-group modelValue={p.value} onUpdate:modelValue={p.onChange} style={{ width: resolvedWidth.value }}>
        {(p.data ?? []).map((item) => (
          <el-checkbox key={item.value} value={item.value}>
            {item.label ?? String(item.value)}
          </el-checkbox>
        ))}
      </el-checkbox-group>
    )

    const renderSelect = (p: RendererParams) => (
      <el-select
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        style={{ width: resolvedWidth.value }}
        clearable
        filterable={props.filterable}
        multiple={p.multiple}
        onChange={() => emit('search')}
      >
        {(p.data ?? []).map((item) => (
          <el-option
            key={item.value}
            value={item.value}
            label={item.label ?? String(item.value)}
          />
        ))}
      </el-select>
    )

    const renderRemoteSelect = (p: RendererParams) => (
      <qa-remote-select
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        action={props.action}
        actionData={props.actionData}
        props={props.props}
        filterable={props.filterable}
        width={resolvedWidth.value}
        formType={props.formType}
      />
    )

    /* ---------------- cascader ---------------- */
    const renderCascader = (p: RendererParams) => (
      <qa-cascader
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        data={props.data}
        action={p.action}
        actionData={props.actionData}
        props={p.itemProps}
        width={resolvedWidth.value}
      />
    )

    const renderDate = (p: RendererParams) => (
      <el-date-picker
        modelValue={p.value}
        type={p.dateType}
        format={p.format}
        valueFormat={p.valueFormat}
        disabled={isDisabled.value}
        placeholder={p.placeholder}
        style={{ width: resolvedWidth.value }}
        onUpdate:modelValue={p.onChange}
        onChange={() => emit('search')}
        onClear={() => emit('search')}
      />
    )

    const renderDateTimerange = (p: RendererParams) => {
      const dateType = p.dateType ?? 'datetimerange'
      const valueFormat = p.valueFormat ?? 'x'
      const width = p.width ?? props.width
      return (
        <el-date-picker
          modelValue={p.value}
          onUpdate:modelValue={p.onChange}
          onChange={() => emit('search')}
          onClear={() => emit('search')}
          type={dateType}
          format={p.format}
          placeholder={p.placeholder || '请选择' + p.label}
          disabled={isDisabled.value}
          valueFormat={valueFormat}
          {...p.pickerOptions}
          style={{ width: realUnitConversion(width) }}
        />
      )
    }

    const renderArrayString = (p: RendererParams) => (
      <qa-array-string
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
      />
    )

    const renderArrayNumber = (p: RendererParams) => (
      <qa-array-number
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
      />
    )

    const renderArrayObject = () => (
      <qa-array-object
        rootModel={props.modelValue ?? {}}
        fieldKey={props.itemKey}
        columns={props.columns ?? []}
        defaultRow={props.defaultValue}
        showAdd={props.showAdd !== false}
        showClear={props.showClear === true}
        showSort={props.showSort === true}
        rightBtns={props.rightBtns}
        itemWidth={props.itemWidth}
        disabled={isDisabled.value}
        formType={props.formType}
        nestedLabelWidth={props.labelWidth}
        onUpdate:rootModel={(v: Record<string, any>) => emit('update:modelValue', v)}
      />
    )

    /* ---------------- icon-select 状态 ---------------- */
    const showIconSelect = ref(false)

    const renderIcon = (p: RendererParams) => {
      const IconComp = p.value ? ElIcons[p.value as keyof typeof ElIcons] : null
      return (
        <>
          <div style="display:inline-flex;align-items:center;gap:8px;">
            <el-button onClick={() => (showIconSelect.value = true)}>
              {IconComp
                ? <><el-icon size={16} style="margin-right:6px;"><IconComp /></el-icon></>
                : '选择图标'
              }
            </el-button>
            {p.value ? (
              <el-icon
                style="cursor:pointer;color:var(--el-text-color-placeholder);"
                onClick={() => p.onChange(null)}
              >
                <CircleClose />
              </el-icon>
            ) : null}
          </div>
          <qa-icon-select
            show={showIconSelect.value}
            modelValue={p.value}
            onUpdate:show={(v: boolean) => (showIconSelect.value = v)}
            onConfirm={(name: string) => p.onChange(name)}
          />
        </>
      )
    }

    /* ---------------- tree-select 状态 ---------------- */
    const showTreeSelect = ref(false)

    const renderTreeSelect = (p: RendererParams) => (
      <>
        <div style="display:inline-flex;align-items:center;gap:4px;">
          <el-button onClick={() => (showTreeSelect.value = true)}>
            {p.value || '选择'}
          </el-button>
          {p.value ? (
            <el-icon
              style="cursor:pointer;color:var(--el-text-color-placeholder);"
              onClick={() => p.onChange(null)}
            >
              <CircleClose />
            </el-icon>
          ) : null}
        </div>
        <qa-tree-select
          show={showTreeSelect.value}
          action={p.action}
          modelValue={p.value}
          defaultProps={p.itemProps}
          onUpdate:show={(v: boolean) => (showTreeSelect.value = v)}
          onTreeSelectConfirm={(data: Record<string, any>) => {
            p.onChange(data ? data[p.itemProps?.value ?? 'value'] : null)
          }}
        />
      </>
    )

    /* ---------------- table-select ---------------- */
    const renderTableSelect = (p: RendererParams) => (
      <qa-table-select
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        action={p.action}
        columns={p.columns}
        queryColumns={p.queryColumns}
        formData={props.formData ?? {}}
        onUpdate:formData={(val: Record<string, any>) => emit('update:formData', val)}
        multiple={p.multiple}
        pageSize={p.pageSize}
        placeholder={p.placeholder}
        title={p.title}
      />
    )

    /* ---------------- file-upload ---------------- */
    const renderFile = (p: RendererParams) => (
      <qa-file-upload
        modelValue={p.value}
        multiple={p.multiple}
        limit={p.limit}
        autoUpload={p.autoUpload}
        tempFileType={p.tempFileType}
        fileSize={p.fileSize}
        sizeUnit={p.sizeUnit}
        httpRequest={p.httpRequest}
        categoryId={p.categoryId}
        needSave={p.needSave}
        buttonText={p.buttonText}
        disabled={isDisabled.value}
        uploadProps={p.uploadProps}
        onUpdate:modelValue={p.onChange}
      />
    )

    /* ---------------- file-select ---------------- */
    const renderFileSelect = (p: RendererParams): JSX.Element => (
      <qa-file-select
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        fileType={p.fileType}
        multiple={p.multiple}
        multipleLimit={p.multipleLimit}
        defaultCategory={p.defaultCategory}
        upload={p.upload}
        updateCategory={p.updateCategory}
        imageFit={p.imageFit}
        fileSize={p.fileSize}
        sizeUnit={p.sizeUnit}
        returnType={p.returnType}
        {...p.itemProps}
      />
    ) as JSX.Element

    /* ---------------- area-cascader ---------------- */
    const renderAreaCascader = (p: RendererParams) => (
      <qa-area-cascader
        modelValue={p.value ?? {}}
        onUpdate:modelValue={p.onChange}
        style={{ width: resolvedWidth.value }}
      />
    )

    /* ---------------- color ---------------- */
    const renderColor = (p: RendererParams) => (
      <el-color-picker
        modelValue={p.value}
        disabled={isDisabled.value}
        onUpdate:modelValue={p.onChange}
        {...(p.itemProps ?? {})}
      />
    )

    /* ---------------- slider ---------------- */
    const renderSlider = (p: RendererParams) => (
      <el-slider
        modelValue={p.value}
        disabled={isDisabled.value}
        style={{ width: resolvedWidth.value }}
        onUpdate:modelValue={p.onChange}
        {...(p.itemProps ?? {})}
      />
    )

    /* ---------------- time ---------------- */
    const renderTime = (p: RendererParams) => (
      <el-time-picker
        modelValue={p.value}
        disabled={isDisabled.value}
        placeholder={p.placeholder || `请选择${p.label}`}
        style={{ width: resolvedWidth.value }}
        onUpdate:modelValue={p.onChange}
        {...(p.itemProps ?? {})}
      />
    )

    /* ---------------- json ---------------- */
    const renderJson = (p: RendererParams) => (
      <qa-json-editor
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        width={resolvedWidth.value}
        readonly={isDisabled.value}
        placeholder={p.placeholder || `请输入${p.label}`}
        {...(p.itemProps ?? {})}
      />
    )

    /* ---------------- editor ---------------- */
    const renderEditor = (p: RendererParams) => (
      <qa-editor
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        placeholder={p.placeholder || `请输入${p.label}`}
        disabled={isDisabled.value}
        {...(p.itemProps ?? {})}
      />
    )

    /* ---------------- tag ---------------- */
    const renderTag = (p: RendererParams) => (
      <qa-tag
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        disabled={isDisabled.value}
        placeholder={p.placeholder}
        {...(p.itemProps ?? {})}
      />
    )

    /* ---------------- map-picker ---------------- */
    const renderMapPicker = (p: RendererParams) => (
      <qa-map-picker
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        disabled={isDisabled.value}
        placeholder={p.placeholder}
        defaultLocation={(p as any).defaultLocation}
        {...(p.itemProps ?? {})}
      />
    )

    /* ---------------- 映射表（静态，不依赖响应式状态） ---------------- */
    const renderMap: Record<string, (p: RendererParams) => JSX.Element> = {
      text: renderText,
      number: renderNumber,
      password: renderPassword,
      textarea: renderTextarea,
      switch: renderSwitch,
      rate: renderRate,
      color: renderColor,
      slider: renderSlider,
      radio: renderRadio,
      checkbox: renderCheckbox,
      select: renderSelect,
      'remote-select': renderRemoteSelect,
      cascader: renderCascader,
      date: renderDate,
      file: renderFile,
      datetimerange: renderDateTimerange,
      time: renderTime,
      editor: renderEditor,
      json: renderJson,
      'array<string>': renderArrayString,
      'array<number>': renderArrayNumber,
      'array<object>': renderArrayObject,
      'file-select': renderFileSelect,
      icon: renderIcon,
      'tree-select': renderTreeSelect,
      'table-select': renderTableSelect,
      'address': renderAreaCascader,
      'area-cascader': renderAreaCascader,
      map: renderMapPicker,
      tag: renderTag,
    }

    /* ---------------- rendererParams ---------------- */
    const rendererParams = computed<RendererParams>(() => ({
      ...(props as any),
      value:        currentValue.value,
      itemProps:    props.props,
      actionData:   typeof props.actionData === 'function'
        ? (props.actionData as () => Record<string, any>)()
        : props.actionData,
      data: typeof props.data === 'function'
        ? (props.data as () => OptionItem[])()
        : props.data,
      columns:      props.columns      ?? [],
      enable:       props.enable       ?? false,
      formData:     props.formData     ?? {},
      queryColumns: props.queryColumns ?? [],
      multiple:     props.multiple     ?? false,
      pageSize:     props.pageSize     ?? 0,
      nameKey:      props.nameKey      ?? '',
      idKey:        props.idKey        ?? '',
      onChange: (v: any) => (currentValue.value = v),
    }))

    /* ---------------- render ---------------- */
    return () => {
      if (!(isShow.value && isShowRule.value)) return null
      const renderer = props.type != null ? renderMap[props.type] : undefined
      return (
        <el-form-item
          label={props.showLabel ? props.label : ''}
          labelWidth={props.showLabel ? props.labelWidth : '0'}
          prop={props.itemKey}
          rules={props.rules}
        >
          <div class="w-full">
            {slots.default?.() || renderer?.(rendererParams.value)}
            {props.tips && formType.value !== 'query' && (
              <div class="text-[#909399] text-[12px] mt-[4px]">
                {props.tips}
              </div>
            )}
          </div>
        </el-form-item>
      )
    }
  },
})
</script>
