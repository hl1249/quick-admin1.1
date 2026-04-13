<script lang="tsx">
import { ElTableColumn, ElAvatar, ElIcon, ElImage, ElRate, ElSwitch, ElTag, ElTable } from 'element-plus'
import type { JSX } from 'vue/jsx-runtime';
import type { Columns, Data } from '../table/qaTable.vue'
import * as Icons from '@element-plus/icons-vue';
import { Picture } from '@element-plus/icons-vue';
import { useDark } from '@vueuse/core'
import { timeFormat } from '@/utils'

type Row = {
    value: any
    key: string
    [key: string]: any
}

interface Scope {
    $index: number
    row: Row
    column: Array<any>
}

export default defineComponent({
    name: "qaDetail",
    props: {
        scope: {
            type: Object as PropType<Scope>, // ✅ 运行时类型检查 + 编译时类型提示
            required: true, // 如果是必传的
        },
        columns: {
            type: Array as PropType<Columns[]>,
            required: true,
        },
    },
    setup(props) {
        const columnsItem = computed(() => {
            return props.columns?.find(
                item => item.key === props.scope.row.key
            ) as Columns
        })
        
        const isDark = useDark()

        const renderText = (value: any) => <span>{value}</span>;
        const renderAvatar = (value: any, renderShape: 'circle' | 'square') => <ElAvatar src={value} shape={renderShape} />;
        const renderImage = (value: any) => {
            return <ElImage src={value} preview-src-list={[value]} showProgress={true} preview-teleported={true}>
                {{
                    error: () => <ElIcon><Picture /></ElIcon>
                }}
            </ElImage>;
        }

        const renderRate = (value: any) => <ElRate v-model={value} disabled />
        const renderSwitch = (value: any, row: any, prop: any) => <ElSwitch v-model={value} disabled={typeof (value) != 'boolean'} />
        const renderIcon = (value: any, renderData: Data[]) => {
            const iconName = renderData?.find(item => item.value === value)?.icon ?? value;
            const IconComponent = (Icons as Record<string, any>)[iconName];
            return IconComponent ? <ElIcon>
                <IconComponent />
            </ElIcon> : <></>
        }
        const renderTag = (value: any, data: Data[]) => {
            if (!data) return null; // 防止 undefined 报错
            const findItem = data.find((item: any) => item.value === value) as Data
            return findItem ? <ElTag effect={isDark.value ? 'plain' : 'dark'} type={findItem.tagType}>{findItem.label}</ElTag> : <></>
        }
        const renderTime = (value: any, valueFormat: string) => {
            return <span>
                {timeFormat(value, valueFormat)}
            </span>
        }
        const renderHtml = (
            value: any,
            row: any,
            column: any,
            index: number,
            formatter?: (value: any, row: any, column: any, index: number) => string | number) => {

            if (!formatter) return <span>{value}</span>; // 没有传 formatter 就直接显示原始值
            const formatterValue = formatter(value, row, column, index);
            return <div v-html={formatterValue}></div>;
        }
        const renderMoney = (value: any) => {
            if (!isNaN(Number(value))) {
                return <span>{(Number(value) / 100).toFixed(2)}</span>
            }
            return <span>-</span>;
        }
        const renderPercentage = (value: any) => {
            if (!isNaN(Number(value))) {
                return <span>{(value * 100).toFixed(0) + '%'}</span>
            }
            return <span>0%</span>;
        }
        const renderAddress = (value: any) => {
            return <span>
                {
                    (Object.keys(value).map((item: any) => {
                        return value[item]['name']
                    })).join('/')
                }
            </span>
        }
        const renderUserInfo = (value: any) => {
            return <div class="flex items-center gap-[10px]">
                <ElAvatar src={value?.avatar} size={24}></ElAvatar>
                <span>{value?.nickname}</span>
            </div>
        }
        const renderGroup = (columns: Columns[] | undefined, row: any, column: any, index: any) => {

            // console.log("%c我是gropu",'color:red;font-weight:bold',columns)
            if (!columns) return null; // 防止 undefined 报错
            return <div>{columns.map((item) => {
                if (item.type === 'group') {
                    return <div class="flex items-start gap-[10px] whitespace-nowrap">
                        <div>{item.title}:</div>
                        <div>{renderGroup(item.columns, row, column, index)}</div>
                    </div>;
                } else {
                    return <div class="flex items-start gap-[10px] whitespace-nowrap">
                        <div>{item.title}:</div>
                        <div class="flex-1 min-w-0">{item.key ? render({ value: row[item.key], type: item.type, row, column, index, columns: item.columns, data: item.data }) : null}</div>
                    </div>;
                }

            })}</div>
        }
        const renderBranch = (value: any, data: any) => {
            const findItem = data.find((item: any) => item.value === value) as Data
            return findItem ? <span>{findItem.label}</span> : <></>
        }
        const renderJson = (value: any) => {
            return <div>
                <pre class="bg-[--v-main-bg-color] whitespace-pre overflow-x-auto" >{JSON.stringify(value, null, 2)}</pre>
            </div>
        }
        const renderObject = (value: Record<string, any>, columns: Columns[]) => {
            console.log("%cvalue", 'color:pink;font-weight:bold', value)
            if (!value || Object.keys(value).length === 0 || !columns) return null;
            const tableDatas = columns.map((item) => ({
                title: item.title,
                value: value[item.key as keyof typeof value],
            }));
            return (
                <ElTable data={tableDatas} show-header={false} border>
                    <ElTableColumn prop="title" />
                    <ElTableColumn prop="value" />
                </ElTable>
            );
        };
        const renderMap: Record<string, (params: any) => JSX.Element | null> = {
            text: ({ value }) => renderText(value),
            avatar: ({ value, shape }) => renderAvatar(value, shape),
            json: ({ value }) => renderJson(value),
            object: ({ value, columns }) => renderObject(value, columns),
            tag: ({ value, data }) => renderTag(value, data),
            image: ({ value }) => renderImage(value),
            rate: ({ value }) => renderRate(value),
            switch: ({ value, row, prop }) => renderSwitch(value, row, prop),
            icon: ({ value,data }) => renderIcon(value, data),
            time: ({ value,valueFormat }) => renderTime(value, valueFormat),
            html: ({ value, row, column, index, formatter}) => renderHtml(value, row, column, index, formatter),
            money: ({ value }) => renderMoney(value),
            percentage: ({ value }) => renderPercentage(value),
            address: ({ value }) => renderAddress(value),
            userInfo: ({ value }) => renderUserInfo(value),
            group: ({ row, column, index, columns }) => renderGroup(columns, row, column, index),
            radio: ({ value, data }) => renderBranch(value, data),
            select: ({ value, data }) => renderBranch(value, data),
            checkbox: ({ value, data }) => renderBranch(value, data),
        };

        const render = (params: any) => {
            const renderer = renderMap[params.type];
            return renderer ? renderer(params) : <div class="whitespace-nowrap">{params.value}</div>;
        };

        return () => {
            const scope = props.scope
            console.log('scope',scope)
            const col = columnsItem.value
            if (!col) return null

            const {
                key: prop,
                type,
                data,
                formatter,
                valueFormat,
                shape,
                columns
            } = col
            
            const { $index, row, column } = scope
            const value = row.value
            const cellValue = prop !== undefined && prop !== null ? row[prop] : value

            return formatter
                ? (
                    type === 'html'
                        ? <div innerHTML={String(formatter(value, row, column, $index))}></div>
                        : formatter(cellValue, row, column, $index)
                )
                : render({
                    value,
                    type,
                    row,
                    prop,
                    column,
                    $index,
                    valueFormat,
                    shape,
                    columns: columns || [],
                    data,
                })
        }
    }
})
</script>