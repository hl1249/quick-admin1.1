<template>
  <div class="flex flex-col h-full">
    <div>
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
    </div>
    <qa-table ref="qaTableRef" :action="table.action" :columns="table.columns"
      :pagination="false" :right-btns="['detail_auto', 'delete', 'update']" :right-btns-more="table.rightBtnsMore"
      @update="updateBtn" highlight-current-row @current-change="currentChange" @delete="deleteBtn" />


    <el-dialog width="700" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
      <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"
        :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
        :before-action="form.props.beforeAction" @success="form.props.show = false, refresh()"
        @closeForm="form.props.show = false">
      </qa-form>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import type { Columns, RightBtnMoreItem, DeleteRequset } from '@/components/quickAdmin/qaTable.vue'
import qaTable from '@/components/quickAdmin/qaTable.vue';
import qaForm from '@/components/quickAdmin/qaForm.vue';
import { CirclePlus, Tools } from '@element-plus/icons-vue'
import { renderComponent } from '@/utils'
import http from '@/utils/axios'
import { title } from 'process';


const currentChange = (row: any) => {
  selectItem.value = row
}

const selectItem = ref()
const qaTableRef = ref<InstanceType<typeof qaTable> | null>(null);
const table = ref<{
  action: string,
  columns: Columns[]
  rightBtnsMore: RightBtnMoreItem[]
}>({
  action: '/app/admin/system/systemMenu/systemMenu/getList',
  columns: [
    {
      "key": "menu_id",
      "title": "菜单标识",
      "type": "text",
      "width": 250
    },
    {
      "key": "title",
      "title": "菜单名称",
      "type": "text",
      "width": 150
    },
    {
      "key": "comment",
      "title": "备注",
      "type": "text",
      "width": 300
    },
    {
      "key": "component",
      "title": "菜单URL",
      "type": "text",
      "width": 500
    },
    {
      key: "enable",
      type: 'switch',
      title: "是否启用",
      watch: (res) => {
        let {value, row, change} = res;
        http.request({
          method: 'POST',
          url: "/app/admin/system/systemMenu/systemMenu/updateBase",
          data: {
            _id: row._id,
            enable: value
          }
        }).then((res) => {
          change(value);
        });
      }
    },
    {
      key: "_add_time_str",
      title: "时间",
      type: 'text',
      width: 240,
    },
  ],
  rightBtnsMore: []
})
const search = () => {
  if (qaTableRef.value) {
    qaTableRef.value.search()
  }
}

const form = ref({
  data: {
    enable: true,
    menu_id: '',
    title: '',
    url: [],
    parent_id: '',
    comment: '',
  },
  props: {
    // 请求预处理
    beforeAction: (formData: any) => {
      return true
    },
    action: '/app/admin/system/systemMenu/systemMenu/add',
    columns: [
      {
        "key": "menu_id",
        "title": "菜单标识",
        "type": "text",
      },
      {
        "key": "title",
        "title": "菜单名称",
        "type": "text",
      },
      {
        "key": "url",
        "title": "URL",
        "type": "array<string>",
      },
      {
        "key": "parent_id",
        "title": "父级菜单",
        "type": "tree-select",
        "width": 500,
        action: "app/admin/system/SystemMenu/SystemMenu/getList",
        props: { list: "rows", value: "menu_id", label: "title", children: "children" },
      },
      {
        "key": "enable",
        "title": "是否启用",
        "type": "switch",
      },
      {
        "key": "comment",
        "title": "备注",
        "type": "textarea",
      },
    ],
    rules: {
      user_id: [
        { min: 3, max: 5, message: '长度3-5', trigger: 'blur', required: true, },
      ],
    },
    formType: "",
    title: "",
    show: false
  }
})

// 表单组件ref
const formRefs = ref()
// 表格数据刷新
const refresh = () => {
  qaTableRef.value?.refresh()
}
// 表单数据重置
const resetForm = async () => {
  // 弹窗已经显示，子组件应该已经渲染完
  formRefs.value?.resetForm?.() // 安全调用
}
// 表单提交
const submitForm = () => {
  formRefs.value?.submitForm?.() // 安全调用
}
// 表单关闭
const closeForm = () => {
  form.value.props.show = false
}
const addBtn = () => {
  resetForm()
  form.value.props.formType = 'add';
  form.value.props.title = '添加'

  if(selectItem.value){
    form.value.data = {
      ...form.value.data,
      parent_id: selectItem.value.menu_id,
      menu_id: selectItem.value.menu_id + '-'
    }
  }
  form.value.props.show = true
}
const updateBtn = (index: number, row: any) => {
  resetForm()
  form.value.props.action = '/app/admin/system/systemMenu/systemMenu/update';
  form.value.props.formType = 'edit';
  form.value.props.title = '编辑'
  form.value.props.show = true
  form.value.data = row;
  console.log("调用编辑", index, row)
}
const deleteBtn = (row: any, btnsDeleteRequset: DeleteRequset) => {
  btnsDeleteRequset({
    action: '/app/admin/system/systemMenu/systemMenu/delete',
    data: {
      _id: row._id
    }
  })
}

const bindPermissionBtn = () => {
  renderComponent(bindPermission, {
    modelValue: true,
    selectItem: selectItem.value,
  })
}

const bindMenuBtn = () => {
  renderComponent(bindMenu, {
    modelValue: true,
    selectItem: selectItem.value,
  })
  // const row = qaTableRef?.value?.getCurrentRow(true)
}

</script>

<style lang="vue" scoped>

</style>