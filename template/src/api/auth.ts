import http from '@/utils/axios'

export const login = (data: any) => {
    return http.request({
        url:'/app/admin/auth/auth/login',
        method: 'post',
        data
    })
}

export const getDynamicMenu = () => {
    return http.request({
        url:'/app/admin/auth/auth/getDynamicMenu',
        method: 'get'
    })
}
export const checkLogin = () => {
    return http.request({
        url:'/app/admin/auth/auth/checkLogin',
        method: 'get'
    })
}