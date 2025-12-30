<script lang="tsx">
import { defineComponent, ref, toRefs, watch } from 'vue'
import { useVModel } from '@vueuse/core'
import type { JSX } from 'vue/jsx-runtime'
import { RemoveFilled, Plus } from '@element-plus/icons-vue'
import qaTreeSelect from './qaTreeSelect.vue'
import { realUnitConversion } from '@/utils'

export default defineComponent({
  name: 'qaFormItem',
  props: {
    action: String,
    props: Object,
    modelValue: {
      type: Object,
      default: () => ({}),
    },
    formType: String,
    label: String,
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
    data: Array,
    dateType: String,
    valueFormat: String,
    format: String,
    pickerOptions: Object,
    show: Array,
    showRule: [Function, String],
    disabled: [Function, String],
    watch: Function,
  },
  emits: ['update:modelValue', 'search'],
  setup(props, { emit, slots }) {
    /* ---------------- v-model ---------------- */
    const model = useVModel(props, 'modelValue', emit)
    const { formType, showRule, disabled } = toRefs(props)

    watch(
      () => model.value?.[props.itemKey],
      (val) => props.watch?.(val),
      { deep: true }
    )

    /* ---------------- 通用逻辑 ---------------- */
    const isShow = () => {
      if (formType.value === 'query') return true
      if (!props.show) return true
      return props.show.includes(formType.value)
    }

    const isShowRule = () => {
      if (typeof showRule.value === 'function') {
        return showRule.value(model.value)
      }
      if (typeof showRule.value === 'string') {
        const match = showRule.value.match(/^(\w+)\s*==\s*(.+)$/)
        if (!match) return true
        const [, key, value] = match
        return model.value?.[key] == value
      }
      return true
    }

    const isDisabled = () => {
      if (typeof disabled.value === 'function') {
        return disabled.value(model.value) === false
      }
      if (typeof disabled.value === 'string') {
        const match = disabled.value.match(/^(\w+)\s*==\s*(.+)$/)
        if (!match) return false
        const [, key, value] = match
        return model.value?.[key] != value
      }
      return false
    }

    /* ---------------- renderers ---------------- */

    const renderText = ({ value, label, onChange, placeholder }) => (
      <el-input
        modelValue={value}
        clearable
        disabled={isDisabled()}
        placeholder={placeholder || `请输入${label}`}
        style={{ width: realUnitConversion(props.width) }}
        onUpdate:modelValue={onChange}
        onClear={() => emit('search')}
      />
    )

    const renderTextarea = ({ value, label, onChange, placeholder }) => (
      <el-input
        type="textarea"
        modelValue={value}
        clearable
        disabled={isDisabled()}
        placeholder={placeholder || `请输入${label}`}
        style={{ width: realUnitConversion(props.width) }}
        onUpdate:modelValue={onChange}
      />
    )

    const renderSwitch = ({ value, onChange }) => (
      <el-switch
        modelValue={value}
        disabled={isDisabled()}
        onUpdate:modelValue={onChange}
      />
    )

    const renderRadio = ({ value, onChange, data = [] }) => (
      <el-radio-group modelValue={value} onUpdate:modelValue={onChange}>
        {data.map((item) => (
          <el-radio key={item.value} value={item.value}>
            {item.label}
          </el-radio>
        ))}
      </el-radio-group>
    )

    const renderDate = ({ value, dateType, format, valueFormat, onChange, placeholder }) => (
      <el-date-picker
        modelValue={value}
        type={dateType}
        format={format}
        valueFormat={valueFormat}
        disabled={isDisabled()}
        placeholder={placeholder}
        style={{ width: realUnitConversion(props.width) }}
        onUpdate:modelValue={onChange}
        onClear={() => emit('search')}
      />
    )

    const renderArrayString = ({ value = [], onChange }) => {
      const list = Array.isArray(value) ? value : []

      const update = (i, v) => {
        const arr = [...list]
        arr[i] = v
        onChange(arr)
      }

      const remove = (i) => onChange(list.filter((_, idx) => idx !== i))
      const add = () => onChange([...list, ''])
      const clear = () => onChange([])

      return (
        <div class="flex flex-col gap-[12px] w-full">
          {list.map((item, index) => (
            <el-input
              key={index}
              modelValue={item}
              onUpdate:modelValue={(v) => update(index, v)}
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

    const renderTreeSelect = ({ value, onChange, action, itemProps }) => (
      <>
        <el-button onClick={() => (showTreeSelect.value = true)}>
          {value || '选择'}
        </el-button>

        <qa-tree-select
          show={showTreeSelect.value}
          action={action}
          modelValue={value}
          defaultProps={itemProps}
          onUpdate:show={(v) => (showTreeSelect.value = v)}
          onTreeSelectConfirm={(data) => {
            onChange(data ? data[itemProps.value] : null)
          }}
        />
      </>
    )

    /* ---------------- 映射表 ---------------- */
    const renderMap: Record<string, (p: any) => JSX.Element> = {
      text: renderText,
      textarea: renderTextarea,
      switch: renderSwitch,
      radio: renderRadio,
      date: renderDate,
      'array<string>': renderArrayString,
      'tree-select': renderTreeSelect,
    }

    /* ---------------- render ---------------- */
    return () => {
      if (!(isShow() && isShowRule())) return null

      const renderer = renderMap[props.type]

      return (
        <el-form-item
          label={props.showLabel ? props.label : ''}
          labelWidth={props.showLabel ? props.labelWidth : '0'}
          prop={props.itemKey}
        >
          {slots.default?.() ||
            renderer?.({
              value: model.value[props.itemKey],
              label: props.label,
              placeholder: props.placeholder,
              action: props.action,
              itemProps: props.props,
              data: props.data,
              dateType: props.dateType,
              valueFormat: props.valueFormat,
              format: props.format,
              pickerOptions: props.pickerOptions,
              onChange: (v) => (model.value[props.itemKey] = v),
            })}

          {props.tips && formType.value !== 'query' && (
            <div class="text-[#909399] text-[12px] mt-[4px]">
              {props.tips}
            </div>
          )}
        </el-form-item>
      )
    }
  },
})
</script>
