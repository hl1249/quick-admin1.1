import { defineStore } from 'pinia'
import { login as loginApi, getDynamicMenu } from '@/api/auth'
import { ElMessage } from 'element-plus'
import { useMenuStore } from './menuStore'
import router from '@/router'

export const useAuthStore = defineStore(
    'auth', () => {
        const expired = ref(0)
        const setExpired = (newExpired: number) => {
            expired.value = newExpired
        }

        const token = ref('')
        const setToken = (newToken: string) => {
            token.value = newToken
        }

        const userInfo = ref({})
        const setUserInfo = (newUserInfo: any) => {
            userInfo.value = newUserInfo
        }

        const login = async (data: any) => {
            const menuStore = useMenuStore()

            const res = await loginApi(data)
            const {
                data: {
                    data: { token, expired, userInfo },
                },
            } = res
            setToken(token)
            setExpired(expired)
            setUserInfo(userInfo)
            ElMessage({
                message: '登录成功',
                type: 'success',
            })
            router.push('/home')

            getDynamicMenu().then(res => {
                console.log('菜单', res)
                menuStore.initMenu(res.data.data.menus)
            })
            console.log("登陆", res)
        }

        const logout = () => {
            token.value = ''
            expired.value = 0
            userInfo.value = {}
            // 返回登录页面
            router.push('/login')
        }

        return { token, expired, userInfo, setUserInfo, setToken, login, logout }

    },
    {
        persist: true,
    }
)