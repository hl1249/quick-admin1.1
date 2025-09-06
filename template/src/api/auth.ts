import http from '@/utils/axios'

export const login = (data: any) => {
    return http.request({
        url:'/app/client/user/user/login',
        method: 'post',
        data
    })
}

export const getDynamicMenu = () => {

}