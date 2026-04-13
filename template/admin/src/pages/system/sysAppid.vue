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
            }"
             @closeForm="form.props.show = false">
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
    action: '/app/admin/system/sysAppid/sysAppid/getList',
    columns: [
      {
        key: "_id",
        type: 'text',
        title: "记录ID(唯一ID)",
        width: 240
      },
          {
      key:  "appid",
      type:  "text",
      title:  "小程序APPID",
      width:  200
    },
    {
      key:  "secret",
      type:  "text",
      title:  "小程序秘钥",
      width:  200
    },
    {
      key:  "appname",
      type:  "text",
      title:  "小程序名",
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
      key:  "appid",
      type:  "text",
      title:  "小程序APPID",
      width:  200,
      mode:  "="
    },
    {
      key:  "secret",
      type:  "text",
      title:  "小程序秘钥",
      width:  200,
      mode:  "="
    },
    {
      key:  "appname",
      type:  "text",
      title:  "小程序名",
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
      action: '/app/admin/system/sysAppid/sysAppid/add',
      columns: [
              {
        key:  "appid",
        type:  "text",
        title:  "小程序APPID"
      },
      {
        key:  "secret",
        type:  "text",
        title:  "小程序秘钥"
      },
      {
        key:  "appname",
        type:  "text",
        title:  "小程序名"
      }
      ],
      rules: {
        appid: [
          { required: true, message: "请输入小程序APPID", trigger: "blur" }
        ],
        secret: [
          { required: true, message: "请输入小程序秘钥", trigger: "blur" }
        ],
        appname: [
          { required: true, message: "请输入小程序名", trigger: "blur" }
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
    formRefs.value?.clearValidate?.()
  }
  const addBtn = () => {
    resetForm()
    form.value.props.action = '/app/admin/system/sysAppid/sysAppid/add';
    form.value.props.formType = 'add';
    form.value.props.title = '添加'
    form.value.props.show = true
  }
  const updateBtn = (index: number, row: any) => {
    resetForm()
    form.value.props.action = '/app/admin/system/sysAppid/sysAppid/update';
    form.value.props.formType = 'edit';
    form.value.props.title = '编辑'
    form.value.props.show = true
    form.value.data = row;
    console.log("调用编辑", index, row)
  }
  const deleteBtn = (row: any, btnsDeleteRequest: DeleteRequest) => {
    btnsDeleteRequest({
      action: '/app/admin/system/sysAppid/sysAppid/delete',
      data: {
        _id: row._id
      }
    })
  }
  </script>
  
  <style lang="vue" scoped>
  
  </style>
