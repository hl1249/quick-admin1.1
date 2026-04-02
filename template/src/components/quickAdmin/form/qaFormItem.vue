<script lang="tsx">
// Vue
import { defineComponent, type PropType, type Ref } from 'vue'
import type { JSX } from 'vue/jsx-runtime'

// Element Plus
import { RemoveFilled, Plus, CircleClose } from '@element-plus/icons-vue'
import * as ElIcons from '@element-plus/icons-vue'

// 内部组件类型
import type { QueryColumns } from '../table/qaTableQuery.vue'
import type { Columns } from '../table/qaTable.vue'

// 工具 / HTTP
import { realUnitConversion } from '@/utils'
import http from '@/utils/axios'

/** 日期选择器 pickerOptions */
interface DatePickerOptions {
  defaultTime?: (string | Date)[]
  shortcuts?: { text: string; value: () => void | Date | [Date, Date] }[]
}

/** 选项项（radio/select/tag 等） */
interface OptionItem {
  value: any
  label: string
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


  nameKey?: string,
  idKey?: string,

  limit?: number,
  uploadProps?: Record<string, any>,
  fileSize?: number,
  sizeUnit?: 'KB' | 'MB' | 'GB',
  buttonText?: string,
  categoryId?: string,
  needSave?: boolean,
  autoUpload?: boolean,
  tempFileType?: 'tempPath' | 'base64',
  httpRequest?: (file: File) => Promise<string>,

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

type RemoteSelectPropsParams = RendererParams & {
  list: string
  value:string
  label: string
  desc: 'asc' | 'desc'
}

interface RemoteSelectParams extends RendererParams{
  actionData?: Record<string, any>
  itemProps: RemoteSelectPropsParams
  dataPreprocess?: (data: any) => any,
  showAll?: boolean
  showRefresh?: boolean
  limit?: number
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

    show: Array as PropType<string[]>,
    showRule: [Function, String] as PropType<((model: Record<string, any>) => boolean) | string>,
    disabled: [Function, String] as PropType<((model: Record<string, any>) => boolean) | string>,
    watch: Function as PropType<(val: any) => void>,
  },
  emits: {
    'update:modelValue': (val: Record<string, unknown>) => true,
    'update:formData': (val: Record<string, unknown>) => true,
    'search': () => true,
  },
  setup(props, { emit, slots }) {
    /* ---------------- v-model ---------------- */
    const { formType, showRule, disabled } = toRefs(props)

    const currentValue = computed({
      get: () => props.modelValue?.[props.itemKey],
      set: (v) => {
        // ⚠️ 关键修复:必须创建新对象并 emit,不能直接修改
        console.log("我在实则",props,v)
        const newValue = { ...props.modelValue, [props.itemKey]: v }
        console.log("我在实则-2",newValue)
        emit('update:modelValue', newValue)
      }
    })

    watch(
      () => props.modelValue?.[props.itemKey],
      (val) => props.watch?.(val),
      { deep: true }
    )

    /* ---------------- 通用逻辑 ---------------- */
    const isShow = () => {
      if (formType.value === 'query') return true
      if (!props.show) return true
      return formType.value != null && props.show.includes(formType.value)
    }

    const isShowRule = () => {
      if (typeof showRule.value === 'function') {
        return showRule.value(props.modelValue)
      }
      if (typeof showRule.value === 'string') {
        const match = showRule.value.match(/^(\w+)\s*==\s*(.+)$/)
        if (!match) return true
        const [, key, value] = match
        return key != null && props.modelValue?.[key] == value
      }
      return true
    }

    const isDisabled = () => {
      if (typeof disabled.value === 'function') {
        return disabled.value(props.modelValue) === false
      }
      if (typeof disabled.value === 'string') {
        const match = disabled.value.match(/^(\w+)\s*==\s*(.+)$/)
        if (!match) return false
        const [, key, value] = match
        return props.modelValue?.[key] != value
      }
      return false
    }

    /* ---------------- renderers ---------------- */

    const renderText = (p: RendererParams) => (
      <el-input
        modelValue={p.value}
        clearable
        disabled={isDisabled()}
        placeholder={p.placeholder || `请输入${p.label}`}
        style={{ width: realUnitConversion(props.width) }}
        onUpdate:modelValue={p.onChange}
        onClear={() => emit('search')}
      />
    )

    const renderNumber = (p: RendererParams) => (
      <el-input
        type="number"
        modelValue={p.value}
        disabled={isDisabled()}
        placeholder={p.placeholder || `请输入${p.label}`}
        style={{ width: realUnitConversion(props.width) }}
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
            disabled={isDisabled()}
            show-password
            placeholder={p.placeholder || `请输入${p.label}`}
            style={{ width: realUnitConversion(props.width) }}
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
        disabled={isDisabled()}
        placeholder={p.placeholder || `请输入${p.label}`}
        style={{ width: realUnitConversion(props.width) }}
        onUpdate:modelValue={p.onChange}
      />
    )

    const renderSwitch = (p: RendererParams) => (
      <el-switch
        modelValue={p.value}
        disabled={isDisabled()}
        onUpdate:modelValue={p.onChange}
      />
    )

    const renderRate = (p: RendererParams) => (
      <el-rate
        modelValue={p.value}
        disabled={isDisabled()}
        onUpdate:modelValue={p.onChange}
      />
    )

    const renderRadio = (p: RendererParams) => (
      <el-radio-group modelValue={p.value} onUpdate:modelValue={p.onChange}>
        {(p.data ?? []).map((item) => (
          <el-radio key={item.value} value={item.value}>
            {item.label}
          </el-radio>
        ))}
      </el-radio-group>
    )

    const renderCheckbox = (p: RendererParams) => (
      <el-checkbox-group modelValue={p.value} onUpdate:modelValue={p.onChange}  style={{ width: realUnitConversion(props.width) }}>
        {(p.data ?? []).map((item) => (
          <el-checkbox key={item.value} value={item.value}>
            {item.label}
          </el-checkbox>
        ))}
      </el-checkbox-group>
    )
    const renderSelect = (p: RendererParams) => (
      <el-select modelValue={p.value} onUpdate:modelValue={p.onChange} style={{ width: realUnitConversion(props.width) }}>
        {(p.data ?? []).map((item) => (
          <el-option key={item.value} value={item.value}>
            {item.label}
          </el-option>
        ))}
      </el-select>
    )

    const remoteSelectList: Ref<any[]> = ref([])
    const remoteSelectRequestLoading = ref(false)
    const remoteSelectRequestKey = computed(() =>
      JSON.stringify({
        type: props.type,
        action: props.action ?? '',
        actionData: props.actionData ?? null,
        itemProps: props.props ?? null,
      })
    )

    const getByPath = (obj: any, path: string) =>
      path.split('.').reduce((cur, key) => cur?.[key], obj)

    const loadRemoteSelectOptions = async (searchValue?: string) => {
      if (props.type !== 'remote-select') return
      if (!props.action) {
        remoteSelectList.value = []
        return
      }

      remoteSelectRequestLoading.value = true

      try {
        const data = searchValue != null && searchValue !== ''
          ? { searchValue, ...props.actionData }
          : props.actionData

        const res = await http.request({
          method: 'POST',
          url: props.action,
          data,
        })

        const listKey = props.props?.list
        const valueKey = props.props?.value ?? 'value'
        const labelKey = props.props?.label ?? 'label'
        const options = listKey
            ? res.data?.data?.[listKey] ?? []
            : res.data?.data ?? []

        remoteSelectList.value = Array.isArray(options)
          ? options.map((item: any) => ({
              key: getByPath(item, valueKey),
              label: getByPath(item, labelKey),
              value: getByPath(item, valueKey),
            }))
          : []
      } finally {
        remoteSelectRequestLoading.value = false
      }
    }

    // props 变化时重新拉取（actionData / action 等改变）
    watch(remoteSelectRequestKey, () => {
      void loadRemoteSelectOptions()
    }, { immediate: true })

    // formType 变化时重新拉取（表单每次打开都刷新）
    watch(() => props.formType, () => {
      if (props.type === 'remote-select') {
        void loadRemoteSelectOptions()
      }
    })

    let remoteSearchTimer: ReturnType<typeof setTimeout> | null = null
    const handleRemoteSearch = (query: string) => {
      if (remoteSearchTimer) clearTimeout(remoteSearchTimer)
      if (!query.trim()) return
      remoteSearchTimer = setTimeout(() => {
        void loadRemoteSelectOptions(query)
      }, 1000)
    }

    const renderRemoteSelect = (p: RendererParams) => {
      return (
        <el-select
          modelValue={p.value}
          loading={remoteSelectRequestLoading.value}
          onUpdate:modelValue={p.onChange}
          style={{ width: realUnitConversion(props.width) }}
          filterable={props.filterable}
          remote={props.filterable}
          clearable={true}
          remoteMethod={props.filterable ? handleRemoteSearch : undefined}
        >
          {remoteSelectList.value.map((item) => (
              <el-option key={item.key} value={item.value} label={item.label}>
                {item.label}
              </el-option>
          ))}
        </el-select>
      )
    }

    /* ---------------- cascader ---------------- */
    const renderCascader = (p: RendererParams) => (
      <qa-cascader
        modelValue={p.value}
        onUpdate:modelValue={p.onChange}
        data={props.data}
        action={p.action}
        actionData={props.actionData}
        props={p.itemProps}
        width={realUnitConversion(props.width)}
      />
    )

    const renderDate = (p: RendererParams) => (
      <el-date-picker
        modelValue={p.value}
        type={p.dateType}
        format={p.format}
        valueFormat={p.valueFormat}
        disabled={isDisabled()}
        placeholder={p.placeholder}
        style={{ width: realUnitConversion(props.width) }}
        onUpdate:modelValue={p.onChange}
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
          disabled={isDisabled()}
          valueFormat={valueFormat}
          {...p.pickerOptions}
          style={{ width: realUnitConversion(width) }}
        />
      )
    }

    const renderArrayString = (p: RendererParams) => {
      const value = p.value
      const list: string[] = Array.isArray(value) ? value : []

      const update = (i: number, v: string) => {
        const arr = [...list]
        arr[i] = v
        p.onChange(arr)
      }

      const remove = (i: number) => p.onChange(list.filter((_, idx) => idx !== i))
      const add = () => p.onChange([...list, ''])
      const clear = () => p.onChange([])

      return (
        <div class="flex flex-col gap-[12px] w-full">
          {list.map((item, index) => (
            <el-input
              key={index}
              modelValue={item}
              onUpdate:modelValue={(v: string) => update(index, v)}
              v-slots={{
                append: () => (
                  <div
                    class="px-[12px] cursor-pointer"
                    onClick={() => remove(index)}
                  >
                    <el-icon>
                      <RemoveFilled />
                    </el-icon>
                  </div>
                ),
              }}
            />
          ))}

          <div class="flex gap-[12px]">
            <el-button plain onClick={add} icon={<Plus />}>
              添加
            </el-button>
            {list.length > 0 && (
              <el-popconfirm title="确定清空？" onConfirm={clear}>
                {{
                  reference: () => (
                    <el-button type="danger" plain>
                      清空
                    </el-button>
                  ),
                }}
              </el-popconfirm>
            )}
          </div>
        </div>
      )
    }


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
    const fileUploadList = ref<any[]>([])
    const fileUidUrlMap = new Map<number, string>()
    const getFileUrls = () => Array.from(fileUidUrlMap.values())

    // 外部值变化时（编辑回填 / 表单重置）同步列表
    watch(currentValue, (newVal) => {
      if (props.type !== 'file') return
      const newUrls: string[] = Array.isArray(newVal) ? newVal : newVal ? [newVal] : []
      if (JSON.stringify(getFileUrls().sort()) === JSON.stringify([...newUrls].sort())) return
      fileUidUrlMap.clear()
      fileUploadList.value = newUrls.map((url, i) => {
        const uid = Date.now() + i
        fileUidUrlMap.set(uid, url)
        return { name: url.split('/').pop() || `file-${i + 1}`, url, uid, status: 'success' }
      })
    }, { immediate: true })

    const fileExceedTip = ref('')
    const fileSizeTip = ref('')
    let fileExceedTimer: ReturnType<typeof setTimeout> | null = null
    let fileSizeTimer: ReturnType<typeof setTimeout> | null = null

    const showTip = (tipRef: Ref<string>, timerRef: { value: ReturnType<typeof setTimeout> | null }, msg: string) => {
      tipRef.value = msg
      if (timerRef.value) clearTimeout(timerRef.value)
      timerRef.value = setTimeout(() => { tipRef.value = '' }, 3000)
    }

    const renderFile = (p: RendererParams) => {
      const isSingle = p.limit === 1
      const autoUpload = p.autoUpload !== false

      const emitValue = () => {
        const urls = getFileUrls()
        p.onChange(isSingle ? (urls[0] ?? null) : urls)
      }

      const convertLocalFile = (file: File, uid: number): Promise<void> =>
        new Promise((resolve) => {
          if (p.tempFileType === 'base64') {
            const reader = new FileReader()
            reader.onload = (e) => {
              fileUidUrlMap.set(uid, e.target?.result as string)
              emitValue()
              resolve()
            }
            reader.readAsDataURL(file)
          } else {
            fileUidUrlMap.set(uid, URL.createObjectURL(file))
            emitValue()
            resolve()
          }
        })

      const beforeUpload = (file: File) => {
        if (p.fileSize) {
          const unitMap = { KB: 1024, MB: 1024 ** 2, GB: 1024 ** 3 }
          const unit = p.sizeUnit ?? 'MB'
          if (file.size > p.fileSize * unitMap[unit]) {
            showTip(fileSizeTip, { value: fileSizeTimer }, `文件大小不能超过 ${p.fileSize}${unit}`)
            return false
          }
        }
        return true
      }

      const handleUpload = async (options: any) => {
        if (!autoUpload) {
          await convertLocalFile(options.file, options.file.uid)
          options.onSuccess({})
          return
        }

        if (p.httpRequest) {
          try {
            const url = await p.httpRequest(options.file)
            fileUidUrlMap.set(options.file.uid, url)
            emitValue()
            options.onSuccess({ url })
          } catch (err) {
            options.onError(err)
          }
          return
        }

        const formData = new FormData()
        formData.append('file', options.file)
        if (p.categoryId) formData.append('category_id', p.categoryId)
        if (p.needSave === false) formData.append('needSave', 'false')
        try {
          const res = await http.request({
            url: '/app/admin/system/systemFile/systemFile/upload',
            method: 'post',
            data: formData,
            openMessage: false,
          })
          fileUidUrlMap.set(options.file.uid, res.data?.data?.url)
          emitValue()
          options.onSuccess(res.data?.data)
        } catch (err) {
          options.onError(err)
        }
      }

      const handleExceed = () => {
        if (!p.limit) return
        showTip(fileExceedTip, { value: fileExceedTimer }, `最多只能上传 ${p.limit} 个文件`)
      }

      return (
        <>
          <el-upload
            {...(p.uploadProps ?? {})}
            fileList={fileUploadList.value}
            onUpdate:fileList={(v: any[]) => { fileUploadList.value = v }}
            httpRequest={handleUpload}
            beforeUpload={beforeUpload}
            onRemove={(file: any) => { fileUidUrlMap.delete(file.uid); emitValue() }}
            onExceed={handleExceed}
            multiple={p.multiple}
            limit={p.limit}
            disabled={isDisabled()}
          >
            <el-button type="primary" disabled={isDisabled()}>
              {p.buttonText ?? '上传文件'}
            </el-button>
          </el-upload>
          {fileExceedTip.value && (
            <div class="text-[#f56c6c] text-[12px] mt-[4px]">{fileExceedTip.value}</div>
          )}
          {fileSizeTip.value && (
            <div class="text-[#f56c6c] text-[12px] mt-[4px]">{fileSizeTip.value}</div>
          )}
        </>
      )
    }

    /* ---------------- file-select ---------------- */
    const renderFileSelect = (p: RendererParams): JSX.Element => {
      return (
        <qa-file-select
          modelValue={p.value}
          fileType={(p.fileType ?? 'image') as 'image' | 'video' | 'other'}
          multiple={p.multiple ?? false}
          multipleLimit={p.multipleLimit}
          defaultCategory={p.defaultCategory}
          upload={p.upload !== false}
          updateCategory={p.updateCategory !== false}
          imageFit={(p.imageFit ?? 'cover') as any}
          fileSize={p.fileSize}
          sizeUnit={p.sizeUnit ?? 'MB'}
          returnType={(p.returnType ?? 'url') as 'url' | 'id'}
          onUpdate:modelValue={p.onChange}
        />
      ) as JSX.Element
    }

    /* ---------------- 映射表 ---------------- */
    const renderMap: Record<string, (p: RendererParams) => JSX.Element> = {
      text: renderText,
      number: renderNumber,
      password: renderPassword,
      textarea: renderTextarea,
      switch: renderSwitch,
      rate: renderRate,
      radio: renderRadio,
      checkout: renderCheckbox,
      select: renderSelect,
      'remote-select': renderRemoteSelect,
      cascader: renderCascader,
      date: renderDate,
      file: renderFile,
      datetimerange: renderDateTimerange,
      'array<string>': renderArrayString,
      'file-select': renderFileSelect,
      icon: renderIcon,
      'tree-select': renderTreeSelect,
      'table-select': renderTableSelect,
    }

    /* ---------------- render ---------------- */
    return () => {
      if (!(isShow() && isShowRule())) return null
      const renderer = props.type != null ? renderMap[props.type] : undefined
      return (
        <el-form-item
          label={props.showLabel ? props.label : ''}
          labelWidth={props.showLabel ? props.labelWidth : '0'}
          prop={props.itemKey}
        >
          <div class="w-full">
            {slots.default?.() ||
              renderer?.({
                value: currentValue.value,
                title: props.title,
                label: props.label,
                placeholder: props.placeholder,
                action: props.action,
                actionData: typeof props.actionData === 'function' ? (props.actionData as () => Record<string, any>)() : props.actionData,
                itemProps: props.props,
                data: typeof props.data === 'function' ? (props.data as () => OptionItem[])() : props.data,

                columns: props.columns ?? [],
                enable: props.enable ?? false,
                formData: props.formData ?? {},
                queryColumns: props.queryColumns ?? [],
                multiple: props.multiple ?? false,
                pageSize: props.pageSize ?? 0,
                nameKey: props.nameKey ?? '',
                idKey: props.idKey ?? '',
                limit: props.limit,
                uploadProps: props.uploadProps,
                fileSize: props.fileSize,
                sizeUnit: props.sizeUnit,
                buttonText: props.buttonText,
                categoryId: props.categoryId,
                needSave: props.needSave,
                autoUpload: props.autoUpload,
                tempFileType: props.tempFileType,
                httpRequest: props.httpRequest,
                fileType: props.fileType,
                multipleLimit: props.multipleLimit,
                defaultCategory: props.defaultCategory,
                upload: props.upload,
                updateCategory: props.updateCategory,
                imageFit: props.imageFit,
                returnType: props.returnType,

                dateType: props.dateType,
                valueFormat: props.valueFormat,
                format: props.format,
                pickerOptions: props.pickerOptions,
                width: props.width,
                onChange: (v: any) => (currentValue.value = v),
              })}
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
