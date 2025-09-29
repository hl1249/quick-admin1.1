<script lang="tsx">
import { defineComponent } from "vue";
import { useVModel } from "@vueuse/core";
import type { JSX } from "vue/jsx-runtime";

export default defineComponent({
  name: "qaFormItem",
  props: {
    modelValue: { type: Object, required: true },
    label: String,
    itemKey: { type: String, required: true },
    type: String,
    labelWidth: [String, Number],
  },
  emits: ["update:modelValue"],
  setup(props, { emit }) {
    const { label, itemKey, type } = props;
    const model = useVModel(props, "modelValue", emit);

    // 渲染输入框
    const renderText = ({ value, label, onChange }) => {
      return (
        <el-input
          modelValue={value}
          placeholder={"请输入" + label}
          onUpdate:modelValue={onChange}
        />
      );
    };

    // 不同类型的渲染映射
    const renderMap: Record<string, (params: any) => JSX.Element | null> = {
      text: ({ value, label, onChange }) =>
      renderText({ value, label, onChange }),
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
        <el-form-item label={label} prop={itemKey}>
          {render({
            value: model.value[itemKey],
            label,
            type,
            onChange: (val: string) => (model.value[itemKey] = val),
          })}
        </el-form-item>
      );
    };
  },
});
</script>
