
import {ElFormItem, ElTableColumn, ElAvatar, ElIcon, ElImage, ElRate, ElSwitch, ElTag, ElTable, ElButton, ElRadio } from 'element-plus'
import { useVModel } from "@vueuse/core"
import type { JSX } from 'vue/jsx-runtime';
import type { Columns, Data } from './qaTable.vue'
import * as Icons from '@element-plus/icons-vue';
import { timeFormat } from '@/utils'
import { useDark, useLocalStorage } from '@vueuse/core'
export default defineComponent({
    emits: ["update:modelValue"],
    props:{
        modelValue: { type: Object, required: true },
        label:{
            
        },
        itemKey:{
            
        },
        type:{

        },
        labelWidth:{

        },
        rules:{

        },
    },
    setup() {
        return () => {
            <div>维护</div>
        }
    }
})