<template>
  <div class="flex flex-col h-full">
    <div class="flex justify-between my-[8px]">
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
      <el-button :icon="Setting">修改配置信息</el-button>
    </div>
    <qa-table  ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm"
              :pagination="false" :right-btns="['delete', 'update']"
               @selection-change="selectionChange" @update="updateBtn"
              @delete="deleteBtn" />


    <el-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
      <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"
               :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
               :before-action="form.props.beforeAction" @success="()=>{
            form.props.show = false
            refresh()
          }">
        <template v-slot:user_id="{ form, keyName }">
          <div style="height: 36px;display: flex;align-items: center;">
            <br/>
            <el-input v-model="form[keyName]" placeholder="插槽输入框" />
          </div>
        </template>
      </qa-form>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import type { Columns, RightBtnMoreItem, DeleteRequest } from '@/components/quickAdmin/qaTable.vue'
import qaTable from '@/components/quickAdmin/qaTable.vue';
import qaForm from '@/components/quickAdmin/qaForm.vue';
import { CirclePlus, Setting } from '@element-plus/icons-vue'

const adopt = (status: number) => {
  formRefs.value.submitForm({
    // data为额外提交的参数，真正提交的参数为form1.data+这里的data
    data: {
      status: status
    },
    success: (_data:any) => {
      // 提交成功

    },
    fail: (_data:any) => {
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
      title: "存储空间名称",
    },
    {
      key: "_id",
      type: 'text',
      title: "区域",
    },
    {
      key: "_id",
      type: 'text',
      title: "空间域名",
    },
    {
      key: "_id",
      type: 'text',
      title: "使用状态",
    },
    {
      key: "_add_time_str",
      title: "创建时间",
      type: 'text',
    },
    {
      key: "_add_time_str",
      title: "更新时间",
      type: 'text',
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
const search = () => {
  if (qaTableRef.value) {
    qaTableRef.value.search()
  }

}


const queryForm = ref({
  formData: {
  },
  columns: []
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
    beforeAction: (_formData: any) => {
      return true
    },
    action: '/app/admin/system/systemLog/systemLog/add',
    columns: [
      {
        "key": "name",
        "title": "空间名称",
        "type": "text",
        width: 250,
        showLabel: true,
        show: ['add', 'edit'],
        watch: (res: any) => {
          console.log("watch", res)
        }
      },
      {
        "key": "region",
        "title": "空间区域",
        "type": "select",
        data: [
          { value: 0, label: "中国大陆" },
          { value: 1, label: "中国香港" },
          { value: 2, label: "中国澳门" },
          { value: 3, label: "中国台湾" },
        ],
        width: 250,
        showLabel: true,
        show: ['add', 'edit'],
        watch: (res: any) => {
          console.log("watch", res)
        }
      },
      {
        "key": "acl",
        "title": "读写权限",
        "type": "radio",
        data: [
          { value: 0, label: "读写" },
          { value: 1, label: "只读" },
        ],
        width: 250,
        showLabel: true,
        show: ['add', 'edit'],
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
const deleteBtn = (row: any, btnsDeleteRequest: DeleteRequest) => {
  btnsDeleteRequest({
    action: '/app/admin/system/systemLog/systemLog/delete',
    data: {
      _id: row._id
    }
  })
}
</script>

<style lang="vue" scoped>

</style>