<template>
    <div v-loading="loading" class="flex flex-col flex-auto overflow-hidden">
        <div class="flex-auto overflow-hidden">
            <el-table :data="tableData" height="100%" style="width: 100%" @selection-change="selectionChange" row-key="_id" 
            :border="border"
            @sort-change="columnSort">
            <el-table-column type="selection" :selectable="selectable" width="55" v-if="rowNo" />

            <template v-for="item in columns" :key="item.key">
            <qa-table-column show-overflow-tooltip :key="item.key" :prop="item.key" :label="item.title" v-if="item?.show ? item.show.includes('row') : true"
                :width="item.width" :columns="item.columns" :data="item.data" :sortable="item.sortable"
                :align="item.align"
                :shape="item.shape"
                :formatter="item.formatter" :type="item.type"
                :valueFormat="item.valueFormat"
                />
            </template>
            <el-table-column align="center" v-if="rightBtns" width="400" fixed="right">
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
            <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :page-sizes="[1,5,10,20,50,100,500]"
            :size="size"
            :disabled="disabled"
            :background="background"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            />
        </div>
    </div>
</template>

<script lang="ts" setup>

import { Delete, Edit, ArrowDown, Document } from '@element-plus/icons-vue'
import type { ComponentSize } from 'element-plus'
import http from '@/utils/axios'
import { ElMessage } from 'element-plus'
import qaTableColumn from './qaTableColumn.vue'
import { debounce } from '@/utils'

type RightBtn = 'detail_auto' | 'update' | 'delete' | 'more'
type Type =  'radio' | 'select' | 'checkbox' | 'json' | 'radio' | 'text' | 'image' | 'avatar' | 'rate' | 'switch' | 'icon' | 'tag' | 'time' | 'object' | 'html' | 'money' | 'percentage' | 'address' | 'userInfo' | 'group' | 'table'
type Show = 'detail' | 'row'
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
    minWidth?:  string | number,
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
    rowHeight?:  string | number,
}
export interface DeleteRequset{
    (params: { action: string; data: any }): void
}
export interface RightBtnMoreItem {
    title: string
    disabled: (item: any) => boolean  // 可选函数
    onClick: (item: any) => void      // 可选函数
}

const props = withDefaults(
  defineProps<{
    action: string
    columns: Columns[]
    queryFormParam?: Record<string, any>
    rightBtns?: RightBtn[]
    rightBtnsMore?: RightBtnMoreItem[]
    rowNo?: boolean
    renderNode?: 'detail' | 'row'   // 渲染位置
    height?: string | number,
    border?: boolean
  }>(),
  {
    renderNode: 'row',  // 默认值
    rowNo: false,       // 其他可选默认值
  }
)

const emit = defineEmits(['elTableSelect', 'delete', 'update'])

const selectable = (row: any) => ![1, 2].includes(row.id)
const selectionChange = (row: any) => {
    emit('elTableSelect', row)
}

interface SortItem {
  name: string;
  type: 'asc' | 'desc';
}

const sortRule = ref<SortItem[]>([]);
const columnSort = (data: any) => {
    sortRule.value = sortRule.value.filter(item => item.name != data.prop)

    if(data.order){
        sortRule.value.push({
            name:data.prop,
            type:data.order === "ascending" ? 'asc' : 'desc'
        })
    }

    getTableData()
}

const loading = ref(false)
const tableData = ref([])

const getTableData = async () => {
    loading.value = true

    try {
        const res = await http.request({
            url: props.action,
            method: 'post',
            data: {
                ...props.queryFormParam,
                sortRule:sortRule.value,
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
    console.log("详情", row)
}
const btnsUpdate = (index: number, row: TableRow) => {
    console.log("编辑", row)
    emit('update',row)
}

const confirmDelete = (row: TableRow, deleteRequset: DeleteRequset) => {

    emit('delete', row, deleteRequset)
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
const size = ref<ComponentSize>('default')
const background = ref(true)
const handleSizeChange = (val: number) => {
  console.log(`${val} items per page`)
  getTableData()
}
const handleCurrentChange = (val: number) => {
  console.log(`current page: ${val}`)
  getTableData()
}


const responsiveHeight:Ref<string | number> = ref(0)
const onResize = () => {
  console.log("大小改变")
  if (props.height) {
    responsiveHeight.value = props.height
    return
  };
  const qaTableQueryHeight = document.querySelector('.qa-table-query')?.clientHeight || 0;
  const qaPaginHeight = (document.querySelector(".qa-pagination") as HTMLElement)?.offsetHeight || 0;
  const qaCustomActionHeight = (document.querySelector(".qa-custom-action") as HTMLElement)?.offsetHeight || 0;
  console.log("%cqaTableQueryHeight",'color:red',qaTableQueryHeight)
  console.log("%cqaPaginHeight",'color:red',qaPaginHeight)
  responsiveHeight.value = window.innerHeight - qaTableQueryHeight! - qaPaginHeight! - qaCustomActionHeight! - 104 - 65
}


const debouncedResize = debounce(onResize, 200)
onMounted(() => {
  onResize()
  window.addEventListener('resize', debouncedResize);

})
onUnmounted(() => {
  window.removeEventListener('resize', debouncedResize)
})


// 如果布尔值 返回布尔值 如果是函数调用
const checkRightBtnsMoreDisabled = (disabled: any, row: TableRow) => {
    if (typeof disabled === 'boolean') return disabled
    if (typeof disabled === 'function') return disabled(row)
}

defineExpose({
  search: getTableData,
  refresh: getTableData,
});
</script>
