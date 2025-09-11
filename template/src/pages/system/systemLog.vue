<template>
  <div>
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />

    <qa-data-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm"
      :pagination="false" :right-btns="['detail_auto', 'delete']" :right-btns-more="table.rightBtnsMore" :row-no="true"
      @selection-change="selectionChange" @update="updateBtn" @delete="deleteBtn" />
  </div>
</template>

<script setup lang="ts">
import type { Columns, RightBtnMoreItem, DeleteRequset } from '@/components/quickAdmin/qaTable.vue'
import qaDataTable from '@/components/quickAdmin/qaTable.vue';
import qaTableQuery from '@/components/quickAdmin/qaTableQuery.vue';


const qaTableRef = ref<InstanceType<typeof qaDataTable> | null>(null);
const table = ref<{
  action: string,
  columns: Columns[]
  rightBtnsMore: RightBtnMoreItem[]
}>({
  action: '/app/admin/system/systemLog/systemLog/getList',
  columns: [
    {
      key: "_id",
      type: 'text',
      title: "记录ID(唯一ID)",
      width: 240
    },
    {
      key: "",
      type: "group",
      title: "请求信息",
      width: 500,
      columns: [
        {
          key: "url",
          type: "text",
          title: "请求地址",
        },
        {
          key: "method",
          type: "tag",
          title: "请求类型",
          data: [
            {
              value: 'GET',
              label: "GET",
              tagType: "success"
            },
            {
              value: 'POST',
              label: "POST",
              tagType: "primary"
            }
          ]
        },
        {
          key: "requestId",
          title: "请求ID",
          type: "text"
        }
      ]
    },
    {
      key: "statusCode",
      title: "状态码",
      type: 'tag',
      data: [
        {
          value: 200,
          label: "成功",
          tagType: "success"
        },
        {
          value: 500,
          label: "错误",
          tagType: "danger"
        },
        {
          value: 0,
          label: "等待",
          tagType: "warning"
        }
      ]
    },
    {
      key: "_add_time_str",
      title: "时间",
      type: 'text'
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

const search = () => {
  if (qaTableRef.value) {
    qaTableRef.value.search()
  }
}

const queryForm = ref({
  formData: {
  },
  columns: [{
    key: "_add_time",
    type: "datetimerange",
    title: "添加时间",
    "mode": "[]"
  },
  {
    key: "requestId",
    type: "text",
    title: "请求ID",
    mode: "=",
    width: 300
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
    action: '/app/admin/system/systemLog/systemLog/delete',
    data: {
      _id: row._id
    }
  })
}
</script>

<style lang="vue" scoped>

</style>