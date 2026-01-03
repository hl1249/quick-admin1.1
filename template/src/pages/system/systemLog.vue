<template>
  <div class="flex flex-col h-full">
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />
    <div>
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
    </div>
    <qa-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm"
      :pagination="false" :right-btns="['detail_auto', 'delete', 'update', 'more']"
      :right-btns-more="table.rightBtnsMore" :row-no="true" @selection-change="selectionChange" @update="updateBtn"
      @delete="deleteBtn" />

  
      <el-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
        <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"
          :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
          :before-action="form.props.beforeAction" @success="form.props.show = false, refresh()">
            <template v-slot:user_id="{ form, keyName }">
            <view style="height: 36px;display: flex;align-items: center;">
              <br/>
              <el-input v-model="form[keyName]" placeholder="插槽输入框" />
            </view>
          </template>
            <template v-slot:footer="{ loading }">
              <view style="text-align: center;" >
                <el-button :loading="loading" type="danger"  size="small" style="padding: 10px 40px;margin-right: 30px; " @click="adopt(-1)"> 拒绝 </el-button>
                <el-button :loading="loading" type="success" size="small" style="padding: 10px 40px; " @click="adopt(1)"> 通过 </el-button>
              </view>
            </template>
        </qa-form>
        <el-button @click="fromDefalut">表单默认值</el-button>
      </el-dialog>
  </div>
</template>

<script setup lang="ts">
import type { Columns, RightBtnMoreItem, DeleteRequset } from '@/components/quickAdmin/qaTable.vue'
import qaTable from '@/components/quickAdmin/qaTable.vue';
import qaTableQuery from '@/components/quickAdmin/qaTableQuery.vue';
import qaForm from '@/components/quickAdmin/qaForm.vue';
import { CirclePlus } from '@element-plus/icons-vue'
import { getCommonTime } from '@/utils'

const adopt = (status: number) => {
  formRefs.value.submitForm({
    // data为额外提交的参数，真正提交的参数为form1.data+这里的data
    data: {
      status: status
    },
    success: (data:any) => {
      // 提交成功
      
    },
    fail: (data:any) => {
      // 提交失败
      
    }
  });
}

const formRefs = ref()
const fromDefalut = () => {
  formRefs.value.setResetFormData({ user_id: '我叼你妈的' })
  // 还原表单验证并恢复默认数据
  formRefs.value.resetFormDataDefault()
}

const qaTableRef = ref<InstanceType<typeof qaTable> | null>(null);
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
      type: 'text',
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

const queryForm = ref({
  formData: {
  },
  columns: [{
    key: "_add_time",
    type: "datetimerange",
    title: "添加时间",
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
    // 请求预处理
    beforeAction: (formData: any) => {
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

// 表格数据刷新
const refresh = () => {
  qaTableRef.value?.refresh()
}
// 表单数据重置
const resetForm = async () => {
  // 弹窗已经显示，子组件应该已经渲染完
  formRefs.value?.resetForm?.() // 安全调用
}
const addBtn = () => {
  resetForm()
  form.value.props.formType = 'add';
  form.value.props.title = '添加'
  form.value.props.show = true
}
const updateBtn = (index: number, row: any) => {
  resetForm()
  form.value.props.formType = 'edit';
  form.value.props.title = '编辑'
  form.value.props.show = true
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