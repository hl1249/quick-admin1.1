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
    action: '/app/admin/system/systemPayConfig/systemPayConfig/getList',
    columns: [
      {
        key: "_id",
        type: 'text',
        title: "记录ID(唯一ID)",
        width: 240
      },
          {
      key:  "type",
      type:  "text",
      title:  "支付类型",
      width:  200
    },
    {
      key:  "mchId",
      type:  "text",
      title:  "商户ID",
      width:  200
    },
    {
      key:  "key",
      type:  "text",
      title:  "v2证书key",
      width:  200
    },
    {
      key:  "pfx",
      type:  "text",
      title:  "p12转base64",
      width:  200
    },
    {
      key:  "version",
      type:  "text",
      title:  "密钥版本",
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
      key:  "type",
      type:  "text",
      title:  "支付类型",
      width:  200,
      mode:  "="
    },
    {
      key:  "mchId",
      type:  "text",
      title:  "商户ID",
      width:  200,
      mode:  "="
    },
    {
      key:  "key",
      type:  "text",
      title:  "v2证书key",
      width:  200,
      mode:  "="
    },
    {
      key:  "pfx",
      type:  "text",
      title:  "p12转base64",
      width:  200,
      mode:  "="
    },
    {
      key:  "version",
      type:  "text",
      title:  "密钥版本",
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
      action: '/app/admin/system/systemPayConfig/systemPayConfig/add',
      columns: [
              {
        key:  "type",
        type:  "select",
        title:  "支付类型",
        data:  [
          {
            value:  "wx-mini",
            label:  "微信小程序支付"
          },
          {
            value:  "wx-h5",
            label:  "微信H5支付"
          }
        ],
        placeholder:  "支付类型"
      },
      {
        key:  "mchId",
        type:  "text",
        title:  "商户ID"
      },
      {
        key:  "key",
        type:  "text",
        title:  "v2证书key"
      },
      {
        key:  "pfx",
        type:  "text",
        title:  "p12转base64"
      },
      {
        key:  "version",
        type:  "text",
        title:  "密钥版本"
      }
      ],
      rules: {
        type: [
          { required: true, message: "请输入支付类型", trigger: "blur" }
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
    form.value.props.action = '/app/admin/system/systemPayConfig/systemPayConfig/add';
    form.value.props.formType = 'add';
    form.value.props.title = '添加'
    form.value.props.show = true
  }
  const updateBtn = (index: number, row: any) => {
    resetForm()
    form.value.props.action = '/app/admin/system/systemPayConfig/systemPayConfig/update';
    form.value.props.formType = 'edit';
    form.value.props.title = '编辑'
    form.value.props.show = true
    form.value.data = row;
    console.log("调用编辑", index, row)
  }
  const deleteBtn = (row: any, btnsDeleteRequest: DeleteRequest) => {
    btnsDeleteRequest({
      action: '/app/admin/system/systemPayConfig/systemPayConfig/delete',
      data: {
        _id: row._id
      }
    })
  }
  </script>
  
  <style lang="vue" scoped>
  
  </style>
