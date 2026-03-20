import http from '@/utils/axios'

export const saveStorageConfig = (data: any) => {
    return http.request({
        url: '/app/admin/system/systemFile/systemfile/updateStorageConfig',
        method: 'post',
        data,
    })
}

export const getStorageConfig = () => {
    return http.request({
        url: '/app/admin/system/systemFile/systemfile/getStorageConfig',
        method: 'post',
    })
}