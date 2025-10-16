<script lang="tsx">
import { defineComponent } from "vue";
import { useVModel } from "@vueuse/core";
import { realUnitConversion } from '@/utils/qaUtils'
import type { JSX } from "vue/jsx-runtime";

export default defineComponent({
  name: "qaFormItem",
  props: {
    modelValue: { type: Object, required: true },
    formType: String,
    label: String,
    itemKey: { type: String, required: true },
    type: String,
    placeholder: String,
    tips: String,
    showLabel: {
      type: Boolean,
      default: true  // 设置默认值为 true
    },
    labelWidth: [String, Number],
    width: [String, Number],
    dateType: String,
    valueFormat: String,
    format: String,
    pickerOptions: Object,
    show: Array,
    showRule: [Function, String],   // 是否展示对应表单项
    disabled: [Function, String],   // 是否禁用对应表单项
    watch: Function
  },
  emits: ["update:modelValue", "search"],
  setup(props, { emit, slots }) {
    const {  label, labelWidth, width, itemKey, type, placeholder, tips, show, showLabel,  dateType, valueFormat, format, pickerOptions } = props;
    const { formType, showRule, disabled } = toRefs(props)
    const model = useVModel(props, "modelValue", emit);
    watch(
      () =>  model.value[itemKey], // 注意这里要用函数
      (newValue) => {
        props?.watch?.(newValue) // 防止 props.watch 未传
      },
      { deep: true } // 如果 model.value 是对象，建议加上 deep
    )
    // 渲染输入框
    const renderText = ({ value, label, onChange, placeholder }: {
      value: string
      label: string
      onChange: (val: string) => void,
      placeholder: string
    }) => {
      return (
        <el-input
          clearable
          modelValue={value}
          placeholder={ placeholder || "请输入" + label}
          disabled={isDisabled()}
          onUpdate:modelValue={onChange}
          style={{ width: realUnitConversion(width) }}
        />
      );
    };

    // 日期 
    const renderDate = ({ value, dateType, format, valueFormat, onChange,placeholder }: {
      value: string | number | Date | null
      dateType: 'date' | 'daterange' | 'datetime' | 'datetimerange' | 'year' | 'month'
      format?: string
      valueFormat?: string
      onChange: (val: string | number | Date | null) => void
      placeholder?: string
    }) => {
      return (
        <el-date-picker
          modelValue={value}
          onUpdate:modelValue={onChange}
          type={dateType}
          format={format}
          placeholder={ placeholder || "请选择" + label}
          disabled={isDisabled()}
          valueFormat={valueFormat}
          style={{ width: realUnitConversion(width) }}
        ></el-date-picker>
      )
    }

    const renderDateTimerange = ({ value, dateType, format, valueFormat, onChange,placeholder }: {
      value: string | number | Date | null
      dateType: 'date' | 'daterange' | 'datetime' | 'datetimerange' | 'year' | 'month'
      format?: string
      valueFormat?: string
      onChange: (val: string | number | Date | null) => void,
      pickerOptions?: {
        defaultTime?: (string | Date)[]
        shortcuts?: {
          text: string
          value: () => void | Date | [Date, Date]
        }[]
      },
      placeholder: String
    }) => {
      return (
        <el-date-picker
          modelValue={value}
          onUpdate:modelValue={onChange}
          change={emit('search')}
          type={dateType}
          format={format}
          placeholder={ placeholder || "请选择" + label}
          disabled={isDisabled()}
          valueFormat={valueFormat}
          {...pickerOptions}
          style={{ width: realUnitConversion(width) }}
        ></el-date-picker>
      )
    }

    // 不同类型的渲染映射
    const renderMap: Record<string, (params: any) => JSX.Element | null> = {
      text: ({ value, label, onChange, placeholder }) => renderText({ value, label, onChange, placeholder }),
      date: ({ value, dateType, format, valueFormat, onChange, placeholder }) => renderDate({ value, dateType, format, valueFormat, onChange, placeholder }),
      datetimerange: ({ value, dateType = 'datetimerange', format, valueFormat = 'x', onChange, pickerOptions,placeholder }) => renderDateTimerange({ value, dateType, format, valueFormat, onChange, pickerOptions,placeholder })
    };

    // 统一渲染
    const render = (params: any) => {
      const renderer = renderMap[params.type];
      return renderer ? (
        <div>
          {renderer(params)}
          {tips && formType.value !='query' ? <div class="text-[#909399] text-[12px]">{tips}</div> : null}
        </div>
      ) : (
        <div class="whitespace-nowrap">{params.value}</div>
      );
    };

    const isShow = () => {
      if(formType.value === 'query') return true
      if(show === undefined) return true
      return show?.includes(formType.value)
    }

    const isShowRule = () => {
      if (typeof showRule.value === 'function') {
        return showRule.value(model.value) // 调用函数
      }

      if (typeof showRule.value === 'string') {
        const match = showRule.value.match(/^(\w+)\s*==\s*(.+)$/)
        if (!match) return false
        const [, key, value] = match
        const modelVal = model.value[key]
        const targetVal = isNaN(Number(value)) ? value : Number(value)
        return modelVal === targetVal
      }

      return true // 默认显示
    }

    const finalShow = () => {
      return isShow() && isShowRule();
    }

    const isDisabled = () => {
       if (typeof disabled.value === 'function') {
        return !(disabled.value(model.value)) // 调用函数
      }

      if (typeof disabled.value === 'string') {
        const match = disabled.value.match(/^(\w+)\s*==\s*(.+)$/)
        if (!match) return false
        const [, key, value] = match
        const modelVal = model.value[key]
        const targetVal = isNaN(Number(value)) ? value : Number(value)
        return !(modelVal === targetVal)
      }

      return false // 默认不禁用
    }
    const hasSlot = !!slots.default

    return () => {
      return finalShow() ? (
        <el-form-item label={showLabel && label} labelWidth={showLabel ? labelWidth : '0'} prop={itemKey}>
          {hasSlot ? slots.default?.() : render({
            value: model.value[itemKey],
            label,
            type,
            placeholder,

            dateType,
            valueFormat,
            format,
            pickerOptions,
            onChange: (val: string) => (model.value[itemKey] = val),
          })}
        </el-form-item>
      ) : null;
    };
  },
});
</script>
