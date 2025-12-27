<script lang="tsx">
import { defineComponent } from "vue";
import { useVModel } from "@vueuse/core";
import { realUnitConversion } from '@/utils'
import type { JSX } from "vue/jsx-runtime";
import { RemoveFilled } from '@element-plus/icons-vue'

import qaTreeSelect from "./qaTreeSelect.vue";
import { renderComponent } from '@/utils'
import { on } from "events";
export default defineComponent({
  name: "qaFormItem",
  props: {
    action: String,
    props: Object,
    modelValue: { type: Object, required: false, default: () => ({}) },
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
    labelWidth: {
      type: [String, Number],
      default: '80px', // 默认值
    },
    width: {
      type: [String, Number],
      default: '100%', // 默认值
    },
    data: Object,
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
    const { action, label, labelWidth, width, data, itemKey, type, placeholder, tips, show, showLabel, dateType, valueFormat, format, pickerOptions } = props;
    console.log('props',props)
    const itemProps = props.props;
    const { formType, showRule, disabled } = toRefs(props)
    const model = useVModel(props, "modelValue", emit);
    watch(
      () => model.value?.[itemKey], // 注意这里要用函数
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
          placeholder={placeholder || "请输入" + label}
          disabled={isDisabled()}
          onUpdate:modelValue={onChange}
          onClear={() => emit("search")} // ✅ 点击时才执行
          style={{ width: realUnitConversion(width) }}
        />
      );
    };

    // 渲染switch
    const renderSwitch = ({ value, onChange }: {
      value: boolean
      onChange: (val: string) => void,
    }) => {
      return (
        <el-switch
          modelValue={value}
          onUpdate:modelValue={onChange}
        ></el-switch>
      )
    }

    // 单选
    const renderRadio = ({value,onChange,data}) => {
      return(
       <el-radio-group  modelValue={value} onUpdate:modelValue={onChange}>
        {data.map((item,index) => {
          return <el-radio value={item.value}>{item.label}</el-radio>
        })}
        </el-radio-group>)
    }

    // 渲染文本域
    const renderTextarea = ({ value, label, onChange, placeholder }: {
      value: string
      label: string
      onChange: (val: string) => void,
      placeholder: string
    }) => {
      return (
        <el-input
          clearable
          modelValue={value}
          placeholder={placeholder || "请输入" + label}
          type='textarea'
          disabled={isDisabled()}
          onUpdate:modelValue={onChange}
          onClear={() => emit("search")} // ✅ 点击时才执行
          style={{ width: realUnitConversion(width) }}
        />
      );
    };

    // 日期 
    const renderDate = ({ value, dateType, format, valueFormat, onChange, placeholder }: {
      value: string | number | Date | null
      dateType: 'date' | 'daterange' | 'datetime' | 'datetimerange' | 'year' | 'month' | 'array<string>'
      format?: string
      valueFormat?: string
      onChange: (val: string | number | Date | null) => void
      placeholder?: string
    }) => {
      return (
        <el-date-picker
          modelValue={value}
          onUpdate:modelValue={onChange}
          onClear={() => emit("search")} // ✅ 点击时才执行
          type={dateType}
          format={format}
          placeholder={placeholder || "请选择" + label}
          disabled={isDisabled()}
          valueFormat={valueFormat}
          style={{ width: realUnitConversion(width) }}
        ></el-date-picker>
      )
    }

    const renderDateTimerange = ({ value, dateType, format, valueFormat, onChange, placeholder }: {
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
          onChange={() => emit('search')}
          onClear={() => emit("search")}
          type={dateType}
          format={format}
          placeholder={placeholder || "请选择" + label}
          disabled={isDisabled()}
          valueFormat={valueFormat}
          {...pickerOptions}
          style={{ width: realUnitConversion(width) }}
        ></el-date-picker>
      )
    }


    // 渲染可变数组子表单 字符串类型
    const renderArrayString = ({ value, onChange }) => {
      // 确保 value 是数组
      const arrayValue = Array.isArray(value) ? value : []

      // 处理输入更新
      const handleInputUpdate = (index, newValue) => {
        const newArray = [...arrayValue]
        newArray[index] = newValue
        onChange(newArray)
      }

      // 处理删除
      const handleRemove = (index) => {
        const newArray = arrayValue.filter((_, i) => i !== index)
        onChange(newArray)
      }
      
      // 处理新增
      const handleAdd = () => {
        onChange([...arrayValue, ''])
      }

      const handleClear = () => {
        onChange([])
      }
      return (
        <div class='flex flex-col gap-[15px]'>
          {arrayValue.map((item, index) => (
            <div key={index} >
              <el-input
                modelValue={item}
                onUpdate:modelValue={(val) => handleInputUpdate(index, val)}
                placeholder="请输入内容"
                v-slots={{
                  append: () => (
                    <div
                      className="cursor-pointer "
                      onClick={() => handleRemove(index)}
                      class='box-content px-[20px] mx-[-20px] cursor-pointer'
                    >
                      <ElIcon >
                        <RemoveFilled />
                      </ElIcon>
                    </div>
                  )
                }}
              />

            </div>
          ))}

          {/* 空状态时显示新增按钮 */}
          {arrayValue.length === 0 && (
            <div >
              <el-button
                plain
                onClick={handleAdd}
                icon={<ElIcon><Plus /></ElIcon>}
              >
                新增
              </el-button>
            </div>
          )}

          {/* 或者始终显示添加按钮（可选） */}
          {arrayValue.length > 0 && (
            <div class='flex gap-[15px]'>
              <div >
              <el-button
                plain
                onClick={handleAdd}
              >
                添加
              </el-button>
            </div>
            <div >
              <ElPopconfirm
                onConfirm={handleClear}
                width="160"
                title="确定全部清空吗？"
                v-slots={{
                  reference: () => {
                    return <el-button
                      type="danger"
                    >
                      清空
                    </el-button>
                  }
                }}>
              </ElPopconfirm>
            </div>
            </div>
          )}

        </div>
      )
    }

    const treeSelectData = ref<any>(null)
    const showTreeSelect = ref(false)
    // 渲染树形选择表单 
    const renderTreeSelect = ({ value, onChange, action, treeSelectProps, placeholder }: {
      value: string | number | null
      onChange: (val: string | number | null) => void,
      action: string,
      treeSelectProps: {
        list: string
        value: string
        label: string
        children: string
      },
      placeholder: string
    }) => {

      return (
        <>
          {/* <el-button onClick={() => renderComponent(qaTreeSelect, { 
            action, 
            modelValue: value, 
            defaultProps: 
            treeSelectProps, 
            onTreeSelectConfirm:(data)=>{
              console.log("我执行了 ")
              treeSelectData.value = data
              onChange(data ? data[treeSelectProps.value] : null)
            }
          })}>{treeSelectData.value?.[treeSelectProps.label] || '选择'}</el-button> */}
          <el-button onClick={() => (showTreeSelect.value = true)}>选择{showTreeSelect.value ? 'true' : 'false'}</el-button>
          <qa-tree-select v-model:show={showTreeSelect.value} action={action} modelValue={value} defaultProps={treeSelectProps} 
            onTreeSelectConfirm={(data) => {
              treeSelectData.value = data
              onChange(data ? data[treeSelectProps.value] : null)
            }}
          />
        </>
      )
    }

    // 不同类型的渲染映射
    const renderMap: Record<string, (params: any) => JSX.Element | null> = {
      text: ({ value, label, onChange, placeholder }) => renderText({ value, label, onChange, placeholder }),
      switch: ({ value, onChange }) => renderSwitch({ value, onChange }),
      radio: ({ value, onChange, data }) => renderRadio({ value, onChange,data }),
      textarea: ({ value, label, onChange, placeholder }) => renderTextarea({ value, label, onChange, placeholder }),
      date: ({ value, dateType, format, valueFormat, onChange, placeholder }) => renderDate({ value, dateType, format, valueFormat, onChange, placeholder }),
      datetimerange: ({ value, dateType = 'datetimerange', format, valueFormat = 'x', onChange, pickerOptions, placeholder }) => renderDateTimerange({ value, dateType, format, valueFormat, onChange, pickerOptions, placeholder }),
      'array<string>': ({ value, onChange }) => renderArrayString({ value, onChange }),
      'tree-select': ({ value, onChange, action, itemProps, placeholder }) => renderTreeSelect({ value, onChange, action, treeSelectProps: itemProps, placeholder }),
    };

    // 统一渲染
    const render = (params: any) => {
      const renderer = renderMap[params.type];
      return renderer ? (
        <div>
          {renderer(params)}
          {tips && formType.value != 'query' ? <div class="text-[#909399] text-[12px]">{tips}</div> : null}
        </div>
      ) : (
        <div class="whitespace-nowrap">{params.value}</div>
      );
    };

    const isShow = () => {
      if (formType.value === 'query') return true
      if (show === undefined) return true
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
          <div style={{ width: '100%' }}>
            {hasSlot ? slots.default?.() : render({
              value: model.value[itemKey],
              label,
              type,
              placeholder,

              action,
              itemProps,
              data,
              dateType,
              valueFormat,
              format,
              pickerOptions,
              onChange: (val: string) => (model.value[itemKey] = val),
            })}
          </div>
        </el-form-item>
      ) : null;
    };
  },
});
</script>