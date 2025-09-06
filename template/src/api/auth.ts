import http from '@/utils/axios'

export const login = (data: any) => {
    console.log("我进来了")
    return http.request({
        url: '/app/admin/auth/auth/login',
        method: 'post',
        data
    })
}

export const getDynamicMenu = () => {

}