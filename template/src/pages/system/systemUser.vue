<template>
  <div>
    <qa-data-table :action="table.action" :columns="table.columns" :query-form-param="queryForm" :pagination="false"
      :right-btns="['detail_auto', 'update', 'delete', 'more']" :right-btns-more="table.rightBtnsMore" :row-no="true"
      @selection-change="selectionChange" @update="updateBtn" @delete="deleteBtn" />
  </div>
</template>

<script setup lang="ts">
import type { Columns, RightBtnMoreItem, DeleteRequset } from '@/components/quickAdmin/qaTable.vue'
import qaDataTable from '@/components/quickAdmin/qaTable.vue';

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
                  key: "userInfo", title: "用户", type: "userInfo",
                  width: 200
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
      "type": "object",
      "width": 200
    },
  ],
  rightBtnsMore: [{
    title: "按钮1",
    disabled: (row) => {
      return false
    },
    onClick: (row) => {
      console.log("按1", row)
    }
  }]
})

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

// 多选逻辑
const multipleSelection = ref([])
const selectionChange = (row: any) => {
  console.log(row)
  multipleSelection.value = row
}


const updateBtn = (index: number, row: any) => {
  console.log("调用编辑", index, row)
}
const deleteBtn = (row: any, btnsDeleteRequset: DeleteRequset) => {
  btnsDeleteRequset({
    action: '/app/admin/system/systemUser/systemUser/delete',
    data: {
      _id: row._id
    }
  })
}
</script>

<style lang="vue" scoped>

</style>