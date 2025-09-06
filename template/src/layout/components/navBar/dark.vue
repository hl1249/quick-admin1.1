<script lang="tsx">
import { defineComponent } from 'vue'
import { useToggle, useDark } from '@vueuse/core'
import { Moon, Sunny } from '@element-plus/icons-vue'
import { ElTooltip } from 'element-plus'

export default defineComponent({
    setup() {
        const isDark = useDark()
        const toggleDark = useToggle(isDark)

        return () => (
            <div class="item">
                <ElTooltip content="主题" placement="bottom">
                    <div
                        class={['switch _flex _flex-align-center', { dark: isDark.value }]}
                        onClick={() => toggleDark()}
                    >
                        <el-icon class="_flex _flex-align-center">
                            {isDark.value ? <Moon /> : <Sunny />}
                        </el-icon>
                    </div>
                </ElTooltip>
            </div>
        )
    },
})
</script>

<style lang="scss" scoped>
.switch {
    cursor: pointer;
    user-select: none;
    /* 禁止文本被选中 */
    border-radius: 20px;
    width: 45px;
    height: 24px;
    border: 1px solid var(--el-border-color);
    box-sizing: border-box;
    padding: 1px;
    transition: var(--el-transition-duration);

    .el-icon {
        transition: var(--el-transition-duration);
        border-radius: 50%;
        width: 20px;
        height: 20px;
        background: var(--el-fill-color-dark);
    }

    &.dark .el-icon {
        transform: translateX(21px);
    }

    &:hover {
        border-color: var(--el-color-primary);

        .el-icon {
            color: var(--el-color-primary);
        }
    }
}
</style>
