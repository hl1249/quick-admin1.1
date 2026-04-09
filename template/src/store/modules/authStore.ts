import { defineStore } from 'pinia'
import { login as loginApi, checkLogin as checkLoginApi } from '@/api/auth'
import { ElMessage } from 'element-plus'
import router from '@/router'
import { useMenuStore } from './menuStore'

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
        }

        const logout = () => {
            const menuStore = useMenuStore()
            menuStore.clearMenuList()
            token.value = ''
            expired.value = 0
            userInfo.value = {}
            // 返回登录页面
            router.push('/login')
        }

        const checkLogin = async () => {
            if (!token.value) return false

            try {
                const res = await checkLoginApi() 
                return res.data.data
            } catch (err) {
                logout()
                return false
            }

        }
        return { token, expired, userInfo, setUserInfo, setToken, login, logout, checkLogin }

    },
    {
        persist: true,
    }
)