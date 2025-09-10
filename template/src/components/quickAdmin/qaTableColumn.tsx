
import { ElTableColumn, ElAvatar, ElIcon, ElImage, ElRate, ElSwitch, ElTag, ElTable, ElButton } from 'element-plus'
import type { JSX } from 'vue/jsx-runtime';
import type { Columns, Data } from './qaTable.vue'
import * as Icons from '@element-plus/icons-vue';
import { timeFormat } from '@/utils'


export default defineComponent({
    name: 'qaTableColumn',
    props: {
        prop: {
            type: String as PropType<string>,
            required: true
        },
        label: String,
        type: String,
        width: {
            type: [String, Number] as PropType<string | number>, // ✅ 支持 string 或 number
            default: undefined
        },
        columns: {
            type: Array as PropType<Columns[]>, // ✅ 这里用 PropType 包裹接口数组
            default: () => [],
        },
        data: {
            type: Array as PropType<Data[]>,
            default: () => [],
        },
        defaultValue: {
            type: [Boolean, String] as PropType<boolean | string>,
            default: undefined
        },
        minWidth: {
            type: Number as PropType<number>,
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
            type: Number as PropType<number>,
            default: 40
        },

        activeValue: {
            type: [Boolean, String, Number] as PropType<boolean | string>,
            default: undefined
        },

        inactiveValue: {
            type: [Boolean, String, Number] as PropType<boolean | string>,
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
        valueFormat: {
            type: String as PropType<string>,
            default: 'yyyy-MM-dd hh:mm:ss'
        },


    },
    setup(props) {
        const { prop, label, type, width, columns, data, defaultValue, formatter, valueFormat, imageWidth, activeValue, inactiveValue, size, sortable, shape, align } = props;

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
        const renderSwitch = (value: any) => <ElSwitch v-model={value} disabled />
        const renderIcon = (value: any, renderData: Data[]) => {
            const iconName = renderData?.find(item => item.value === value)?.icon ?? value;
            const IconComponent = (Icons as Record<string, any>)[iconName];

            return <ElIcon>
                <IconComponent />
            </ElIcon>
        }
        const renderTag = (value: any, renderData: Data[]) => {
            const findItem = renderData.find((item: any) => item.value === value) as Data
            return <ElTag effect="dark" type={findItem.tagType}>{value}</ElTag>
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
                return <span>{Number(value).toFixed(2)}</span>
            }
            return <span>0.00</span>;
        }
        const renderPercentage = (value: any) => {
            if (!isNaN(Number(value))) {
                return <span>{(value * 100).toFixed(0) + '%'}</span>
            }
            return <span>0%</span>;
        }


        const renderJson = (value: any) => <span>{JSON.stringify(value)}</span>;
        const renderObject = (value: Record<string, any>) => {
            if (!value || Object.keys(value).length === 0) return null;
            const tableDatas = Object.keys(value).map((key) => ({
                title: key,
                value: value[key],
            }));
            return (
                <ElTable data={tableDatas} show-header={false} border>
                    <ElTableColumn prop="title" />
                    <ElTableColumn prop="value" />
                </ElTable>
            );
        };
        const renderMap: Record<string, (value: any, row: any, column: any, index: number) => JSX.Element | null> = {
            text: (value) => renderText(value),
            avatar: (value) => renderAvatar(value, shape),
            json: (value) => renderJson(value),
            object: (value) => renderObject(value),
            tag: (value) => renderTag(value, data),
            image: (value) => renderImage(value),
            rate: (value) => renderRate(value),
            switch: (value) => renderSwitch(value),
            icon: (value) => renderIcon(value, data),
            time: (value) => renderTime(value, valueFormat),
            html: (value, row, column, index) => renderHtml(value, row, column, index, formatter),
            money: (value) => renderMoney(value),
            percentage: (value) =>　renderPercentage(value)
        };

        const render = (value: any, type: string, row: any, column: any, index: number) => {
            const renderer = renderMap[type];
            return renderer ? renderer(value, row, column, index) : null;
        };

        return () => (

            <ElTableColumn prop={prop} label={label} width={width} sortable={sortable} align={align}>
                {{
                    default: ({ row, column, $index }: { row: any; column: any; $index: number }) => {
                        if (formatter) {
                            return type === 'html' ? <div v-html={formatter(row[prop], row, column, $index)} /> : formatter(row[prop], row, column, $index)
                        }
                        return render(row[prop], type as string, row, column, $index);
                    }
                }}
            </ElTableColumn>

        )
    }
})