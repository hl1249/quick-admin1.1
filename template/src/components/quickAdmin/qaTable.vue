<template>
    <div v-loading="loading">
        <el-table :data="tableData" style="width: 100%" @selection-change="selectionChange" row-key="_id"
            @sort-change="columnSort">
            <el-table-column type="selection" :selectable="selectable" width="55" v-if="rowNo" />

            <qa-table-column v-for="item in columns" :key="item.key" :prop="item.key" :label="item.title"
                :width="item.width" :columns="item.columns" :data="item.data" :sortable="item.sortable"
                :align="item.align"
                :shape="item.shape"
                :formatter="item.formatter" :type="item.type"
                :valueFormat="item.valueFormat"
                />

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
</template>

<script lang="ts" setup>

import { Delete, Edit, ArrowDown, Document } from '@element-plus/icons-vue'
import http from '@/utils/axios'
import { ElMessage } from 'element-plus'
import qaTableColumn from './qaTableColumn'

type Type = 'text' | 'image' | 'avatar' | 'rate' | 'switch' | 'icon' | 'tag' | 'time' | 'object' | 'html' | 'money' | 'percentage' | 'address' | 'userInfo' | 'group'

export interface Data {
    value: number | string
    label?: string,
    tagType?: "success" | "danger",
    icon?: string,
}

export interface Columns {
    key?: string
    title: string
    type: Type,
    width?: string | number,
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
    valueFormat?: string
}

type RightBtn = 'detail_auto' | 'update' | 'delete' | 'more'
export interface RightBtnMoreItem {
    title: string
    disabled: (item: any) => boolean  // 可选函数
    onClick: (item: any) => void      // 可选函数
}

export interface DeleteRequset{
    (params: { action: string; data: any }): void
}

const props = defineProps<{
    action: string,
    columns: Columns[],
    queryFormParam?: Record<string, any>
    rightBtns?: RightBtn[]
    rightBtnsMore?: RightBtnMoreItem[]
    rowNo?: boolean,
}>()
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
                sortRule:sortRule.value
            }
        })

        tableData.value = res.data.data.rows
        console.log("请求数据", res)
    } catch (err) {
        console.log(err)
    } finally {
        loading.value = false
    }
}

onMounted(() => {
    getTableData()
})

type TableRow = {
    _id: number
    [key: string]: any // 表示除了 _id 外，其他字段可以是任意 key，值类型为 any
};

const btnsDetail = (index: number, row: TableRow) => {
    console.log("详情", row)
}
const btnsUpdate = (index: number, row: TableRow) => {
    console.log("编辑", row)
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

// 如果布尔值 返回布尔值 如果是函数调用
const checkRightBtnsMoreDisabled = (disabled: any, row: TableRow) => {
    if (typeof disabled === 'boolean') return disabled
    if (typeof disabled === 'function') return disabled(row)
}
</script>
