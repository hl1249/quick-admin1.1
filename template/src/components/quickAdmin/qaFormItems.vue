<template>
  <el-form-item :label="label" :prop="prop" :label-width="labelWidth" style="margin-bottom: 10px;">
    <!-- 如果是文本输入框 -->
    <el-input clearable v-model="value" v-if="type === 'text'" :placeholder="label" :disabled="disabled" @clear="clearValue"
      :style="`width:${width}px`"></el-input>

    <!-- 如果是文本域 -->
    <el-input clearable v-model="value" v-if="type === 'textarea'" type="textarea" :placeholder="label" @clear="clearValue"
      :style="`width:${width}px`"></el-input>

    <!-- 如果是金额 -->
    <el-input clearable v-model="value" v-if="type === 'money'" :placeholder="label" :style="`width:${width}px`" @clear="clearValue"
      type="number"></el-input>

    <!-- 如果是数字输入框 -->
    <el-input-number clearable v-model="value" v-if="type === 'number'" :placeholder="label"
      :style="`width:${width}px`"></el-input-number>

    <!-- 如果是百分比输入 -->
    <el-input clearable v-model="percentageValue" oninput="value=value.replace(/^0|[^0-9]/g, '')"
      v-if="type === 'percentage'" :placeholder="label" :style="`width:${width}px`" type="text">
      <template #append>%</template>
    </el-input>

    <!-- 如果是折扣输入 -->
    <el-input-number clearable v-model="discountValue" :controls="false" v-if="type === 'discount'" :placeholder="label"
      :min="0" :max="10" :style="`width:${width}px`" type="number">x
    </el-input-number>

    <!-- 如果是radio选择框 -->
    <el-radio-group v-model="value" v-if="type === 'radio'" :style="`width:${width}px`">
      <el-radio v-for="option in data" :key="option.value" :label="option.value" :value="option.value">{{ option.label
        }}</el-radio>
    </el-radio-group>

    <!-- 如果是checkbox选择框 -->
    <el-checkbox-group v-model="value" v-if="type === 'checkbox'" :style="`width:${width}px`">
      <el-checkbox v-for="option in data" :key="option.value" :label="option.value" :value="option.value">{{
        option.label }}</el-checkbox>
    </el-checkbox-group>

    <!-- 如果是下拉选择框 -->
    <el-select v-model="value" v-if="type === 'select'" clearable :placeholder="label" :style="`width:${width}px`">
      <el-option v-for="option in data" :key="option.value" :label="option.label" :value="option.value"></el-option>
    </el-select>

    <!-- 如果是日期选择框 -->
    <el-date-picker v-model="value" v-if="type === 'date'" type="date" :style="`width:${width}px`" value-format="x"
      @change="emit('search')"></el-date-picker>

    <!-- 如果是开关 -->
    <el-switch v-model="value" v-if="type === 'switch'" :style="`width:${width}px`"></el-switch>

    <!-- 如果是日期选择框 -->
    <el-date-picker v-model="value" v-if="type === 'datetimerange'" type="datetimerange" :style="`width:${width}px`"
      range-separator="至" start-placeholder="开始时间" end-placeholder="结束时间" value-format="x"
      @change="emit('search')"></el-date-picker>


    <!-- 如果是远程下拉 -->
    <div v-if="type === 'table-select'" class="flex items-center gap-[10px] flex-wrap">
      <el-tag v-if="multiple" v-for="item, index in tableSelectData" :key="item._id" closable disable-transitions
        @close="removeSelect(item, index)">{{ item }}</el-tag>
      <el-tag v-if="!multiple && modelValue" disable-transitions type="primary" closable @close="clearValue">{{
        selectioData ? selectioData && selectioData[nameKey] : value }}</el-tag>
      <el-button @click="openTableSelect">{{ placeholder || '选择' }}</el-button>
    </div>

    <!-- 如果是图标选择 -->
    <div v-if="type === 'icon'" class="flex items-center gap-[10px] flex-wrap">

      <el-button @click="openIconSelect">
        <el-icon v-if="value" size="15">
          <component :is="value"></component>
        </el-icon>
        <span v-else> {{ placeholder || '请选择图标' }}</span>
      </el-button>
      <el-icon class="cursor-pointer" @click="clearValue" v-if="value" size="15">
        <CircleClose />
      </el-icon>
    </div>

    <!-- 如果是树形选择 -->
    <!-- <div v-if="type === 'tree-select'" class="flex items-center gap-[10px] flex-wrap">
      <el-button @click="openTreeSelect">
        <span v-if="value"> {{ treeSelectData[props.props?.value ?? ''] }}（{{ treeSelectData[props.props?.label ?? ''] }}）</span>
        <span v-else> {{ placeholder || '请选择' }}</span>
      </el-button>
      <el-icon class="cursor-pointer" @click="clearValue" v-if="value" size="15">
        <CircleClose />
      </el-icon>
    </div> -->


    <div v-if="tips" class="w-full text-gray-400 text-[12px]">{{ tips }}</div>
  </el-form-item>


  <!-- 图标选择器 -->
  <!-- <qa-icon-select ref="iconSelect" @iconSelectConfirm="iconSelectConfirm" v-model="value" :placeholder="placeholder" /> -->

  <!-- 表格选择器 -->
  <!-- <qa-table-select ref="tableSelect" @tableSelectConfirm="tableSelectConfirm" :action="action" v-model="value"
    :placeholder="placeholder" :nameKey="nameKey" :idKey="idKey" :columns="columns" :queryColumns="queryColumns"
    :multiple="multiple" /> -->

  <!-- 树形选择器 -->
  <!-- <qa-tree-select v-if="type === 'tree-select'" :defaultProps="props?.props" :data="data" ref="treeSelect"
    @treeSelectConfirm="treeSelectConfirm" :action="action" v-model="value"></qa-tree-select> -->
</template>

<script setup lang="ts">
// import qaTableSelect from './qa-table-select.vue';
// import qaIconSelect from './qa-icon-select.vue';
// import qaTreeSelect from './qa-tree-select.vue';

interface Columns {
  key: string;
  title: string;
  type: string;
  width?: number; // 可选字段
  minWidth?: number;
  align?: string;
  mode?: string;
  disabled?: boolean;
  placeholder?: string;
  data?: any[];
  columns?: Columns[];
  idKey?: boolean;
  nameKey?: boolean;
}

interface PropsType {
  list: string;
  value: string;
  label: string;
  children: string;
}

const tableSelect = ref<null | ComponentPublicInstance<{ open: () => void }>>(null);
const iconSelect = ref<null | ComponentPublicInstance<{ open: () => void, close: () => void }>>(null);
const treeSelect = ref<null | ComponentPublicInstance<{ open: () => void, close: () => void }>>(null);
const props = withDefaults(
  defineProps<{
    formData?: any;
    modelValue: any;
    label: string;
    type: string;
    data?: any[];
    prop?: string;
    disabled?: boolean;
    columns?: Columns[];
    labelWidth?: string | number;
    width?: number;
    minWidth?: number;
    placeholder?: string;
    action?: string;
    multiple?: boolean;
    queryColumns?: Columns[];
    columnsIndex?: number;
    tips?: string;
    props?: PropsType;
    watch?: (val: any, formData: any, column: Columns[], index: number, option: any) => void;
  }>(),
  {
    columnsIndex: 0,
  }
)


const value = ref(props.modelValue)
const emit = defineEmits(['update:modelValue','search'])

const nameKey = ref(props.columns?.find((item) => { return item.nameKey })?.key || '_id')
const idKey = ref(props.columns?.find((item) => { return item.idKey })?.key || '_id')


const tableSelectData = ref<any[] | null>(null);
const keySelectData = ref<any[] | null>(null);
keySelectData.value = props.modelValue && JSON.parse(JSON.stringify(props.modelValue))
tableSelectData.value = props.modelValue && JSON.parse(JSON.stringify(props.modelValue))

const selectioData = ref(null)
const tableSelectConfirm = (value: any) => {
  console.log('确认多选', value)
  // 多选
  if (props.multiple) {
    if (!value) {
      emit('update:modelValue', [])
      return
    }

    selectioData.value = value
    const keyResult = value.map((item: any) => {
      return item[idKey.value]
    })
    keySelectData.value = keyResult

    const nameResult = value.map((item: any) => {
      return item[nameKey.value]
    })
    tableSelectData.value = nameResult
    emit('update:modelValue', keyResult)
  }
  // 单选
  if (!props.multiple) {
    if (!value) {
      clearValue()
      return
    }

    selectioData.value = value
    keySelectData.value = value[nameKey.value]
    tableSelectData.value = value[idKey.value]
    emit('update:modelValue', value[idKey.value])
  }

}

const iconSelectConfirm = (value: any) => {
  iconSelect.value && iconSelect.value.close()
  emit('update:modelValue', value)
}
const clearValue = () => {
  emit('update:modelValue', null)
  emit('search')
}


interface TreeSelectData {
  [key: string]: string; // 假设键和值都是字符串类型
}
const treeSelectData = ref<TreeSelectData>({})
const openTreeSelect = () => {
  treeSelect.value && treeSelect.value.open()
}
const treeSelectConfirm = (value: any) => {
  console.log("我执行复制了",value)
  treeSelectData.value = value
  emit('update:modelValue', value[props.props?.value ?? ''])
}

const removeSelect = (item: any, index: number) => {
  if (Array.isArray(tableSelectData.value)) {
    tableSelectData.value.splice(index, 1)
  }
  if (Array.isArray(keySelectData.value)) {
    keySelectData.value.splice(index, 1)
  }
  emit('update:modelValue', keySelectData.value)
}


// 百分比
const percentageValue = computed({
  get() {
    // 显示值是父组件传来的值除以100
    return props.modelValue * 100;
  },
  set(val: number) {
    // 输入值变化时，传回父组件时乘以100
    emit('update:modelValue', val / 100);
  }
});

// 折扣
const discountValue = computed({
  get() {
    // 显示值是父组件传来的值除以100
    return props.modelValue * 10;
  },
  set(val: number) {
    // 输入值变化时，传回父组件时乘以100
    emit('update:modelValue', val / 10);
  }
})

// 打开表格选择
const openTableSelect = () => {
  if (tableSelect.value) {
    tableSelect.value.open()
  }
}

// 打开图标选择
const openIconSelect = () => {
  iconSelect.value && iconSelect.value.open()
}

watch(value, (newValue) => {
  emit('update:modelValue', newValue)
  props.watch && props.watch(newValue, props.formData, props.columns as Columns[], props.columnsIndex, selectioData.value)
}, { deep: true })

watch(() => props.modelValue, (newVal) => {
  value.value = newVal
})
</script>

<style scoped></style>
