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

export const getSystemCategories = (data: any) => {
    return http.request({
        url: '/app/admin/system/systemFile/systemCategories/getList',
        method: 'post',
        data,
    })
}

export const updateSystemFileName = (data: { _id: string; original_name: string }) => {
    return http.request({
        url: '/app/admin/system/systemFile/systemFile/files/update',
        method: 'post',
        data,
    })
}