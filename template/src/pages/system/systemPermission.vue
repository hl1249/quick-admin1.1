<template>
  <div class="flex flex-col h-full">
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />
    <div>
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
    </div>
    <qa-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm"
      :pagination="false" :right-btns="['detail_auto', 'delete', 'update']" :right-btns-more="table.rightBtnsMore"
      @update="updateBtn" highlight-current-row @current-change="currentChange" @delete="deleteBtn" />


    <el-dialog width="700" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
      <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"
        :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
        :before-action="form.props.beforeAction" @success="()=>{
          form.props.show = false
          refresh()
        }"
        @closeForm="form.props.show = false">
      </qa-form>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import type qaTable from '@/components/quickAdmin/table/qaTable.vue'
import type { Columns, RightBtnMoreItem, DeleteRequest } from '@/components/quickAdmin/table/qaTable.vue'
import { CirclePlus } from '@element-plus/icons-vue'
import http from '@/utils/axios'
import { cloneDeep } from '@/utils'


const currentChange = (row: any) => {
  selectItem.value = row
}

const selectItem = ref()
const qaTableRef = ref<InstanceType<typeof qaTable> | null>(null);
const table = ref<{
  action: string
  columns: Columns[]
  rightBtnsMore: RightBtnMoreItem[]
}>({
  action: '/app/admin/system/systemPermission/systemPermission/getList',
  columns: [
    {
      "key": "permission_id",
      "title": "权限标识",
      "type": "text",
      "width": 200
    },
    {
      "key": "permission_name",
      "title": "权限名称",
      "type": "text",
    },
    {
      "key": "comment",
      "title": "备注",
      "type": "text",
    },
    {
      "key": "url",
      "title": "URL",
      "type": "json",
      "width": 500
    },
    {
      "key": "match_mode",
      "title": "匹配模式",
      "type": "text",
      formatter: (_val: any, row: any, _column: any, _index: number) => {
        let str = "";
        if (row.match_mode == "0") {
          str = "完整路径";
        } else if (row.match_mode == "1") {
          str = "通配符";
        } else if (row.match_mode == "2") {
          str = "正则表达式"
        }
        return str;
      },
    },
    {
      key: "enable",
      type: 'switch',
      title: "是否启用",
      watch: (res) => {
        let { value, row, change } = res;
        http.request({
          method: 'POST',
          url: "/app/admin/system/systemPermission/systemPermission/updateBase",
          data: {
            _id: row._id,
            enable: value
          }
        }).then((_res) => {
          change(value)
        })
      }
    },
    {
      key: "_add_time_str",
      title: "时间",
      type: 'text',
      width: 240,
    },
  ],
  rightBtnsMore: [],
})
const search = () => {
  if (qaTableRef.value) {
    qaTableRef.value.search()
  }
}

const queryForm = ref({
  formData: {
  },
  columns: [{
    key: "role_id",
    type: "text",
    title: "角色标识",
    width: 230,
    "mode": "=",
  },
  {
    key: "role_name",
    type: "text",
    title: "角色名称",
    mode: "=",
    width: 230,
  },
  {
    key: "_add_time",
    type: "datetimerange",
    title: "添加时间",
    "mode": "[]",
    width: 230,
  }]
})

/** 表单 data 类型，支持 enable、parent_id、permission_id 等字段 */
interface PermissionFormData {
  enable?: boolean
  parent_id?: string
  permission_id?: string
  [key: string]: unknown
}

const originalFormData: PermissionFormData = {
  enable: true,
}

const form = ref({
  data: cloneDeep(originalFormData) as PermissionFormData,
  props: {
    // 请求预处理
    beforeAction: (_formData: any) => {
      return true
    },
    action: '/app/admin/system/systemPermission/systemPermission/add',
    columns: [
      {
        "key": "permission_id",
        "title": "权限标识",
        "type": "text",
      },
      {
        "key": "permission_name",
        "title": "权限名称",
        "type": "text",
      },
      {
        "key": "url",
        "title": "URL",
        "type": "array<string>",
      },
      {
        "key": "match_mode",
        "title": "匹配模式",
        "type": "radio",
        data: [
          { value: 0, label: "完整路径" },
          { value: 1, label: "通配符" },
          { value: 2, label: "正则表达式" },
        ]
      },
      {
        "key": "parent_id",
        "title": "父级权限",
        "type": "tree-select",
        "width": 500,
        action: "app/admin/system/SystemPermission/SystemPermission/getList",
        props: { list: "rows", value: "permission_id", label: "permission_name", children: "children" },
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
  form.value.data = cloneDeep(originalFormData) as PermissionFormData
  await nextTick()
  formRefs.value?.clearValidate?.()
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
      parent_id:selectItem.value.permission_id,
      permission_id:selectItem.value.permission_id + '-'
    }
  }
  form.value.props.show = true

}
const updateBtn = (index: number, row: any) => {
  resetForm()
  form.value.props.action = '/app/admin/system/systemPermission/systemPermission/update';
  form.value.props.formType = 'edit';
  form.value.props.title = '编辑'
  form.value.props.show = true
  form.value.data = row;
  console.log("调用编辑", index, row)
}
const deleteBtn = (row: any, btnsDeleteRequest: DeleteRequest) => {
  btnsDeleteRequest({
    action: '/app/admin/system/systemPermission/systemPermission/delete',
    data: {
      _id: row._id
    }
  })
}
</script>

<style lang="vue" scoped>

</style>