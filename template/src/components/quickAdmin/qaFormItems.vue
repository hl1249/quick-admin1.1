<script lang="tsx">
import { defineComponent } from "vue";
import { useVModel } from "@vueuse/core";
import { realUnitConversion } from '@/utils/qaUtils'
import type { JSX } from "vue/jsx-runtime";

export default defineComponent({
  name: "qaFormItem",
  props: {
    modelValue: { type: Object, required: true },
    label: String,
    itemKey: { type: String, required: true },
    type: String,
    labelWidth: [String, Number],
    width:[ String, Number],
    dateType: String,
    valueFormat: String,
    format: String,
    pickerOptions: Object,
  },
  emits: ["update:modelValue","search"],
  setup(props, { emit }) {
    const { label, labelWidth,width, itemKey, type, dateType, valueFormat, format,pickerOptions } = props;
    const model = useVModel(props, "modelValue", emit);

    // 渲染输入框
    const renderText = ({ value, label, onChange }: {
      value: string
      label: string
      onChange: (val: string) => void
    }) => {
      return (
        <el-input
          clearable
          modelValue={value}
          placeholder={"请输入" + label}
          onUpdate:modelValue={onChange}
          style={{width:realUnitConversion(width)}}
        />
      );
    };

    // 日期 
    const renderDate = ({ value, dateType, format, valueFormat, onChange }: {
      value: string | number | Date | null
      dateType: 'date' | 'daterange' | 'datetime' | 'datetimerange' | 'year' | 'month'
      format?: string
      valueFormat?: string
      onChange: (val: string | number | Date | null) => void
    }) => {
      return (
        <el-date-picker
          modelValue={value}
          onUpdate:modelValue={onChange}
          type={dateType}
          format={format}
          valueFormat={valueFormat}
          style={{width:realUnitConversion(width)}}
        ></el-date-picker>
      )
    }

    const renderDateTimerange = ({ value, dateType, format, valueFormat, onChange }: {
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
      }
    }) => {
      return(
        <el-date-picker
          modelValue={value}
          onUpdate:modelValue={onChange}
          change={emit('search')}
          type={dateType}
          format={format}
          valueFormat={valueFormat}
          {...pickerOptions}
          style={{width:realUnitConversion(width)}}
        ></el-date-picker>
      )
    }

    // 不同类型的渲染映射
    const renderMap: Record<string, (params: any) => JSX.Element | null> = {
      text: ({ value, label, onChange }) => renderText({ value, label, onChange }),
      date: ({ value, dateType, format, valueFormat, onChange }) => renderDate({ value, dateType, format, valueFormat, onChange }),
      datetimerange:({ value, dateType = 'datetimerange', format, valueFormat = 'x', onChange, pickerOptions }) => renderDateTimerange({ value, dateType, format, valueFormat, onChange, pickerOptions })
    };

    // 统一渲染
    const render = (params: any) => {
      const renderer = renderMap[params.type];
      return renderer ? (
        renderer(params)
      ) : (
        <div class="whitespace-nowrap">{params.value}</div>
      );
    };

    return () => {
      return (
        <el-form-item label={label} labelWidth={labelWidth} prop={itemKey}>
          {render({
            value: model.value[itemKey],
            label,
            type,

            dateType,
            valueFormat,
            format,
            pickerOptions,
            onChange: (val: string) => (model.value[itemKey] = val),
          })}
        </el-form-item>
      );
    };
  },
});
</script>
