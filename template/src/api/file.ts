import http from '@/utils/axios'

export const saveAppConfig = (data: any) => {
    return http.request({
        url: '/app/admin/system/systemFile/systemfile/appConfig/update',
        method: 'post',
        data,
    })
}

export const getAppConfig = () => {
    return http.request({
        url: '/app/admin/system/systemFile/systemfile/appConfig/get',
        method: 'post',
    })
}

export const getStorageConfig = (data: any) => {
    return http.request({
        url: '/app/admin/system/systemFile/systemfile/storageConfig/get',
        method: 'post',
        data,
    })
}

export const syncStorageSpace = (data: any) => {
    return http.request({
        url: '/app/admin/system/systemFile/systemfile/space/sync',
        method: 'post',
        data,
    })
}