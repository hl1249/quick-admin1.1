<script lang="tsx">

import { ElTableColumn, ElAvatar, ElIcon, ElImage, ElRate, ElSwitch, ElTag, ElTable, ElButton, ElRadio } from 'element-plus'
import type { JSX } from 'vue/jsx-runtime';
import type { Columns, Data } from './qaTable.vue'
import * as Icons from '@element-plus/icons-vue';
import { timeFormat } from '@/utils'
import { useDark } from '@vueuse/core'


export default defineComponent({
    name: 'qaTableColumn',
    props: {
        prop: {
            type: String as PropType<string>,
            default: ""
        },
        label: String,
        type: String,
        width: {
            type: [String, Number] as PropType<string | number>,
            default: undefined
        },
        columns: {
            type: Array as PropType<Columns[]>,
            default: () => [],
        },
        data: {
            type: Array as PropType<Data[]>,
            default: () => [],
        },
        minWidth: {
            type: [String, Number] as PropType<string | number>, // ✅ 改为支持 string | number
            default: 150
        },
        align: {
            type: String as PropType<'left' | 'center' | 'right'>,
            default: undefined
        },
        formatter: {
            type: Function as PropType<(value: any, row: any, column: any, index: number) => string | number>,
            default: undefined
        },
        imageWidth: {
            type: [String, Number] as PropType<string | number>, // ✅ 改为支持 string | number
            default: 40
        },
        // 修改 activeValue 类型以匹配 Columns 接口
        activeValue: {
            type: [Boolean, String, Number] as PropType<boolean | string | number>, // ✅ 添加 number 类型
            default: undefined
        },
        // 修改 inactiveValue 类型以匹配 Columns 接口
        inactiveValue: {
            type: [Boolean, String, Number] as PropType<boolean | string | number>, // ✅ 添加 number 类型
            default: undefined
        },
        size: {
            type: String as PropType<'' | 'large' | 'default' | 'small'>,
            default: ''
        },
        sortable: {
            type: [Boolean, String] as PropType<boolean | string>,
            default: false
        },
        shape: {
            type: String as PropType<'circle' | 'square'>,
            default: 'circle'
        },
        show: {
            type: Array as PropType<Array<'row' | 'detail' | 'expand' | 'none'>>,
            default: () => ['row', 'detail', 'detail'] // 每个组件实例都会生成新的数组
        },
        valueFormat: {
            type: String as PropType<string>,
            default: 'yyyy-MM-dd hh:mm:ss'
        },
        rowHeight: {
            type: [String, Number] as PropType<string | number>,
            default: undefined
        },
        watch: {
            type: Function as PropType<(value: any) => void>,
            default: undefined
        },
        // 添加 title 属性（与 label 对应）
        title: {
            type: String as PropType<string>,
            default: undefined
        }
    },
    emits: ["changeValue"],
    setup(props, { emit }) {

        const isDark = useDark()


        const changeValue = (row: any, prop: string, value: any) => {
            emit('changeValue', row, prop, value)
        }

        const handleChange = (value: any, row: any, prop: any) => {
            if (props.watch) {
                props.watch({
                    value,
                    row,
                    change: (newValue: any) => changeValue(row, prop, newValue)
                })
            }
        }

        const renderText = (value: any) => <span>{value}</span>;
        const renderAvatar = (value: any, renderShape: 'circle' | 'square') => <ElAvatar src={value} shape={renderShape} />;
        const renderImage = (value: any) => {
            const PictureIcon = Icons.Picture; // 这里明确指定图标组件
            return <ElImage src={value} preview-src-list={[value]} showProgress={true} preview-teleported={true}>
                {{
                    error: () => {
                        return <ElIcon ><PictureIcon /></ElIcon>
                    }
                }}
            </ElImage>;
        }

        const renderRate = (value: any) => <ElRate v-model={value} disabled />
        const renderSwitch = (value: any, row: any, prop: any) => <ElSwitch v-model={value} disabled={typeof (value) != 'boolean'} onChange={() => { handleChange(value, row, prop) }} />
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
            avatar: ({ value,shape }) => renderAvatar(value, shape),
            json: ({ value }) => renderJson(value),
            object: ({ value, columns }) => renderObject(value, columns),
            tag: ({ value, data }) => renderTag(value, data),
            image: ({ value }) => renderImage(value),
            rate: ({ value }) => renderRate(value),
            switch: ({ value, row, prop }) => renderSwitch(value, row, prop),
            icon: ({ value,data }) => renderIcon(value, data),
            time: ({ value }) => renderTime(value, props.valueFormat),
            html: ({ value, row, column, index }) => renderHtml(value, row, column, index, props.formatter),
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
            const {
                prop,
                label,
                type,
                width,
                columns,
                data,
                formatter,
                valueFormat,
                imageWidth,
                activeValue,
                inactiveValue,
                size,
                sortable,
                shape,
                align,
                show
            } = props

            if (!show.includes('row')) return null

            return (
                <ElTableColumn
                    prop={prop}
                    label={label}
                    width={width}
                    sortable={sortable}
                    align={align}
                >
                    {{
                        default: ({ row, column, $index }: { row: any; column: any; $index: number }) => {
                            const value = row[prop]

                            if (formatter) {
                                return type === 'html'
                                    ? <div v-html={formatter(value, row, column, $index)} />
                                    : formatter(value, row, column, $index)
                            }

                            return render({
                                value,
                                type,
                                row,
                                prop,
                                column,
                                $index,
                                columns,
                                data
                            })
                        }
                    }}
                </ElTableColumn>
            )
        }
    }
})
</script>
