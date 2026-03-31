<template>
<!--  <div class="flex flex-col h-full">-->
<!--    <qa-data-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm" :pagination="false"-->
<!--                   :right-btns="['detail_auto', 'update', 'delete', 'more']" :right-btns-more="table.rightBtnsMore" :row-no="true"-->
<!--                   @selection-change="selectionChange" @update="updateBtn" @delete="deleteBtn" />-->

<!--    <el-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">-->
<!--      <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"-->
<!--               :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"-->
<!--               :before-action="form.props.beforeAction" @success="form.props.show = false, refresh()">-->
<!--      </qa-form>-->
<!--    </el-dialog>-->
<!--  </div>-->
    <div>演示</div>
</template>

<script setup lang="ts">
import type { Columns, RightBtnMoreItem, DeleteRequest } from '@/components/quickAdmin/table/qaTable.vue'
import { cloneDeep } from '@/utils'

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
    disabled: (_row) => {
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
    "key": "_id",
    "title": "ID，系统自动生成",
    "type": "text",
    "width": 200,
    "mode": "="
  }]
})

const originalFormData = {
}

const form = ref({
  data: cloneDeep(originalFormData),
  props: {
    // 请求预处理
    beforeAction: (_formData: any) => {
      return true
    },
    action: '/app/admin/system/systemLog/systemLog/add',
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
      {
        "key": "user_id",
        "title": "用户ID",
        "type": "text",
        width: 250,
        showLabel: true,
        show: ['add', 'edit'],
        watch: (res: any) => {
          console.log("watch", res)
        }
      },
      {
        key: "date1", title: "日期", type: "date", valueFormat: "x", tips: "可选择年月日", dateType: "date",
        format: "YYYY-MM-DD HH:mm:ss",
        width: 250,
        show: ['add', 'edit'],
        // showRule:"user_id==自定义文案",
        // showRule:(formData: any)=>{
        //   console.log('带就不',formData)
        //   if(formData.user_id === "123456") return true
        //   else return false
        // },
        disabled: "user_id==自定义文案"
      }
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

const formRefs = ref()

// 表单重置
const resetForm = async () => {
  form.value.data = cloneDeep(originalFormData)
  await nextTick()
  formRefs.value?.clearValidate?.()
}


// 多选逻辑
const multipleSelection = ref([])
const selectionChange = (row: any) => {
  console.log(row)
  multipleSelection.value = row
}


const updateBtn = (index: number, row: any) => {
  console.log("调用编辑", index, row)
  resetForm()
  form.value.props.formType = 'edit';
  form.value.props.title = '编辑'
  form.value.props.show = true
  console.log("调用编辑", index, row)
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