<template>
  <div
    v-loading="loading"
    class="flex flex-col flex-auto overflow-hidden pb-[2px]"
  >
    <div class="flex-auto overflow-hidden">
      <el-table
        :data="tableData"
        style="width: 100%"
        @current-change="onCurrentChange"
        @row-click="onRowClick"
        @row-dblclick="onRowDblclick"
        @row-contextmenu="onRowContextmenu"
        @cell-click="onCellClick"
        @cell-dblclick="onCellDblclick"
        @cell-mouse-enter="onCellMouseEnter"
        @cell-mouse-leave="onCellMouseLeave"
        @header-click="onHeaderClick"
        @header-contextmenu="onHeaderContextmenu"
        @header-dragend="onHeaderDragend"
        @selection-change="onSelectionChange"
        @select="onSelect"
        @select-all="onSelectAll"
        @sort-change="columnSort"
        v-bind="{ ...tableProps }"
      >
        <el-table-column
          v-if="selection && multiple"
          type="selection"
          :selectable="selectable"
          width="55"
        />

        <el-table-column
          v-if="selection && !multiple"
          label="选择"
          width="55"
          align="center"
        >
          <template #default="{ row }">
            <el-radio
              v-model="singleSelectionId"
              :value="row[rowKey]"
            />
          </template>
        </el-table-column>

        <el-table-column
          type="index"
          label="序号"
          :index="computeIndex"
          width="60"
          v-if="rowNo"
        ></el-table-column>

        <!-- eslint-disable-next-line vue/no-v-for-template-key -- Vue 3 单根时 key 放 template 上 -->
        <!-- eslint-disable-next-line vue/no-v-for-template-key -->
        <template v-for="item in columns" :key="item.key">
          <qa-table-column
            v-bind="{ ...item, prop: item.key, label: item.title }"
            @changeValue="changeValue"
          />
        </template>

        <el-table-column
          align="center"
          :width="flexColumnWidth()"
          v-if="rightBtns"
          fixed="right"
        >
          <template #header> 操作 </template>
          <template #default="scope">
            <el-button
              :icon="Document"
              v-if="rightBtns.includes('detail_auto')"
              @click="btnsDetail(scope.$index, scope.row)"
            >
              详情
            </el-button>
            <el-button
              type="primary"
              :icon="Edit"
              v-if="rightBtns.includes('update')"
              @click="btnsUpdate(scope.$index, scope.row)"
            >
              编辑
            </el-button>

            <el-popconfirm
              title="确定删除吗？"
              v-if="rightBtns.includes('delete')"
              @confirm="confirmDelete(scope.row, btnsDeleteRequset)"
            >
              <template #reference>
                <el-button type="danger" :icon="Delete"> 删除 </el-button>
              </template>
            </el-popconfirm>

            <el-dropdown
              trigger="click"
              v-if="rightBtns.includes('more')"
              class="ml-[12px]"
            >
              <el-button type="success" :icon="ArrowDown"> 更多 </el-button>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item
                    v-for="item in rightBtnsMore"
                    :key="item.title"
                    @click="item.onClick(scope.row)"
                    :disabled="
                      checkRightBtnsMoreDisabled(item.disabled, scope.row)
                    "
                  >
                    {{ item.title }}
                  </el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div
      class="qa-pagination flex items-center justify-center pt-[12px] flex-unset"
    >
      <el-pagination
        :current-page="currentPage"
        :page-size="pageSize"
        @update:current-page="currentPage = $event"
        @update:page-size="pageSize = $event"
        :page-sizes="[1, 5, 10, 20, 50, 100, 500]"
        :size="size"
        :disabled="disabled"
        :background="background"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>

    <el-dialog
      v-model="infoDialogVisible"
      title="详情"
      width="830"
      :before-close="infoHandleClose"
    >
      <el-table :data="detailData" border :show-header="false" max-height="800">
        <el-table-column width="200" prop="title" />
        <el-table-column>
          <template #default="scope">
            <!-- scope:{{ scope.row }} -->
            <!-- {{ scope.$index }}: -->
            <!-- {{ scope.row }} -->
            <!-- {{ columns }} -->
            <qa-detail v-bind="{ scope, columns }" />
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script lang="ts" setup>
import qaDetail from './qaDetail.vue';
import { Delete, Edit, ArrowDown, Document } from '@element-plus/icons-vue';
import http from '@/utils/axios';
import { ElMessage } from 'element-plus';
import qaTableColumn from './qaTableColumn.vue';
import { cloneDeep } from '@/utils';

type RightBtn = 'detail_auto' | 'update' | 'delete' | 'more';
type Type =
  | 'radio'
  | 'select'
  | 'checkbox'
  | 'json'
  | 'text'
  | 'image'
  | 'avatar'
  | 'rate'
  | 'switch'
  | 'icon'
  | 'tag'
  | 'time'
  | 'object'
  | 'html'
  | 'money'
  | 'percentage'
  | 'address'
  | 'userInfo'
  | 'group'
  | 'table';
type Show = 'detail' | 'row' | 'expand' | 'none';
type TableRow = {
  _id: number;
  [key: string]: any; // 表示除了 _id 外，其他字段可以是任意 key，值类型为 any
};
export interface Data {
  value: number | string;
  label?: string;
  tagType?: 'success' | 'danger' | 'primary' | 'info' | 'warning';
  icon?: string;
}
export interface Columns {
  key?: string;
  title: string;
  type: Type;
  show?: Show[];
  width?: string | number;
  minWidth?: string | number;
  columns?: Columns[];
  data?: Data[];
  defaultValue?: string | number;
  formatter?: (
    value: any,
    row: any,
    column: any,
    index: number,
  ) => string | number;
  imageWidth?: string | number;
  activeValue?: boolean | string | number;
  inactiveValue?: boolean | string | number;
  size?: '' | 'large' | 'default' | 'small';
  sortable?: boolean | string;
  shape?: 'circle' | 'square';
  align?: 'left' | 'center' | 'right';
  valueFormat?: string;
  rowHeight?: string | number;
  watch?: (value: any) => void;
}
export interface DeleteRequset {
  (params: { action: string; data: any }): void;
}
export interface RightBtnMoreItem {
  title: string;
  disabled?: ((item: any) => boolean) | boolean;
  onClick: (item: any) => void;
}

/** 表格详情弹窗中每一行的数据：列配置 + 行数据 + 当前单元格 value */
export type DetailDataItem = Columns & TableRow & { value?: unknown };

/** Element Plus 表格排序变化回调参数 */
export interface TableSortChangeData {
  prop: string;
  order: 'ascending' | 'descending' | null;
  column: unknown;
}

const tableProps = computed(
  (): {
    rowNo?: boolean;
    rowKey?: string;
    selection?: boolean;
    multiple?: boolean;
    height?: string | number;
    border?: boolean;
    highlightCurrentRow?: boolean;
    size?: '' | 'large' | 'default' | 'small';
    selectable?: (row: TableRow, index: number) => boolean;
    stripe?: boolean;
  } => {
    const {
      rowNo,
      rowKey,
      selection,
      height,
      border,
      highlightCurrentRow,
      size,
      selectable,
      stripe,
    } = props;
    return {
      rowNo,
      rowKey,
      selection,
      height,
      border,
      highlightCurrentRow,
      size,
      selectable,
      stripe,
    };
  },
);

const props = withDefaults(
  defineProps<{
    action: string;
    columns: Columns[];
    queryFormParam?: Record<string, any>;
    rightBtns?: RightBtn[];
    rightBtnsMore?: RightBtnMoreItem[];
    rowNo?: boolean;
    rowKey?: string;
    selection?: boolean;
    multiple?: boolean;
    renderNode?: 'detail' | 'row'; // 渲染位置
    height?: string | number;
    border?: boolean;
    highlightCurrentRow?: boolean;
    size?: '' | 'large' | 'default' | 'small';
    selectable?: (row: TableRow, index: number) => boolean;
    stripe?: boolean;
  }>(),
  {
    renderNode: 'row', // 默认值
    rowNo: false, // 其他可选默认值
    rowKey: '_id',
    selection: false,
    height: '100%',
  },
);

const emits = defineEmits<{
  delete: [row: TableRow, deleteRequset: DeleteRequset];
  update: [index: number, row: TableRow];
  'current-change': [row: TableRow | null];
  'row-click': [row: TableRow, column: unknown, event: MouseEvent];
  'row-dblclick': [row: TableRow, column: unknown, event: MouseEvent];
  'row-contextmenu': [row: TableRow, column: unknown, event: MouseEvent];
  'cell-mouse-enter': [
    row: TableRow,
    column: unknown,
    cell: unknown,
    event: MouseEvent,
  ];
  'cell-mouse-leave': [
    row: TableRow,
    column: unknown,
    cell: unknown,
    event: MouseEvent,
  ];
  'cell-click': [
    row: TableRow,
    column: unknown,
    cell: unknown,
    event: MouseEvent,
  ];
  'cell-dblclick': [
    row: TableRow,
    column: unknown,
    cell: unknown,
    event: MouseEvent,
  ];
  'header-click': [column: unknown, event: MouseEvent];
  'header-contextmenu': [column: unknown, event: MouseEvent];
  'header-dragend': [
    newWidth: number,
    oldWidth: number,
    column: unknown,
    event: MouseEvent,
  ];
  select: [selection: TableRow[], row: TableRow];
  'select-all': [selection: TableRow[]];
  'selection-change': [selection: TableRow[]];
  'pagination-change': [page: number, pageSize: number];
}>();

const onCurrentChange = (row: TableRow | null) => {
  emits('current-change', row);
  setCurrentRow(row);
};
const onRowClick = (row: TableRow, column: unknown, event: MouseEvent) =>
  emits('row-click', row, column, event);
const onRowDblclick = (row: TableRow, column: unknown, event: MouseEvent) =>
  emits('row-dblclick', row, column, event);
const onRowContextmenu = (row: TableRow, column: unknown, event: MouseEvent) =>
  emits('row-contextmenu', row, column, event);
const onCellClick = (
  row: TableRow,
  column: unknown,
  cell: unknown,
  event: MouseEvent,
) => emits('cell-click', row, column, cell, event);
const onCellDblclick = (
  row: TableRow,
  column: unknown,
  cell: unknown,
  event: MouseEvent,
) => emits('cell-dblclick', row, column, cell, event);
const onCellMouseEnter = (
  row: TableRow,
  column: unknown,
  cell: unknown,
  event: MouseEvent,
) => emits('cell-mouse-enter', row, column, cell, event);
const onCellMouseLeave = (
  row: TableRow,
  column: unknown,
  cell: unknown,
  event: MouseEvent,
) => emits('cell-mouse-leave', row, column, cell, event);
const onHeaderClick = (column: unknown, event: MouseEvent) =>
  emits('header-click', column, event);
const onHeaderContextmenu = (column: unknown, event: MouseEvent) =>
  emits('header-contextmenu', column, event);
const onHeaderDragend = (
  newWidth: number,
  oldWidth: number,
  column: unknown,
  event: MouseEvent,
) => emits('header-dragend', newWidth, oldWidth, column, event);
const onSelectionChange = (selection: TableRow[]) =>
  emits('selection-change', selection);
const onSelect = (selection: TableRow[], row: TableRow) =>
  emits('select', selection, row);
const onSelectAll = (selection: TableRow[]) => emits('select-all', selection);

const changeValue = (row: TableRow, key: string, value: string): void => {
  ElMessage.success('更新成功！');
  // 直接修改引用
  row[key] = value;

  // 下方要找再到 如果是树形不确定children parent_id 别名不好查找
  // const index = tableData.value.findIndex(item => item._id === row._id);
  // if (index !== -1) {
  //     tableData.value[index][key] = value;
  // }
};

interface SortItem {
  name: string;
  type: 'asc' | 'desc';
}

const sortRule = ref<SortItem[]>([]);
const columnSort = (data: TableSortChangeData): void => {
  sortRule.value = sortRule.value.filter((item) => item.name != data.prop);

  if (data.order) {
    sortRule.value.push({
      name: data.prop,
      type: data.order === 'ascending' ? 'asc' : 'desc',
    });
  }

  getTableData();
};

const loading = ref<boolean>(false);
const tableData = ref<TableRow[]>([]);

/** 单选模式下的选中项（rowKey 对应的值），与多选 selection-change 语义一致 */
const singleSelectionId = ref<string | number | undefined>(undefined);
const rowKey = computed(() => props.rowKey ?? '_id');

watch(singleSelectionId, (id) => {
  if (id === undefined) {
    emits('selection-change', []);
    return;
  }
  const row = tableData.value.find((r) => r[rowKey.value] === id);
  emits('selection-change', row ? [row] : []);
}, { immediate: true });

const getTableData = async (): Promise<void> => {
  loading.value = true;

  try {
    const res = await http.request({
      url: props.action,
      method: 'post',
      data: {
        ...props.queryFormParam,
        sortRule: sortRule.value,
        pageIndex: currentPage.value,
        pageSize: pageSize.value,
      },
    });

    tableData.value = res.data.data.rows;
    total.value = res.data.data.total;
    if (!props.multiple && props.selection) {
      singleSelectionId.value = undefined;
    }
  } catch (err) {
    console.log(err);
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  getTableData();
});

const btnsDetail = (index: number, row: TableRow): void => {
    // console.log('tableDatas', tableDatas)
    (detailData.value = props.columns.map((item) => {
      console.log(`key:${item.key} value:${row[item.key as string]}`);
      return {
        value: row[item.key as string],
        ...row,
        ...item,
      };
    }));
  // console.log('detailData', detailData)

  openInfoDialog();
};
const btnsUpdate = (index: number, row: TableRow): void => {
  console.log('编辑', row);
  emits('update', index, cloneDeep(row));
};

const confirmDelete = (row: TableRow, deleteRequset: DeleteRequset): void => {
  emits('delete', row, deleteRequset);
};
const btnsDeleteRequset = async ({
  action,
  data,
}: {
  action: string;
  data: any;
}): Promise<void> => {
  console.log('请求删除接口', action, data);
  try {
    await http.request({
      url: action,
      method: 'post',
      data,
    });

    ElMessage.success('删除成功');
    getTableData();
  } catch (err) {}
};

const total = ref<number>(0);
const currentPage = ref<number>(1);
const pageSize = ref<number>(10);
const disabled = ref<boolean>(false);
const background = ref<boolean>(true);
const handleSizeChange = (val: number): void => {
  console.log(`${val} items per page`);
  getTableData();
};
const handleCurrentChange = (val: number): void => {
  console.log(`current page: ${val}`);
  getTableData();
};

const computeIndex = (index: number): number => {
  return (currentPage.value - 1) * pageSize.value + index + 1;
};

// 如果布尔值 返回布尔值 如果是函数调用
const checkRightBtnsMoreDisabled = (
  disabled: ((item: any) => boolean) | boolean | undefined,
  row: TableRow,
): boolean => {
  if (typeof disabled === 'boolean') return disabled;
  if (typeof disabled === 'function') return disabled(row);
  return false;
};

const flexColumnWidth = (): number => {
  if (props.rightBtns) return 100 * props.rightBtns.length + 5;
  else return 0;
};

const detailData = ref<DetailDataItem[]>([]);
const openInfoDialog = (): void => {
  infoDialogVisible.value = true;
};
const infoDialogVisible = ref<boolean>(false);
const infoHandleClose = (): void => {
  infoDialogVisible.value = false;
};

const getCurrentRow = (isOrigin?: boolean): TableRow | undefined => {
  if (isOrigin) return currentRow.value;
  return currentRow.value != null ? cloneDeep(currentRow.value) : undefined;
};

/** 单选模式下返回当前选中的行，多选请用 selection-change 事件 */
const getSelectedRow = (): TableRow | undefined => {
  if (props.multiple || !props.selection) return undefined;
  const id = singleSelectionId.value;
  if (id === undefined) return undefined;
  return tableData.value.find((r) => r[rowKey.value] === id);
};

const currentRow = ref<TableRow | undefined>(undefined);
const setCurrentRow = (row: TableRow | null): void => {
  currentRow.value = row ?? undefined;
};

defineExpose({
  search: getTableData,
  refresh: getTableData,
  getCurrentRow,
  getSelectedRow,
});
</script>
