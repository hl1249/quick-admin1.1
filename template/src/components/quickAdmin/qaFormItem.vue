<script lang="tsx">
import { defineComponent, type PropType } from 'vue'
import type { JSX } from 'vue/jsx-runtime'
import { RemoveFilled, Plus } from '@element-plus/icons-vue'

import type { QueryColumns } from './qaTableQuery.vue'
import type { Columns } from './qaTable.vue'
import { realUnitConversion } from '@/utils'
import http from '@/utils/axios';

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

  nameKey: string,
  idKey: string,

  action?: string
  itemProps?: TreeDefaultProps
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
    data: Array as PropType<OptionItem[]>,
    dateType: String,
    valueFormat: String,
    format: String,
    pickerOptions: Object as PropType<DatePickerOptions>,

    columns: Array as PropType<Columns[]>,
    enable: Boolean,
    queryColumns: Array as PropType<QueryColumns[]>,
    multiple: Boolean,
    pageSize: Number,
    nameKey: String,
    idKey: String,

    show: Array as PropType<string[]>,
    showRule: [Function, String] as PropType<((model: Record<string, any>) => boolean) | string>,
    disabled: [Function, String] as PropType<((model: Record<string, any>) => boolean) | string>,
    watch: Function as PropType<(val: any) => void>,
  },
  emits: {
    'update:modelValue': (val: Record<string, unknown>) => true,
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
        onUpdate:modelValue={(e)=>{
          p.onChange(e)
          console.log('文本',p)
        }}
        onClear={() => emit('search')}
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

    const showTreeSelect = ref(false)

    const renderTreeSelect = (p: RendererParams) => (
      <>
        <el-button onClick={() => (showTreeSelect.value = true)}>
          {p.value || '选择'}
        </el-button>
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

    const showTableSelect = ref(false)

    const loaded = ref(false) // 是否已经请求过
    const renderList: Ref<any[]> = ref([])

    const renderTableSelect = (p: RendererParams) => {
      const nameKey = p.columns.find((item) => item.nameKey)?.key || '_id'
      const idKey = p.columns.find((item) => item.idKey)?.key || '_id'

      const value = p.value
      const list: string[] = Array.isArray(value) ? value : []

      if (!loaded.value) {
        loaded.value = true

        http.request({
          method: "POST",
          url: p.action,
          data: {
            pageIndex: 1,
            pageSize: list.length,
            [idKey]: p.value
          }
        }).then((res) => {
          renderList.value = res.data?.data?.rows || []
          console.log("表单渲染", renderList)
        })
      } 
      
      const remove = (i: number) => {
        console.log('已处于',p)
        // p.onChange(['我是新书预计'])
        let newList = renderList.value.filter((_, idx) => idx !== i)
        renderList.value = newList
        p.formData[props.itemKey] = newList.map((item) => item[idKey])
      }
      return (
        <>
        
          <div class="flex items-center gap-[12px]">
            {renderList.value?.map((item, index) => (
            <el-tag
              key={index}
              size="large"
            >
            <div 
            class="flex items-center">
            
            <span>{item[nameKey]}</span>
              <el-icon onClick={() => remove(index)} class="ml-[4px]">
                <RemoveFilled />
              </el-icon>
            </div>
            </el-tag>
          ))}

          <el-button onClick={() => (showTableSelect.value = true)}>
            {p.placeholder || '请选择'+p.title}
          </el-button>
          </div>
          <qa-table-select
            show={showTableSelect.value}
            action={p.action}
            modelValue={p.value}
            defaultProps={p.itemProps}

            columns={p.columns}
            formData={p.formData}
            queryColumns={p.queryColumns}
            multiple={p.multiple}
            pageSize={p.pageSize}

            nameKey={nameKey}
            idKey={idKey}

            onUpdate:show={(v: boolean) => (showTableSelect.value = v)}
            onTableSelectConfirm={(data: Record<string, any>) => {
              console.log("我选择了表格值", data)
              p.onChange(data ? data[p.itemProps?.value ?? 'value'] : null)
            }}
          />
        </>
      )
    }

    /* ---------------- 映射表 ---------------- */
    const renderMap: Record<string, (p: RendererParams) => JSX.Element> = {
      text: renderText,
      textarea: renderTextarea,
      switch: renderSwitch,
      rate: renderRate,
      radio: renderRadio,
      date: renderDate,
      datetimerange: renderDateTimerange,
      'array<string>': renderArrayString,
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
                itemProps: props.props,
                data: props.data,

                columns: props.columns ?? [],
                enable: props.enable ?? false,
                formData: props.modelValue ?? {},
                queryColumns: props.queryColumns ?? [],
                multiple: props.multiple ?? false,
                pageSize: props.pageSize ?? 0,
                nameKey: props.nameKey ?? '',
                idKey: props.idKey ?? '',

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
