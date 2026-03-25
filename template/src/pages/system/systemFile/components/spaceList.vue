<template>
  <div class="flex flex-col h-full">
    <div class="flex my-[8px]">
      <el-button type="success" :icon="CirclePlus" @click="addBtn">添加</el-button>
      <el-button type="primary" :icon="Download" @click="syncSpac" :loading="syncSpacLoading">同步存储空间</el-button>
      <el-button :icon="Setting" @click="storageConfigForm.props.show = true" class="!ml-auto">配置存储提供商</el-button>
    </div>
    <qa-table size="small" ref="qaTableRef" :action="table.action" :columns="table.columns"
              :query-form-param="queryForm"
              :pagination="false" :right-btns="['delete', 'update']"
              :custom-right-btns="table.customRightBtns"
              @selection-change="selectionChange" @update="updateBtn"
              @delete="deleteBtn"/>
    <el-dialog width="500" v-model="form.props.show" :title="form.props.title" :close-on-click-modal="false">
      <qa-form v-model="form.data" ref="formRefs" :rules="form.props.rules" :action="form.props.action"
               :form-type="form.props.formType" :columns='form.props.columns' label-width="80px"
               :before-action="form.props.beforeAction" @success="()=>{
            form.props.show = false
            refresh()
          }" @closeForm="form.props.show = false">
        <template v-slot:user_id="{ form, keyName }">
          <div style="height: 36px;display: flex;align-items: center;">
            <br/>
            <el-input v-model="form[keyName]" placeholder="插槽输入框"/>
          </div>
        </template>
      </qa-form>
      <div class="mt-3 flex flex-wrap gap-2">
        <el-button size="small" @click="testSubmitForm">测试提交</el-button>
        <el-button size="small" @click="testResetForm">测试重置</el-button>
        <el-button size="small" @click="testClearValidate">测试清除校验</el-button>
        <el-button size="small" @click="testValidate">测试整体验证</el-button>
        <el-button size="small" @click="testValidateField">测试字段校验</el-button>
        <el-button size="small" @click="testSetResetFormData">测试设置重置源</el-button>
      </div>
    </el-dialog>
    <el-dialog width="500" v-model="storageConfigForm.props.show" :title="storageConfigForm.props.title"
               :close-on-click-modal="false">
      <qa-form v-model="storageConfigForm.data" ref="storageConfigFormRefs" :rules="storageConfigForm.props.rules"
               :action="storageConfigForm.props.action"
               :form-type="storageConfigForm.props.formType" :columns='storageConfigForm.props.columns'
               label-width="80px"
              @success="()=>{
            storageConfigForm.props.show = false
            refresh()
          }" @closeForm="storageConfigForm.props.show = false">
      </qa-form>
    </el-dialog>

    <el-dialog
        v-model="cnameInfoVisible"
        title="CNAME详情"
        width="600"
    >
        <div class="p-[12px] flex flex-col gap-[12px]">
          <p>
            <div class="w-[80px] inline-block text-right">主机记录：</div>
            <span>  {{  cnameInfo.domain }} </span>
          </p>
          <p>
            <div class="w-[80px] inline-block text-right">记录类型：</div>
            <span>CNAME</span>
          </p>
          <p>
            <div class="w-[80px] inline-block text-right">记录值：</div>
            <span>{{cnameInfo.domain.split('https://')[1] }}</span>
            <span
                @click="()=>{
                  copy( cnameInfo.domain.split('https://')[1])
                  ElMessage.success('复制成功')
                }"
                class="py-[3px] px-[5px] border border-gray-300 rounded-[4px] cursor-pointer ml-[12px] hover:border-[#409eff] hover:text-[#409eff]">复制</span>
          </p>
        </div>

    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import type {Columns, RightBtnMoreItem, DeleteRequest, CustomRightBtn} from '@/components/quickAdmin/qaTable.vue'
import qaTable from '@/components/quickAdmin/qaTable.vue';
import qaForm from '@/components/quickAdmin/qaForm.vue';
import {CirclePlus, Setting, Download} from '@element-plus/icons-vue'
import {getStorageConfig, syncStorageSpace} from '@/api/file'
import http from "@/utils/axios.ts";
import {ElMessage} from "element-plus";
import { cloneDeep } from '@/utils'
import { useClipboard } from '@vueuse/core'
const { copy, copied, isSupported, text } = useClipboard()


const props = defineProps<{
  provider: string
}>()

const adopt = (status: number) => {
  formRefs.value.submitForm({
    // data为额外提交的参数，真正提交的参数为form1.data+这里的data
    data: {
      status: status
    },
    success: (_data: any) => {
      // 提交成功

    },
    fail: (_data: any) => {
      // 提交失败

    }
  });
}

const formRefs = ref()

const cnameInfoVisible = ref(false)
const cnameInfo = ref({})

const storageConfigFormRefs = ref()
const qaTableRef = ref<InstanceType<typeof qaTable> | null>(null);
const table = ref<{
  action: string,
  columns: Columns[]
  rightBtnsMore: RightBtnMoreItem[]
  customRightBtns: CustomRightBtn[]
}>({
  customRightBtns: [
    {
      title: 'CNAME配置',
      disabled: (item) => {
        return item._id == '002'
      },
      show: (item) => {
        return ['aliyun','tencent'].includes(item.provider)
      },
      onClick: (row) => {
        cnameInfoVisible.value = true
        cnameInfo.value = row

      }
    },
  ],
  action: '/app/admin/system/systemFile/systemFile/space/getList',
  columns: [
    {
      key: "name",
      type: 'text',
      title: "存储空间名称",
    },
    {
      key: "region",
      type: 'text',
      title: "区域",
    },
    {
      key: "domain",
      type: 'text',
      title: "空间域名",
      width: 500
    },
    {
      key: "enable",
      type: 'switch',
      title: "是否启用",
      watch: (res) => {
        let { value, row, change } = res;
        http.request({
          method: 'POST',
          url: "/app/admin/system/systemFile/systemFile/space/updateBase",
          data: {
            _id: row._id,
            enable: value,
            provider: row.provider
          }
        }).then((_res) => {
          change(value)
          refresh()
        })
      }
    },
    {
      key: "_add_time_str",
      title: "创建时间",
      type: 'text',
    },
    {
      key: "_update_time_str",
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
    provider: props.provider,
  },
  columns: [{
    key: "provider",
    title: "空间名称",
    mode: "="
  }]
})

// 多选逻辑
const multipleSelection = ref([])
const selectionChange = (row: any) => {
  console.log(row)
  multipleSelection.value = row
}

// 表单默认数据
const originalFormData = {
  acl: 'public-read'
}

const form = ref({
  data: cloneDeep(originalFormData),
  props: {
    // 请求预处理
    beforeAction: (_formData: any) => {
      _formData.provider = props.provider
      return true
    },
    action: '/app/admin/system/systemFile/systemFile/space/add',
    columns: [
      {
        "key": "name",
        "title": "空间名称",
        "type": "text",
        width: 250,
        showLabel: true,
        show: ['add'],
        watch: (res: any) => {
          console.log("watch", res)
        }
      },
      {
        "key": "region",
        "title": "空间区域",
        "type": "remote-select",
        action: "/app/admin/system/systemFile/systemfile/region/getList",
        width: 250,
        props: {list: "", value: "value", label: "label", desc: "desc"},
        actionData: {
          pageSize: 1000,
          provider: props.provider
        },
        show: ['add'],
        watch: (res: any) => {
          console.log("watch", res)
        }
      },
      {
        "key": "acl",
        "title": "读写权限",
        "type": "radio",
        data: [
          {value: "public-read", label: "公共读(推荐)"},
          {value: "public-read-write", label: "公共读写"},
        ],
        width: 250,
        showLabel: true,
        show: ['add'],
      },
      {
        "key": "domain",
        "title": "空间域名",
        "type": "text",
        width: 350,
        show: ['edit']
      },
      {
        "key": "cdn",
        "title": "cdn域名",
        "type": "text",
        width: 350,
        show: ['edit'],
      },

    ],
    rules: {
      name: [
        {min: 3, max: 5, message: '长度3-5', trigger: 'blur', required: true,},
      ],
    },
    formType: "",
    title: "",
    show: false
  }
})

const currentStorageConfig = ref()
const getCurrentStorageConfig = async () => {
  const res = await getStorageConfig({
    provider: props.provider
  })

  storageConfigForm.value.data = {
    ...storageConfigForm.value.data,
    ...res.data.data
  }
}

onMounted(() => {
  getCurrentStorageConfig()
})

const storageConfigForm = ref({
  data: {
    provider:props.provider,
  },
  props: {
    action: '/app/admin/system/systemFile/systemFile/storageConfig/update',
    columns: [
      {
        "key": "accessKey",
        "title": "accessKey",
        "type": "text",
        labelWidth:100,
        showLabel: true,
        show: ['add', 'edit'],
      },

      {
        "key": "secretKey",
        "title": "secretKey",
        "type": "text",
        labelWidth:100,
        showLabel: true,
        show: ['add', 'edit'],
      },

      {
        "key": "appId",
        "title": "APPID",
        "type": "text",
        labelWidth:100,
        showLabel: true,
        show: ['add', 'edit'],
        showRule: (row: any) => {
          return row.provider == 'tencent'
        }
      }
    ],
    rules: {
      accessKey: [
        {trigger: 'blur', required: true, message: '请输入accessKey',},
      ],
      secretKey: [
        {trigger: 'blur', required: true, message: '请输入secretKey',},
      ],
      appId: [
        {trigger: 'blur', required: props.provider == 'tencent', message: '请输入APPID',},
      ]
    },
    formType: "edit",
    title: "编辑",
    show: false
  }
})
// 表格数据刷新
const refresh = () => {
  qaTableRef.value?.refresh()
}

const testSetResetFormData = () => {
  formRefs.value?.setResetFormData?.({
    name: '1111',
    acl: 'public-read',
    region: 'ap-guangzhou',
    domain: 'https://test.example.com',
  })
  ElMessage.success('已设置 resetForm 的测试数据源')
}

const testResetForm = () => {
  formRefs.value?.resetForm?.()
}

const testClearValidate = () => {
  formRefs.value?.clearValidate?.()
  ElMessage.success('已清除表单校验')
}

const testValidate = () => {
  formRefs.value?.validate?.((valid: boolean) => {
    if (valid) {
      ElMessage.success('表单验证通过')
      return
    }
    ElMessage.error('表单验证未通过')
  })
}

const testValidateField = () => {
  formRefs.value?.validateField?.('name', (errMsg: string) => {
    if (errMsg) {
      ElMessage.error(`name 字段未通过校验: ${errMsg}`)
      return
    }
    ElMessage.success('name 字段校验通过')
  })
}

const testSubmitForm = () => {
  formRefs.value?.submitForm?.()
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
  form.value.props.action = '/app/admin/system/systemFile/systemFile/space/update';
  form.value.data = row;
  form.value.props.formType = 'edit';
  form.value.props.title = '编辑'
  form.value.props.show = true
  console.log("调用编辑", index, row)
}
const deleteBtn = (row: any, btnsDeleteRequest: DeleteRequest) => {
  btnsDeleteRequest({
    action: '/app/admin/system/systemFile/systemFile/space/delete',
    data: {
      _id: row._id
    }
  })
}

const syncSpacLoading = ref(false)
const syncSpac = async () => {
  syncSpacLoading.value = true
  try{
   await syncStorageSpace({
     provider: props.provider
   })
    refresh()
    ElMessage.success('同步成功')
 }finally {
    syncSpacLoading.value = false
  }
}
</script>

<style lang="vue" scoped>

</style>