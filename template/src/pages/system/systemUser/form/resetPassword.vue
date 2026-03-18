<template>
  <el-dialog
      v-model="visible"
      :title="title"
      width="800"
      :before-close="handleBeforeClose"
      @open="getAllMenu"
      @close="handleClose"
  >
    <div class="dialog-content">
      <!-- 你的弹窗内容 -->
      <qa-form
          v-model="form.props.data"
          :columns="form.props.columns"
          :action="form.props.action"
          @success="onFormSuccess"
          @closeForm="visible = false"
          :cancel-text="page.cancelText"
          :submit-text="page.submitText"
      >
        <template v-slot:user_id>
          <div style="display: flex; align-items: center">
            <el-avatar
                v-if="selectItem.avatar"
                :src="selectItem.avatar"
                fit="cover"
            ></el-avatar>
            <text style="margin-left: 10px"
            >{{ selectItem.nickname }}（ID：{{ selectItem._id }}）</text
            >
          </div>
        </template>
      </qa-form>
    </div>
  </el-dialog>
</template>

<script setup lang="ts">
import qaForm from '@/components/quickAdmin/qaForm.vue';
import { useVModel } from '@vueuse/core';

type selectItem = {
  _id: string;
  nickname: string;
  avatar?: string;
  menu?: string[];
  role?: string[];
};

interface Props {
  show?: boolean;
  selectItem: selectItem;
  refresh?: () => void;
  /** 由 renderComponent 注入，弹窗关闭后调用以卸载实例 */
  onClosed?: () => void;
}

const props = withDefaults(defineProps<Props>(), {
  show: false,
  refresh: () => {},
});

const emit = defineEmits<{
  'update:show': [boolean];
  'update:selectItem': [selectItem | undefined];
  close: [];
  confirm: [];
  cancel: [];
}>();

const page = ref({
  cancelText: '关闭',
  submitText: '绑定',
})

const onFormSuccess = () => {
  visible.value = false
  props.refresh()
}

// el-dialog 真正用的值
const visible = useVModel(props, 'show', emit);

const title = ref('角色绑定');

// 通过 useVModel 直接拿到响应式 formData（相当于 computed + emit）
const selectItem = useVModel(props, 'selectItem', emit);

const initData = () => {
  console.log('selectItem', selectItem);
  form.value.props.data.user_id = selectItem.value._id;
  form.value.props.data.roleList = selectItem.value.role ?? [];
};

// 当外部 selectItem 变化时，同步到本地副本并刷新勾选
const localSelectItem = ref<selectItem | undefined>(undefined);
watch(selectItem, (val) => {
  localSelectItem.value = val != null ? { ...val } : undefined;
  initData();
});

const form = ref({
  props: {
    action: '/app/admin/system/systemUser/systemUser/resetPassword',
    data: {
      user_id: '' as string,
      roleList: [] as string[],
    },
    columns: [
      { key:"user_id", title:"用户", type:"text" },
      { key:"password", title:"新密码", type:"password", showPassword:true },
    ],
  },
});

// 获取全部菜单
onMounted(() => {
  getAllMenu();
});

const handleClose = () => {
  emit('close');
  props.onClosed?.();
};

const handleBeforeClose = (done: () => void) => {
  // 可以在这里添加关闭前的验证逻辑
  done();
};

// 渲染的树形数据
const treeData = ref();
const getAllMenu = async () => {
  console.log('我有没有执行');
  // const {
  //   data: { data },
  // } = await http.request({
  //   method: 'POST',
  //   url: '/app/admin/system/systemRole/systemRole/getAllMenu',
  // });


  initData();
};

// 暴露方法给父组件
defineExpose({
  open: () => (visible.value = true),
  close: () => (visible.value = false),
});
</script>

<style scoped>
.dialog-content {
  padding: 20px;
}
</style>