<script lang="tsx">
import { defineComponent } from "vue";
import { useVModel } from "@vueuse/core";

export default defineComponent({
  name: "MyComponent",
  props: {
    modelValue: { type: Object, required: true },
    label: {},
    itemKey: {
      type: String,
      required: true
    },
    type: {},
    labelWidth: {},
  },
  emits: ["update:modelValue"], // emit 名称要写
  setup(props, { emit }) {
    // 现在可以访问 props 和 emit
    const { label, itemKey, type, labelWidth } = props
    const model = useVModel(props, "modelValue", emit);

    return () => {
      return <el-form-item prop={itemKey}>
        <el-input modelValue={model.value[itemKey]}
          placeholder={'请输入' + label}
          label={label}
          onInput={(val: string) => (model.value[itemKey] = val)}></el-input>
      </el-form-item>
    };
  },
});
</script>
