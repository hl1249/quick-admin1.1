<template>
  <div class="flex flex-col h-full">
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />
    <div>
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
    </div>
    <qa-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm"
              :pagination="false" :right-btns="['detail_auto', 'delete', 'update']"
              :row-no="true" @selection-change="selectionChange" @update="updateBtn"
              @delete="deleteBtn" />


    <qa-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
      <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"
               :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
                @success="()=>{
            form.props.show = false
            refresh()
          }">
      </qa-form>
    </qa-dialog>
  </div>
</template>

<script setup lang="ts">
import { CirclePlus } from '@element-plus/icons-vue'
import { cloneDeep, getCommonTime } from '@/utils'

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

const qaTableRef = ref<QaTableInstance | null>(null);
const table = ref<{
  action: string,
  columns: Columns[]
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
      key: "url",
      type: "text",
      title: "请求地址",
      width: 200
    },
  ]
})
const search = () => {
  if (qaTableRef.value) {
    qaTableRef.value.search()
  }
}

const queryForm = ref({
  formData: {
  },
  columns: [
    {
      key: "requestId",
      type: "text",
      title: "_id",
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

const originalFormData = {
}

const form = ref({
  data: cloneDeep(originalFormData),
  props: {
    action: '/app/admin/system/systemLog/systemLog/add',
    columns: [

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
  form.value.data = cloneDeep(originalFormData)
  await nextTick()
  formRefs.value?.clearValidate?.()
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