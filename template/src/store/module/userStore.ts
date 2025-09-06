import { defineStore } from 'pinia'
import { login as loginApi } from '@/api/auth'
import { ElMessage } from 'element-plus'
export const useUserStore = defineStore(
    'user', () => {
        const expired = ref(0)
        const setExpired = (newExpired: number) => {
            expired.value = newExpired
        }

        const token = ref('')
        const setToken = (newToken: string) => {
            token.value = newToken
        }

        const login = async (data: any) => {
            const res = await loginApi(data)
            const {
                data: {
                    data: { token, expired, role },
                },
            } = res
            setToken(token)
            setExpired(expired)
            ElMessage({
                message: '登录成功',
                type: 'success',
            })
            console.log("登陆", res)
        }

        const logout = () => {

        }

        return { token, expired, setToken, login, logout }

    },
    {
        persist: true,
    }
)