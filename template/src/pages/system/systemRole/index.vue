<template>
  <div class="flex flex-col h-full">
    <qa-table-query :columns="queryForm.columns" v-model="queryForm.formData" @search="search" />

    <div>
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
      <el-button type="primary" :icon="Tools" :disabled="!selectItem" @click="bindPermissionBtn">权限赋予</el-button>
      <el-button type="danger" :icon="Tools" :disabled="!selectItem" @click="bindMenuBtn">菜单赋予</el-button>
    </div>

    <qa-table ref="qaTableRef" :action="table.action" :columns="table.columns" :query-form-param="queryForm"
      :pagination="false" :right-btns="['detail_auto', 'delete', 'update', 'more']"
      :right-btns-more="table.rightBtnsMore" @update="updateBtn" highlight-current-row row-no
        @selection-change="($event)=>{
          console.log('选中值',$event)
        }"
      @current-change="currentChange" @delete="deleteBtn" />


    <qa-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
      <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"
        :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
        :before-action="form.props.beforeAction" @success="()=>{
          form.props.show = false
          refresh()
        }"
        @closeForm="form.props.show = false">
      </qa-form>
    </qa-dialog>
  </div>
</template>

<script setup lang="ts">
import type qaTable from '@/components/quickAdmin/table/qaTable.vue'
import type { Columns, RightBtnMoreItem, DeleteRequest } from '@/components/quickAdmin/table/qaTable.vue'
import bindMenu from './form/bindMenu.vue';
import bindPermission from './form/bindPermission.vue';
import { CirclePlus, Tools } from '@element-plus/icons-vue'
import { cloneDeep, renderComponent } from '@/utils'
import http from '@/utils/axios'


const currentChange = (row: any) => {
  selectItem.value = row
}

const selectItem = ref()
const qaTableRef = ref<InstanceType<typeof qaTable> | null>(null);
const table = ref<{
  action: string,
  columns: Columns[]
  rightBtnsMore: RightBtnMoreItem[]
}>({
  action: '/app/admin/system/systemRole/systemRole/getList',
  columns: [
    // {
    //   key: "_id",
    //   type: 'text',
    //   title: "ID(唯一ID)",
    //   width: 240
    // },
    {
      key: "role_id",
      type: 'text',
      title: "角色标识",
    },
    {
      key: "role_name",
      type: 'text',
      title: "角色名称",
      width: 240
    },
    {
      key: "comment",
      type: 'text',
      title: "备注",
      width: 240
    },
    {
      key: "permissionsList",
      title: "拥有权限",
      type: "text",
      formatter: (val: any, row: any, _column: any, _index: number) => {
        let str = "";
        if (row.role_id === "admin") {
          str = "系统内置角色 - 拥有所有权限";
        } else if (val === null || val === undefined || val.length <= 0) {
          str = "该角色未赋予任何权限";
        } else {
          val.map((item: any, index: number) => {
            str += item.permission_name;
            if (index !== val.length - 1) {
              str += "、";
            }
          });
        }
        return str;
      },
      align: "left",
      width: 240,
    },
    {
      key: "menuList",
      type: 'text',
      title: "拥有菜单",
      width: 240,
      formatter: (val, row, _column, _index) => {
        let str = "";
        if (row.role_id === "admin") {
          str = "系统内置角色 - 拥有所有菜单";
        } else if (val === null || val === undefined || val.length <= 0) {
          str = "该角色未赋予任何菜单";
        } else {
          val.map((item: any, index: number) => {
            str += item.title;
            if (index !== val.length - 1) {
              str += "、";
            }
          });
        }
        return str;
      },
    },
    {
      key: "enable",
      type: 'switch',
      title: "是否启用",
      watch: (res) => {
        let { value, row, change } = res;
        http.request({
          method: 'POST',
          url: "/app/admin/system/systemRole/systemRole/updateBase",
          data: {
            _id: row._id,
            enable: value
          }
        }).then((_res) => {
          change(value)
        })
      }
    },
    {
      key: "_add_time_str",
      title: "时间",
      type: 'text',
      width: 240,
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
  columns: [{
    key: "role_id",
    type: "text",
    title: "角色标识",
    width: 230,
    "mode": "=",
  },
  {
    key: "role_name",
    type: "text",
    title: "角色名称",
    mode: "=",
    width: 230,
  },
  {
    key: "_add_time",
    type: "datetimerange",
    title: "添加时间",
    "mode": "[]",
    width: 230,
  }]
})

const originalFormData = {
  enable: true,
}

const form = ref({
  data: cloneDeep(originalFormData),
  props: {
    // 请求预处理
    beforeAction: (_formData: any) => {
      return true
    },
    action: '/app/admin/system/systemRole/systemRole/add',
    columns: [
      {
        "key": "role_id",
        "title": "角色标识",
        "type": "text",
        show: ['add'],
      },
      {
        "key": "role_name",
        "title": "角色名称",
        "type": "text",
      },
      {
        "key": "comment",
        "title": "备注",
        "type": "textarea",
      },
      {
        "key": "enable",
        "title": "是否启用",
        "type": "switch",
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

// 表单组件ref
const formRefs = ref()
// 表格数据刷新
const refresh = () => {
  qaTableRef.value?.refresh()
}
// 表单数据重置
const resetForm = async () => {
  form.value.data = cloneDeep(originalFormData)
  formRefs.value?.clearValidate?.()
}
// 表单提交
const submitForm = () => {
  formRefs.value?.submitForm?.() // 安全调用
}
// 表单关闭
const closeForm = () => {
  form.value.props.show = false
}
const addBtn = () => {
  resetForm()
  form.value.props.formType = 'add';
  form.value.props.title = '添加'
  form.value.props.show = true
}
const updateBtn = (index: number, row: any) => {
  resetForm()
  form.value.props.action = '/app/admin/system/systemRole/systemRole/update';
  form.value.props.formType = 'edit';
  form.value.props.title = '编辑'
  form.value.data = row;
  form.value.props.show = true
  console.log("调用编辑", index, row)
}
const deleteBtn = (row: any, btnsDeleteRequest: DeleteRequest) => {
  btnsDeleteRequest({
    action: '/app/admin/system/systemRole/systemRole/delete',
    data: {
      _id: row._id
    }
  })
}

const bindPermissionBtn = () => {
  console.log('selectItem',selectItem)
  renderComponent(bindPermission, {
    selectItem: selectItem.value,
    refresh
  })
}

const bindMenuBtn = () => {
  renderComponent(bindMenu, {
    selectItem: selectItem.value,
    refresh
  })
  // const row = qaTableRef?.value?.getCurrentRow(true)
}

</script>

<style lang="vue" scoped>

</style>