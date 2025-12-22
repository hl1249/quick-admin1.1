<template>
    <div v-loading="loading" class="flex flex-col flex-auto overflow-hidden pb-[2px]">
        <div class="flex-auto overflow-hidden">
            <el-table :data="tableData" style="width: 100%" 
                @current-change="(row) => {
                     emits('current-change', row)
                     setCurrentRow(row)
                }"
                @row-click="(row, column, event) => emits('row-click', row, column, event)"
                @row-dblclick="(row, column, event) => emits('row-dblclick', row, column, event)"
                @row-contextmenu="(row, column, event) => emits('row-contextmenu', row, column, event)"
                @cell-click="(row, column, cell, event) => emits('cell-click', row, column, cell, event)"
                @cell-dblclick="(row, column, cell, event) => emits('cell-dblclick', row, column, cell, event)"
                @cell-mouse-enter="(row, column, cell, event) => emits('cell-mouse-enter', row, column, cell, event)"
                @cell-mouse-leave="(row, column, cell, event) => emits('cell-mouse-leave', row, column, cell, event)"
                @header-click="(column, event) => emits('header-click', column, event)"
                @header-contextmenu="(column, event) => emits('header-contextmenu', column, event)"
                @header-dragend="(newWidth, oldWidth, column, event) => emits('header-dragend', newWidth, oldWidth, column, event)"
                @selection-change="(selection) => emits('selection-change', selection)"
                @select="(selection, row) => emits('select', selection, row)"
                @select-all="(selection) => emits('select-all', selection)"
                @sort-change="columnSort"
                 v-bind="{...tableProps}"
                >
                <el-table-column v-if="selection" type="selection" :selectable="selectable" width="55"  />
                
                 <el-table-column
                    type="index"
                    label="序号"
                    :index="computeIndex"
                    width="60"
                    v-if="rowNo"
                ></el-table-column>

                <template v-for="item in columns" :key="item.key">
                    <qa-table-column v-bind="{ ...item, prop: item.key, label: item.title }"
                      @changeValue="changeValue" />
                </template>
                <el-table-column align="center" :width="flexColumnWidth()" v-if="rightBtns" fixed="right">
                    <template #header>
                        操作
                    </template>
                    <template #default="scope">
                        <el-button :icon="Document" v-if="rightBtns.includes('detail_auto')"
                            @click="btnsDetail(scope.$index, scope.row)">
                            详情
                        </el-button>
                        <el-button type="primary" :icon="Edit" v-if="rightBtns.includes('update')"
                            @click="btnsUpdate(scope.$index, scope.row)">
                            编辑
                        </el-button>

                        <el-popconfirm title="确定删除吗？" v-if="rightBtns.includes('delete')"
                            @confirm="confirmDelete(scope.row, btnsDeleteRequset)">
                            <template #reference>
                                <el-button type="danger" :icon="Delete">
                                    删除
                                </el-button>
                            </template>
                        </el-popconfirm>

                        <el-dropdown trigger="click" v-if="rightBtns.includes('more')" class="ml-[12px]">
                            <el-button type="success" :icon="ArrowDown">
                                更多
                            </el-button>
                            <template #dropdown>
                                <el-dropdown-menu>
                                    <el-dropdown-item v-for="item in rightBtnsMore" :key="item.title"
                                        @click="item.onClick(scope.row)"
                                        :disabled="checkRightBtnsMoreDisabled(item.disabled, scope.row)">
                                        {{ item.title }}
                                    </el-dropdown-item>
                                </el-dropdown-menu>
                            </template>
                        </el-dropdown>

                    </template>
                </el-table-column>
            </el-table>
        </div>

        <div class="qa-pagination flex items-center justify-center pt-[12px] flex-unset ">
            <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize"
                :page-sizes="[1, 5, 10, 20, 50, 100, 500]" :size="size" :disabled="disabled" :background="background"
                layout="total, sizes, prev, pager, next, jumper" :total="total" @size-change="handleSizeChange"
                @current-change="handleCurrentChange" />
        </div>

        <el-dialog v-model="infoDialogVisible" title="详情" width="830" :before-close="infoHandleClose">
            <el-table :data="detailData" border :show-header="false" max-height="800">
                <el-table-column width="200" prop="title" />
                <el-table-column>
                    <template #default="scope">
                        <!-- scope:{{ scope.row }} -->
                         <!-- {{ scope.$index }}: -->
                         <!-- {{ scope.row }} -->
                         <!-- {{ columns }} -->
                        <qa-detail v-bind="{scope,columns}"/>
                    </template>
                </el-table-column>
            </el-table>
        </el-dialog>
    </div>
</template>

<script lang="ts" setup>

import qaDetail from './qaDetail.vue'
import { Delete, Edit, ArrowDown, Document } from '@element-plus/icons-vue'
import http from '@/utils/axios'
import { ElMessage } from 'element-plus'
import qaTableColumn from './qaTableColumn.vue'
import { cloneDeep } from '@/utils'

type RightBtn = 'detail_auto' | 'update' | 'delete' | 'more'
type Type = 'radio' | 'select' | 'checkbox' | 'json' | 'radio' | 'text' | 'image' | 'avatar' | 'rate' | 'switch' | 'icon' | 'tag' | 'time' | 'object' | 'html' | 'money' | 'percentage' | 'address' | 'userInfo' | 'group' | 'table'
type Show = "detail" | "row" | "expand" | "none"
type TableRow = {
    _id: number
    [key: string]: any // 表示除了 _id 外，其他字段可以是任意 key，值类型为 any
};
export interface Data {
    value: number | string
    label?: string,
    tagType?: "success" | "danger" | 'primary' | 'info' | 'warning',
    icon?: string,
}
export interface Columns {
    key?: string
    title: string
    type: Type,
    show?: Show[]
    width?: string | number,
    minWidth?: string | number,
    columns?: Columns[]
    data?: Data[]
    defaultValue?: string | number;
    formatter?: (value: any, row: any, column: any, index: number) => string | number;
    imageWidth?: string | number;
    activeValue?: boolean | string | number;
    inactiveValue?: boolean | string | number;
    size?: '' | 'large' | 'default' | 'small'
    sortable?: boolean | string,
    shape?: 'circle' | 'square',
    align?: 'left' | 'center' | 'right',
    valueFormat?: string,
    rowHeight?: string | number,
    watch?: (value: any) => void
}
export interface DeleteRequset {
    (params: { action: string; data: any }): void
}
export interface RightBtnMoreItem {
    title: string
    disabled: (item: any) => boolean  // 可选函数
    onClick: (item: any) => void      // 可选函数
}

const tableProps = computed(() => {
  const { rowNo, rowKey, selection, height, border, highlightCurrentRow, size, selectable, stripe, } = props;
  return { rowNo, rowKey, selection, height, border, highlightCurrentRow, size, selectable, stripe };
});


const props = withDefaults(
    defineProps<{
        action: string
        columns: Columns[]
        queryFormParam?: Record<string, any>
        rightBtns?: RightBtn[]
        rightBtnsMore?: RightBtnMoreItem[]
        rowNo?: boolean
        rowKey?: string
        selection?: boolean
        renderNode?: 'detail' | 'row'   // 渲染位置
        height?: string | number,
        border?: boolean,
        highlightCurrentRow?: boolean,
        size?: '' | 'large' | 'default' | 'small'
        selectable?: (row:any,index: number) => boolean
        stripe?: boolean
    }>(),
    {
        renderNode: 'row',  // 默认值
        rowNo: false,       // 其他可选默认值
        rowKey: '_id',
        selection: false,
        height: '100%'
    }
)

const emits = defineEmits([
  'delete',
  'update',
  'current-change',
  'row-click',
  'row-dblclick',
  'row-contextmenu',
  'cell-mouse-enter',
  'cell-mouse-leave',
  'cell-click',
  'cell-dblclick',
  'header-click',
  'header-contextmenu',
  'header-dragend',
  'select',
  'select-all',
  'selection-change',
  'pagination-change'
])

const changeValue = (row: any, key: string, value: string) => {
    const index = tableData.value.findIndex(item => item._id === row._id);
    if (index !== -1) {
        tableData.value[index][key] = value;
    }
}

interface SortItem {
    name: string;
    type: 'asc' | 'desc';
}

const sortRule = ref<SortItem[]>([]);
const columnSort = (data: any) => {
    sortRule.value = sortRule.value.filter(item => item.name != data.prop)

    if (data.order) {
        sortRule.value.push({
            name: data.prop,
            type: data.order === "ascending" ? 'asc' : 'desc'
        })
    }

    getTableData()
}

const loading = ref(false)
const tableData = ref<{ _id: string;[key: string]: any }[]>([]);

const getTableData = async () => {
    loading.value = true

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
        })

        tableData.value = res.data.data.rows
        total.value = res.data.data.total
    } catch (err) {
        console.log(err)
    } finally {
        loading.value = false
    }
}

onMounted(() => {
    getTableData()
})


const btnsDetail = (index: number, row: TableRow) => {
    const tableDatas = props.columns.map((item) => {
        console.log(item)
        return {
            value: row[item.key as string],
            row,
            ...item
        }
    })

    
    console.log('tableDatas', tableDatas)
    detailData.value = tableDatas
    console.log('detailData', detailData)

    openInfoDialog()
}
const btnsUpdate = (index: number, row: TableRow) => {
    console.log("编辑", row)
    emits('update', index, cloneDeep(row))
}

const confirmDelete = (row: TableRow, deleteRequset: DeleteRequset) => {

    emits('delete', row, deleteRequset)
}
const btnsDeleteRequset = async ({ action, data }: { action: string; data: any }) => {
    console.log("请求删除接口", action, data)
    try {
        const res = await http.request({
            url: action,
            method: 'post',
            data
        })

        ElMessage.success("删除成功")
        getTableData()
    } catch (err) {

    }
}


const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)
const disabled = ref(false)
const background = ref(true)
const handleSizeChange = (val: number) => {
    console.log(`${val} items per page`)
    getTableData()
}
const handleCurrentChange = (val: number) => {
    console.log(`current page: ${val}`)
    getTableData()
}

const computeIndex = (index: number) => {
  return (currentPage.value - 1) * pageSize.value + index + 1;
};


// 如果布尔值 返回布尔值 如果是函数调用
const checkRightBtnsMoreDisabled = (disabled: any, row: TableRow) => {
    if (typeof disabled === 'boolean') return disabled
    if (typeof disabled === 'function') return disabled(row)
}

const flexColumnWidth = () => {
    if (props.rightBtns) return 100 * (props.rightBtns.length) + 5
    else return 0
}

const detailData = ref()
const openInfoDialog = () => {
    infoDialogVisible.value = true
}
const infoDialogVisible = ref(false)
const infoHandleClose = () => {
    infoDialogVisible.value = false
}

const getCurrentRow = (isOrigin?: boolean) => {
    if(isOrigin) return currentRow.value
    else return cloneDeep(currentRow.value)
}

const currentRow = ref()
const setCurrentRow = (row: any) =>{
    currentRow.value = row
}

defineExpose({
    search: getTableData,
    refresh: getTableData,
    getCurrentRow,
});
</script>
