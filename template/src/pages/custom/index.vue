<template>
    <div class="flex flex-col h-full">
      <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search"/>
      <div>
        <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
      </div>
      <qa-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm"
                :pagination="false" :right-btns="['detail_auto', 'delete', 'update']"
                :row-no="true" @selection-change="selectionChange" @update="updateBtn"
                @delete="deleteBtn"/>
  
  
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
  import {CirclePlus} from '@element-plus/icons-vue'
  import {cloneDeep} from '@/utils'
  
  const formRefs = ref()
  
  const qaTableRef = ref<QaTableInstance | null>(null);
  const table = ref<{
    action: string,
    columns: Columns[]
  }>({
    action: '/app/admin/custom/custom/getList',
    columns: [
      {
        key: "_id",
        type: 'text',
        title: "记录ID(唯一ID)",
        width: 240
      },
          {
      key:  "username",
      type:  "text",
      title:  "用户名",
      width:  200
    },
    {
      key:  "age",
      type:  "text",
      title:  "年龄",
      width:  200
    },
    {
      key:  "sex",
      type:  "text",
      title:  "sex",
      width:  200
    }
    ]
  })
  const search = () => {
    if (qaTableRef.value) {
      qaTableRef.value.search()
    }
  }
  
  const queryForm = ref({
    formData: {},
    columns: [
          {
      key:  "username",
      type:  "text",
      title:  "用户名",
      width:  200,
      mode:  "="
    },
    {
      key:  "age",
      type:  "text",
      title:  "年龄",
      width:  200,
      mode:  "="
    },
    {
      key:  "sex",
      type:  "text",
      title:  "sex",
      width:  200,
      mode:  "="
    }
    ]
  })
  
  // 多选逻辑
  const multipleSelection = ref([])
  const selectionChange = (row: any) => {
    console.log(row)
    multipleSelection.value = row
  }
  
  // 默认拉取列表参数
  const originalFormData = {}
  
  const form = ref({
    data: cloneDeep(originalFormData),
    props: {
      action: '/app/admin/custom/custom/add',
      columns: [
              {
        key:  "username",
        type:  "text",
        title:  "用户名"
      },
      {
        key:  "age",
        type:  "number",
        title:  "年龄",
        step:  1
      },
      {
        key:  "sex",
        type:  "radio",
        title:  "sex",
        data:  [
          {
            value:  "0",
            label:  "男"
          },
          {
            value:  "1",
            label:  "女"
          }
        ]
      }
      ],
      rules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" }
        ]
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
      action: '/app/admin/custom/custom/delete',
      data: {
        _id: row._id
      }
    })
  }
  </script>
  
  <style lang="vue" scoped>
  
  </style>
