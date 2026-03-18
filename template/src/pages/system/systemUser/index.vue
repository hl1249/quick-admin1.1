<template>
  <div class="flex flex-col h-full">
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />

    <div>
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
      <el-button type="primary" :icon="Tools" :disabled="!selectItem" @click="bindPermissionBtn">角色绑定</el-button>
      <el-button type="danger" :icon="Tools" :disabled="!selectItem" @click="resetPasswordBtn">重置密码</el-button>
    </div>
    <qa-data-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm" :pagination="false"
      :right-btns="['detail_auto', 'update', 'delete', 'more']" :right-btns-more="table.rightBtnsMore" :row-no="true"
      @selection-change="selectionChange" @update="updateBtn" @delete="deleteBtn" @current-change="currentChange"   highlight-current-row/>
    
    <el-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
      <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"
        :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
        :before-action="form.props.beforeAction" @success="()=>{
          form.props.show = false
          refresh()
        }" @closeForm="form.props.show = false">
      </qa-form>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import type { Columns, RightBtnMoreItem, DeleteRequest } from '@/components/quickAdmin/qaTable.vue'
import qaDataTable from '@/components/quickAdmin/qaTable.vue';
import {cloneDeep, renderComponent} from '@/utils'
import {CirclePlus, Tools} from "@element-plus/icons-vue";
import bindRole from "./form/bindRole.vue";
import resetPassword from "./form/resetPassword.vue"


const bindPermissionBtn = () => {
  console.log('selectItem',selectItem)
  renderComponent(bindRole, {
    selectItem: selectItem.value,
    refresh
  })
}

const resetPasswordBtn = () => {
  renderComponent(resetPassword, {
    selectItem: selectItem.value,
    refresh
  })
}


const currentChange = (row: any) => {
  selectItem.value = row
}

const selectItem = ref()

const table = ref<{
  action: string,
  columns: Columns[]
  rightBtnsMore: RightBtnMoreItem[]
}>({
  action: '/app/admin/system/systemUser/systemUser/getList',
  columns: [
    {
      key: "",
      type: "group",
      width: 500,
      title: "分组",
      columns: [
        {
          key: "userInfo", title: "用户", type: "object",
          width: 200,
          columns: [
            { key: "name", title: "对象内字段1", type: "text" },
            { key: "age", title: "对象内字段2", type: "text" },
          ]
        },
        {
          "key": "last_login_date",
          "title": "添加时间",
          "type": "money",
          "width": 220,

        },
        {
          key: "",
          type: "group",
          title: "分组2",
          columns: [
            {
              key: "userInfo", title: "用户", type: "userInfo",
              width: 200
            },
            {
              "key": "last_login_date",
              "title": "添加时间",
              "type": "money",
            },
            {
              key: "",
              type: "group",
              title: "分组3",
              columns: [

                {
                  key: "userInfo", title: "用户", type: "object",
                  width: 200,
                  columns: [
                    { key: "avatar", title: "对象内字段1", type: "text" },
                    { key: "nickname", title: "对象内字段2", type: "text" },
                  ]
                },
                {
                  key: "username", title: "用户", type: "tag",
                  width: 200,
                  show: ['detail'],
                  data: [
                    { value: "admin", label: "收入", tagType: "success" },
                    { value: "agent", label: "支出", tagType: "danger" }
                  ]
                },
                {
                  "key": "last_login_date",
                  "title": "添加时间",
                  "type": "money",
                  "width": 220,

                },
              ]
            },
          ]
        },
      ]
    },
    {
      key:"object",
      type:"object",
      title:"对象",
       columns: [
        { key: "name", title: "对象内字段1", type: "text" },
        { key: "age", title: "对象内字段2", type: "text" },
      ],
    },
    {
      key: "userInfo", title: "用户", type: "userInfo",
      width: 200
    },
    {
      "key": "last_login_date",
      "title": "添加时间",
      "type": "money",
      "width": 220,

    },
    {
      "key": "icon",
      "title": "图标",
      "type": "icon",
      "data": [
        { value: 'Plus', icon: "Close", },
        { value: 'FullScreen', icon: "Check" }
      ]
    },
    {
      "key": "is_login",
      "title": "允许登陆",
      "type": "switch",
      "width": 200
    },
    {
      "key": "rate",
      "title": "评分",
      "type": "rate",
      "width": 200
    },
    {
      "key": "avatar",
      "title": "头像",
      "type": "avatar",
      shape: "circle"
    },
    {
      "key": "image",
      "title": "图像",
      "type": "image",
    },
    {
      "key": "username",
      "title": "用户名",
      "type": "text",
    },
    {
      "key": "role",
      "title": "角色",
      "type": "json",
      "width": 200
    },
  ],
  rightBtnsMore: [{
    title: "按钮1",
    disabled: () => {
      return false
    },
    onClick: (row) => {
      console.log("按1", row)
    }
  }]
})

const qaTableRef = ref()
// 表格数据刷新
const refresh = () => {
  qaTableRef.value?.refresh()
}

const queryForm = ref({
  formData: {

  },
  columns: [{
    key: "username",
    type: "text",
    title: "用户名",
    width: 230,
    "mode": "in",
  },
    {
      key: "nickname",
      type: "text",
      title: "用户昵称",
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

const search = () => {
  if (qaTableRef.value) {
    qaTableRef.value.search()
  }
}

const form = ref({
  data: {
  },
  props: {
    // 请求预处理
    beforeAction: (_formData: any) => {
      return true
    },
    action: '/app/admin/system/systemUser/systemUser/add',
    // action:  ({data}:{
    //   data: any
    // })=>{
    //   return http.request({
    //       url: '/app/admin/system/systemLog/systemLog/update',
    //       method: 'post',
    //       data,
    //       openMessage: false
    //   })
    // },
    columns: [
      { key: "username", title: "用户名", type: "text", width: 250, show: ['add'] },
      { key: "nickname", title: "昵称", type: "text", width: 250, show: ['add', 'edit'] },
      { key: "password", title: "密码", type: "text", width: 250, show: ['add'] },
      { key: "avatar", title: "头像", type: "text", width: 250, show: ['add', 'edit'], placeholder: "头像URL" },
      { key: "is_login", title: "允许登陆", type: "switch", width: 250, show: ['add', 'edit'] },
      { key: "rate", title: "评分", type: "rate", width: 250, show: ['add', 'edit'], placeholder: "1-5" },
      {
        key: "last_login_date",
        title: "添加时间",
        type: "date",
        valueFormat: "x",
        dateType: "datetime",
        format: "YYYY-MM-DD HH:mm:ss",
        width: 250,
        show: ['add', 'edit'],
      },
    ],
    rules: {
      username: [
        { required: true, message: '请输入用户名', trigger: 'blur' },
      ],
      nickname: [
        { required: true, message: '请输入昵称', trigger: 'blur' },
      ],
    },
    formType: "",
    title: "",
    show: false
  }
})

const formRefs = ref()

// 表单重置
const resetForm = () => {
  formRefs.value?.resetForm?.()
}


// 多选逻辑
const multipleSelection = ref([])
const selectionChange = (row: any) => {
  console.log(row)
  multipleSelection.value = row
}

const ADD_ACTION = '/app/admin/system/systemUser/systemUser/add'

const addBtn = () => {
  resetForm()
  form.value.data = {}
  form.value.props.action = ADD_ACTION
  form.value.props.formType = 'add'
  form.value.props.title = '添加'
  form.value.props.show = true
  nextTick(() => {
    formRefs.value?.setResetFormData?.({})
  })
}

const updateBtn = (index: number, row: any) => {
  resetForm()
  form.value.data = cloneDeep(row)
  form.value.props.action = '/app/admin/system/systemUser/systemUser/update'
  form.value.props.formType = 'edit'
  form.value.props.title = '编辑'
  form.value.props.show = true
  nextTick(() => {
    formRefs.value?.setResetFormData?.(form.value.data)
  })
}
const deleteBtn = (row: any, btnsDeleteRequest: DeleteRequest) => {
  btnsDeleteRequest({
    action: '/app/admin/system/systemUser/systemUser/delete',
    data: {
      _id: row._id
    }
  })
}
</script>

<style lang="vue" scoped>

</style>