<template>
  <div>
    form.data:{{ form.data }}
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />
    <div>
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
    </div>
    <qa-data-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm"
      :pagination="false" :right-btns="['detail_auto', 'delete']" :right-btns-more="table.rightBtnsMore" :row-no="true"
      @selection-change="selectionChange" @update="updateBtn" @delete="deleteBtn" />


    <div>
      <el-row>
        <el-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
          <qa-form v-model="form.data" :rules="form.props.rules" :action="form.props.action"
            :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
            @success="form.props.show = false, refresh()">
          </qa-form>
        </el-dialog>
      </el-row>
    </div>


  </div>
</template>

<script setup lang="ts">
import type { Columns, RightBtnMoreItem, DeleteRequset } from '@/components/quickAdmin/qaTable.vue'
import qaDataTable from '@/components/quickAdmin/qaTable.vue';
import qaTableQuery from '@/components/quickAdmin/qaTableQuery.vue';
import qaForm from '@/components/quickAdmin/qaForm.vue';
import { CirclePlus } from '@element-plus/icons-vue'
import { getCommonTime } from '@/utils'

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

const { todayStart, todayEnd, weekStart, weekEnd, monthStart, monthEnd, yearStart, yearEnd } = getCommonTime()
console.log('todayStart', todayStart)
console.log('todayEnd', todayEnd)
const queryForm = ref({
  formData: {
  },
  columns: [{
    key: "_add_time",
    type: "datetimerange",
    title: "添加时间",
    format: 'YYYY-MM-DD',
    width: 230,
    "mode": "[]",
    pickerOptions: {
      // defaultTime: ['00:00:00', '23:59:59'],
      shortcuts: [{
        text: '今天',
        value: () => {
          return [new Date(todayStart), new Date(todayEnd)]
        }
      }, {
        text: '本周',
        value: () => {
          return [new Date(weekStart), new Date(weekEnd)]
        }
      }, {
        text: '本月',
        value: () => {
          return [new Date(monthStart), new Date(monthEnd)]
        }
      }, {
        text: '本年',
        value: () => {
          return [new Date(yearStart), new Date(yearEnd)]
        }
      }]
    }
  },
  {
    key: "requestId",
    type: "text",
    title: "请求ID",
    mode: "=",
    width: 230,
  }]
})

// 多选逻辑
const multipleSelection = ref([])
const selectionChange = (row: any) => {
  console.log(row)
  multipleSelection.value = row
}

const form = ref({
  data: {
  },
  props: {
    action: '/app/admin/system/systemLog/systemLog/add',
    columns: [
      {
        "key": "user_id",
        "title": "用户ID",
        "type": "text",
        width: 250
      },
      {
        key: "date1", title: "date类型", type: "date", valueFormat: "x", tips: "可选择年月日", dateType: "date",
        format: "YYYY-MM-DD HH:mm:ss",
        width: 250
      }],
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

const refresh = () => {
  qaTableRef.value?.refresh()
}
const addBtn = () => {
  form.value.props.show = true
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