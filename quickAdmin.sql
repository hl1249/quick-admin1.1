/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MongoDB
 Source Server Version : 80201
 Source Host           : localhost:27017
 Source Schema         : quickAdmin

 Target Server Type    : MongoDB
 Target Server Version : 80201
 File Encoding         : 65001

 Date: 22/12/2025 15:24:11
*/


// ----------------------------
// Collection structure for qa-logs
// ----------------------------
db.getCollection("qa-logs").drop();
db.createCollection("qa-logs");

// ----------------------------
// Documents of qa-logs
// ----------------------------
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6917fb143333c26ad3618252"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjMxNzg4ODcsImV4cCI6MTc2Mzc4MzY4N30.H1xifQXBi5VIWw3xWyDKkRR7Uvxk1oOnf1D_yOKF1PM",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "a5884531-6aaf-4244-833a-ae23035c053e",
    "_add_time": 1763179284449,
    "_add_time_str": "2025-11-15 12:01:24",
    response: {
        _id: ObjectId("672b901c0fcabce5e29faef5"),
        username: "admin",
        password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
        role: [
            "admin"
        ],
        "_add_time": 1730908188567,
        "_add_time_str": "2024-11-06 23:49:48",
        no: NumberInt("2"),
        image: "https://avatars.githubusercontent.com/u/53579755?v=4",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            null,
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjMxNzM4MjgsImV4cCI6MTc2Mzc3ODYyOH0.MIkmETK6UumI15Hzr5t_EbcjuxYdHZtFRYgF0v2AUeE",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjMxNzg4ODcsImV4cCI6MTc2Mzc4MzY4N30.H1xifQXBi5VIWw3xWyDKkRR7Uvxk1oOnf1D_yOKF1PM"
        ],
        "last_login_date": 1763178887679,
        "last_login_ip": "127.0.0.1",
        object: {
            name: "小明",
            age: NumberInt("18")
        },
        userInfo: {
            name: "小明",
            age: NumberInt("18"),
            avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
            nickname: "你猜"
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935005fa92d49c26baa45c1"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "3603ccc2-ab05-46d9-916a-6f1da785c23a",
    "_add_time": 1765081183793,
    "_add_time_str": "2025-12-07 12:19:43",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935006ec4c679d0e781456d"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("500"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "5d822e73-290f-4007-aa91-ed7bd9433458",
    "_add_time": 1765081198168,
    "_add_time_str": "2025-12-07 12:19:58",
    response: NumberInt("1")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693500d70c4a361dce731d1c"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "ec37a78d-df21-49b6-b843-04d60aa9fbbe",
    "_add_time": 1765081303981,
    "_add_time_str": "2025-12-07 12:21:43",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693500d80c4a361dce731d24"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "7402a623-d37b-44df-b92e-0e833d3b9262",
    "_add_time": 1765081304955,
    "_add_time_str": "2025-12-07 12:21:44",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693500e10c4a361dce731d3e"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "d922f554-e373-47b2-8311-da06caa5f3c7",
    "_add_time": 1765081313033,
    "_add_time_str": "2025-12-07 12:21:53",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693500e20c4a361dce731d4a"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "dfb9f659-d9eb-4c26-9253-ebe3165c8403",
    "_add_time": 1765081314637,
    "_add_time_str": "2025-12-07 12:21:54",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693500e80c4a361dce731d56"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "34b6bed0-1ae1-4b7d-b159-6630cb470b09",
    "_add_time": 1765081320921,
    "_add_time_str": "2025-12-07 12:22:00",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693500fe0c4a361dce731d5e"),
    url: "/app/admin/system/systemPermission/systemPermission/add",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "93",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        enable: true,
        "permission_id": "test",
        "permission_name": "测试",
        url: [
            "/*"
        ],
        "match_mode": NumberInt("1")
    },
    requestId: "b2cbadb4-ddee-4ccb-a7f8-4ef8aec1e955",
    "_add_time": 1765081342150,
    "_add_time_str": "2025-12-07 12:22:22",
    response: {
        acknowledged: true,
        insertedId: ObjectId("693500fe0c4a361dce731d60")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693500fe0c4a361dce731d66"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "0e966fb4-efbf-4e10-b9e2-a0a4e0bb7c98",
    "_add_time": 1765081342174,
    "_add_time_str": "2025-12-07 12:22:22",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("12"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693500ff0c4a361dce731d6e"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "97b66880-9ca1-4c71-8288-56998e3c478b",
    "_add_time": 1765081343242,
    "_add_time_str": "2025-12-07 12:22:23",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("12"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501000c4a361dce731d76"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "795940ec-0b51-4851-876b-8ef0e3b5bcb5",
    "_add_time": 1765081344380,
    "_add_time_str": "2025-12-07 12:22:24",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("12"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501000c4a361dce731d7e"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "6bfd67a0-2dc6-48b4-8038-55c4e60863a9",
    "_add_time": 1765081344583,
    "_add_time_str": "2025-12-07 12:22:24",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("12"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501010c4a361dce731d86"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("10")
    },
    requestId: "9c416f7f-3540-46e3-b4fe-dfb182818b1e",
    "_add_time": 1765081345182,
    "_add_time_str": "2025-12-07 12:22:25",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("693500fe0c4a361dce731d60"),
                "permission_id": "test",
                "permission_name": "测试",
                url: [
                    "/*"
                ],
                "match_mode": NumberInt("1"),
                enable: true,
                comment: null,
                "_add_time": 1765081342152,
                "_add_time_str": "2025-12-07 12:22:22"
            }
        ],
        hasMore: false,
        total: NumberInt("12"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501200c4a361dce731d91"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "fecb6c2d-0f11-4880-9665-5cbbbcba3650",
    "_add_time": 1765081376131,
    "_add_time_str": "2025-12-07 12:22:56",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("12"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501220c4a361dce731d99"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("10")
    },
    requestId: "15a0ecda-3459-4875-9e99-a1e9d61d225f",
    "_add_time": 1765081378104,
    "_add_time_str": "2025-12-07 12:22:58",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("693500fe0c4a361dce731d60"),
                "permission_id": "test",
                "permission_name": "测试",
                url: [
                    "/*"
                ],
                "match_mode": NumberInt("1"),
                enable: true,
                comment: null,
                "_add_time": 1765081342152,
                "_add_time_str": "2025-12-07 12:22:22"
            }
        ],
        hasMore: false,
        total: NumberInt("12"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501230c4a361dce731da1"),
    url: "/app/admin/system/systemPermission/systemPermission/delete",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "34",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        _id: "693500fe0c4a361dce731d60"
    },
    requestId: "d1b71576-6642-401d-99ae-f33b915b9d90",
    "_add_time": 1765081379997,
    "_add_time_str": "2025-12-07 12:22:59",
    response: {
        acknowledged: true,
        deletedCount: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501240c4a361dce731da8"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("10")
    },
    requestId: "aa1f16b4-005f-4bc1-a615-c5b012003bd1",
    "_add_time": 1765081380018,
    "_add_time_str": "2025-12-07 12:23:00",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            }
        ],
        hasMore: false,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501250c4a361dce731db0"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("10")
    },
    requestId: "3518ee72-e487-411f-8492-f8200ec92873",
    "_add_time": 1765081381186,
    "_add_time_str": "2025-12-07 12:23:01",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            }
        ],
        hasMore: false,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501250c4a361dce731db8"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "6c5a6543-36c2-4c2d-b3e7-38c4c6ffd65d",
    "_add_time": 1765081381939,
    "_add_time_str": "2025-12-07 12:23:01",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501270c4a361dce731dc0"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "318",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("500")
    },
    requestId: "98e3f047-39d6-4e28-95ae-49a8f4076bec",
    "_add_time": 1765081383027,
    "_add_time_str": "2025-12-07 12:23:03",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            },
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            }
        ],
        hasMore: false,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("500")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501280c4a361dce731dc8"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("5")
    },
    requestId: "2bfa75a0-bcae-4141-9ecf-da4e5651f547",
    "_add_time": 1765081384447,
    "_add_time_str": "2025-12-07 12:23:04",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501290c4a361dce731dd0"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("5")
    },
    requestId: "e869db73-0afd-453e-82ba-e4abae799b56",
    "_add_time": 1765081385061,
    "_add_time_str": "2025-12-07 12:23:05",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935012b0c4a361dce731dd8"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("5")
    },
    requestId: "9ad7109d-5f8e-4e0f-beb8-ff7b0f825347",
    "_add_time": 1765081387336,
    "_add_time_str": "2025-12-07 12:23:07",
    response: {
        rows: [
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935012b0c4a361dce731de0"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("3"),
        pageSize: NumberInt("5")
    },
    requestId: "f699b6b0-aeb2-4198-981a-d44174ba442d",
    "_add_time": 1765081387807,
    "_add_time_str": "2025-12-07 12:23:07",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            }
        ],
        hasMore: false,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("3"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935012c0c4a361dce731de8"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("5")
    },
    requestId: "18c56e09-3b08-4055-89d2-24f70eb08e96",
    "_add_time": 1765081388274,
    "_add_time_str": "2025-12-07 12:23:08",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935012c0c4a361dce731df0"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("5")
    },
    requestId: "f153f184-dd79-4bba-a86e-64f805f5deb7",
    "_add_time": 1765081388709,
    "_add_time_str": "2025-12-07 12:23:08",
    response: {
        rows: [
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935012e0c4a361dce731df8"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("3"),
        pageSize: NumberInt("5")
    },
    requestId: "f090c550-aae1-4bae-97a4-bb7c89cfd23d",
    "_add_time": 1765081390333,
    "_add_time_str": "2025-12-07 12:23:10",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            }
        ],
        hasMore: false,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("3"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935012e0c4a361dce731e00"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("5")
    },
    requestId: "5b05a185-4c01-4976-beda-e4922dc2c3e6",
    "_add_time": 1765081390978,
    "_add_time_str": "2025-12-07 12:23:10",
    response: {
        rows: [
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935012f0c4a361dce731e08"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "316",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("5")
    },
    requestId: "57713490-7c8f-472d-9072-f7f8a7ce94d2",
    "_add_time": 1765081391578,
    "_add_time_str": "2025-12-07 12:23:11",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("5")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501330c4a361dce731e10"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "f04b49c4-5904-4c40-b90b-496399b2ff65",
    "_add_time": 1765081395041,
    "_add_time_str": "2025-12-07 12:23:15",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501330c4a361dce731e18"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("10")
    },
    requestId: "80321470-de50-4dbc-9a60-69a61cff0d56",
    "_add_time": 1765081395911,
    "_add_time_str": "2025-12-07 12:23:15",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            }
        ],
        hasMore: false,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501370c4a361dce731e24"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "a5e4c712-1063-4edd-86a0-d484fbe00588",
    "_add_time": 1765081399704,
    "_add_time_str": "2025-12-07 12:23:19",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501380c4a361dce731e2f"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "6c30a221-b3c1-41aa-a974-bd18ab048b69",
    "_add_time": 1765081400329,
    "_add_time_str": "2025-12-07 12:23:20",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935013b0c4a361dce731e37"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("10")
    },
    requestId: "1b1f2b22-423c-4826-9512-c7a6e15e3f1e",
    "_add_time": 1765081403421,
    "_add_time_str": "2025-12-07 12:23:23",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            }
        ],
        hasMore: false,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935015a0c4a361dce731e3f"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("2"),
        pageSize: NumberInt("10")
    },
    requestId: "0d823cf3-e5bd-45c7-9556-41372d9f6cf2",
    "_add_time": 1765081434550,
    "_add_time_str": "2025-12-07 12:23:54",
    response: {
        rows: [
            {
                _id: ObjectId("68f346d5a144c9f3f337272d"),
                "_add_time": 1596416400000,
                comment: "菜单权限",
                enable: true,
                "permission_id": "sys-manage",
                "permission_name": "系统菜单权限",
                sort: NumberInt("0"),
                url: [ ]
            }
        ],
        hasMore: false,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("2"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693501670c4a361dce731e4f"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "fa7dd518-41fc-41c1-8894-02e5e9dd7d96",
    "_add_time": 1765081447185,
    "_add_time_str": "2025-12-07 12:24:07",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6935016a0c4a361dce731e5b"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "f050bccc-94f1-4fa6-af8b-2cc916b185b4",
    "_add_time": 1765081450593,
    "_add_time_str": "2025-12-07 12:24:10",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69350f6c0c4a361dce731e7a"),
    url: "/app/admin/system/systemPermission/systemPermission/getList",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3001",
        connection: "close",
        "content-length": "317",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjUwNzM4NTUsImV4cCI6MTc2NTY3ODY1NX0.Y7sPYE7N6NUo7O-6HKWWCib2zYkdxl5ZCh98NLDusCk",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:5173",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:5173/system/system-permission",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        formData: { },
        columns: [
            {
                key: "role_id",
                type: "text",
                title: "角色标识",
                width: NumberInt("230"),
                mode: "="
            },
            {
                key: "role_name",
                type: "text",
                title: "角色名称",
                mode: "=",
                width: NumberInt("230")
            },
            {
                key: "_add_time",
                type: "datetimerange",
                title: "添加时间",
                mode: "[]",
                width: NumberInt("230")
            }
        ],
        sortRule: [ ],
        pageIndex: NumberInt("1"),
        pageSize: NumberInt("10")
    },
    requestId: "1194083e-2731-4770-a52c-8ee01aad0c92",
    "_add_time": 1765085036118,
    "_add_time_str": "2025-12-07 13:23:56",
    response: {
        rows: [
            {
                _id: ObjectId("672b201418a1950fd5ed1701"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-log",
                "permission_name": "系统-请求日志",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemLog/*"
                ],
                "match_mode": NumberInt("0")
            },
            {
                _id: ObjectId("6745485d91b2ac8efc8bc94e"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-user",
                "permission_name": "系统-用户管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemUser/systemUser/add",
                    "/app/admin/system/systemUser/systemUser/delete",
                    "/app/admin/system/systemUser/systemUser/update",
                    "/app/admin/system/systemUser/systemUser/getList"
                ]
            },
            {
                _id: ObjectId("674548c891b2ac8efc8bc950"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-menu",
                "permission_name": "系统-菜单管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemMenu/systemMenu/add",
                    "/app/admin/system/systemMenu/systemMenu/delete",
                    "/app/admin/system/systemMenu/systemMenu/update",
                    "/app/admin/system/systemMenu/systemMenu/getList"
                ]
            },
            {
                _id: ObjectId("674548ec91b2ac8efc8bc951"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-role",
                "permission_name": "系统-角色管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemRole/systemRole/add",
                    "/app/admin/system/systemRole/systemRole/delete",
                    "/app/admin/system/systemRole/systemRole/update",
                    "/app/admin/system/systemRole/systemRole/getList"
                ]
            },
            {
                _id: ObjectId("6745490491b2ac8efc8bc952"),
                "_add_time": 1596416400000,
                comment: "",
                enable: true,
                "permission_id": "sys-file",
                "permission_name": "系统-素材管理",
                "parent_id": "sys-manage",
                sort: NumberInt("1"),
                url: [
                    "/app/admin/system/systemFile/systemFile/add",
                    "/app/admin/system/systemFile/systemFile/delete",
                    "/app/admin/system/systemFile/systemFile/update",
                    "/app/admin/system/systemFile/systemFile/getList"
                ]
            },
            {
                _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
                "_add_time": 1596416400000,
                comment: "CRUD权限",
                enable: true,
                "permission_id": "sys-permission",
                "permission_name": "系统内置权限",
                sort: NumberInt("0"),
                url: [ ]
            },
            {
                _id: ObjectId("6745907091b2ac8efc8bc9ad"),
                "_add_time": 1596416400000,
                comment: "所有路由以add结尾路由",
                enable: true,
                "permission_id": "sys-add",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 增",
                sort: NumberInt("0"),
                url: [
                    "*/add"
                ]
            },
            {
                _id: ObjectId("6745911391b2ac8efc8bc9ae"),
                "_add_time": 1596416400000,
                comment: "所有路由以delete结尾路由",
                enable: true,
                "permission_id": "sys-delete",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 删",
                sort: NumberInt("0"),
                url: [
                    "*/delete"
                ]
            },
            {
                _id: ObjectId("6745917291b2ac8efc8bc9b0"),
                "_add_time": 1596416400000,
                comment: "所有路由以update结尾路由",
                enable: true,
                "permission_id": "sys-update",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 改",
                sort: NumberInt("0"),
                url: [
                    "*/update"
                ]
            },
            {
                _id: ObjectId("6745919991b2ac8efc8bc9b1"),
                "_add_time": 1596416400000,
                comment: "所有查询",
                enable: true,
                "permission_id": "sys-read",
                "parent_id": "sys-permission",
                "permission_name": "系统内置 - 查",
                sort: NumberInt("0"),
                url: [
                    "*/getList",
                    "*/select",
                    "*/getAll",
                    "*/getDynamicMenu"
                ]
            }
        ],
        hasMore: true,
        total: NumberInt("11"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379096d7086047d2532315"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "c6700c32-1765-47ca-b350-58a104be65d5",
    "_add_time": 1765249174662,
    "_add_time_str": "2025-12-09 10:59:34",
    response: "redis"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693790bbb179d1c8235acf5b"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"60-rfH0Q+qQLDtDsxJFYFfhXpGt1BE\""
    },
    body: null,
    requestId: "53590087-1221-4a18-bfae-9932c0196147",
    "_add_time": 1765249211080,
    "_add_time_str": "2025-12-09 11:00:11",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693790c9a3044a4e7c86d4f2"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-8skBqFwIMdOdPfCWlC5IvB7CyCY\""
    },
    body: null,
    requestId: "26278a1c-12f2-445e-b0cf-4dc12da1021f",
    "_add_time": 1765249225624,
    "_add_time_str": "2025-12-09 11:00:25",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693790dca3044a4e7c86d4f6"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-/0Dfqpppxz4EA35Y2SMznD4EtKM\""
    },
    body: null,
    requestId: "794b46fd-ff25-4389-ab94-40eb4334a2ef",
    "_add_time": 1765249244300,
    "_add_time_str": "2025-12-09 11:00:44",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379115a3044a4e7c86d4fa"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-Om5ijztYrbV8H3W6itvrXcGfRy0\""
    },
    body: null,
    requestId: "2115cd6e-d2f2-41e4-aa27-275cdab079fd",
    "_add_time": 1765249301729,
    "_add_time_str": "2025-12-09 11:01:41",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379117a3044a4e7c86d4fe"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-XRVWxvbcChpp699DqmsfUhlEXPI\""
    },
    body: null,
    requestId: "c45f46a9-eb24-4d83-b1af-e461b2a0769c",
    "_add_time": 1765249303209,
    "_add_time_str": "2025-12-09 11:01:43",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379151c0bd7ce1cfa97c75"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-CSul5IC5OPO+fVSaXwntTKMvk8o\""
    },
    body: null,
    requestId: "c78741c2-e876-49b6-b2f8-f99ff38c83ff",
    "_add_time": 1765249361047,
    "_add_time_str": "2025-12-09 11:02:41",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693791755996c3e0c0d24b68"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-WytewaqCTxU3cAeI9IXrl1d1HyY\""
    },
    body: null,
    requestId: "69cfbedd-1035-48c9-b1d8-9669afc477a8",
    "_add_time": 1765249397381,
    "_add_time_str": "2025-12-09 11:03:17",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937918a14aee150218be7b0"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-IfEJSSNNTyiu8xTlUJcXFU3L7GM\""
    },
    body: null,
    requestId: "cf8122cb-d9db-4abb-8e5c-00d23d6499f3",
    "_add_time": 1765249418817,
    "_add_time_str": "2025-12-09 11:03:38",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693792fc14aee150218be7b4"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-6rfF6gBD+kNE4+ez1J6CPpJ8hXA\""
    },
    body: null,
    requestId: "9f799055-bd24-4158-865b-786678468267",
    "_add_time": 1765249788849,
    "_add_time_str": "2025-12-09 11:09:48",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379321a62553a844ed44a3"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-rp0CZZwpIG628fqqL08He+IatLg\""
    },
    body: null,
    requestId: "324d1790-76fd-4d47-8f73-20e8010b3fd9",
    "_add_time": 1765249825247,
    "_add_time_str": "2025-12-09 11:10:25",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379321a62553a844ed44a7"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-RU0erlbaEp1qBNq7O73ZaWksAzs\""
    },
    body: null,
    requestId: "84fe14de-2b62-4f0f-af83-050416dc4832",
    "_add_time": 1765249825869,
    "_add_time_str": "2025-12-09 11:10:25",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379322a62553a844ed44ab"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-1bj2UrMLWh+fAuNSmNRSllwrZ5U\""
    },
    body: null,
    requestId: "b2aa157d-7c17-4ece-b012-40dbdf87b773",
    "_add_time": 1765249826039,
    "_add_time_str": "2025-12-09 11:10:26",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379322a62553a844ed44af"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-tfScLUKy2FmsSN+iSWD6zBoNGtc\""
    },
    body: null,
    requestId: "45d004a4-5c04-45f6-a5ae-a70250120920",
    "_add_time": 1765249826168,
    "_add_time_str": "2025-12-09 11:10:26",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379322a62553a844ed44b3"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-NtovsvST4E19F5IziUOzN92EM2M\""
    },
    body: null,
    requestId: "96cef0f1-77da-497c-bd09-e0980b0ec5cd",
    "_add_time": 1765249826287,
    "_add_time_str": "2025-12-09 11:10:26",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379322a62553a844ed44b7"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-FT6pLwvYzOoI6EIWEmflVh77G+Y\""
    },
    body: null,
    requestId: "55933ca3-7eb4-4050-8ee9-a6812aba6a95",
    "_add_time": 1765249826404,
    "_add_time_str": "2025-12-09 11:10:26",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379322a62553a844ed44bb"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-h25CVH5Ne1bn9my7zKCCYTjiTko\""
    },
    body: null,
    requestId: "55b7321b-0a2a-4e2a-84a4-b0c2caebdac4",
    "_add_time": 1765249826535,
    "_add_time_str": "2025-12-09 11:10:26",
    response: {
        value: { }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693793cfb8f6bd99938265f6"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"65-h9R+pvaiTYFf0qWgw7WJnunuajE\""
    },
    body: null,
    requestId: "66f70d68-001e-4777-abe2-165c1d8c145c",
    "_add_time": 1765249999288,
    "_add_time_str": "2025-12-09 11:13:19",
    response: {
        value: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693793dc58f1ea4071bf5c8e"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"64-czcdKBPtcg7NUo7yifWvhu0PbjM\""
    },
    body: null,
    requestId: "f0c8a9ca-70a7-46b4-a596-22ced62e0c77",
    "_add_time": 1765250012604,
    "_add_time_str": "2025-12-09 11:13:32",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693793e258f1ea4071bf5c92"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-47ZEmKqgRU/VwtRkVXGQ3t6GHUE\""
    },
    body: null,
    requestId: "944ff744-5b12-41a2-ac50-c42a900acc76",
    "_add_time": 1765250018971,
    "_add_time_str": "2025-12-09 11:13:38",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693793e358f1ea4071bf5c96"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-Jig1dArz9DHuTN4IdzJHwH8o5kI\""
    },
    body: null,
    requestId: "3c1203eb-b80f-461a-bfc3-e23763141d10",
    "_add_time": 1765250019743,
    "_add_time_str": "2025-12-09 11:13:39",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693793e358f1ea4071bf5c9a"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-oly8hY8Fc0viJiGauyvJN1Oxduo\""
    },
    body: null,
    requestId: "c49c5500-1fc4-4c7f-9882-c0da8fa89d40",
    "_add_time": 1765250019917,
    "_add_time_str": "2025-12-09 11:13:39",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693793e7e43114a3ef7894f7"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-+IMnVzVB2CDa55dM+ZS3z2FtyKA\""
    },
    body: null,
    requestId: "65995886-8707-442b-946c-b6e966f11519",
    "_add_time": 1765250023179,
    "_add_time_str": "2025-12-09 11:13:43",
    response: {
        value: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379447e43114a3ef7894fb"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"64-ho3aXUMHKammC/1hAZy9yGwpDAs\""
    },
    body: null,
    requestId: "d77f05b1-3509-4449-9923-5e5089433e41",
    "_add_time": 1765250119040,
    "_add_time_str": "2025-12-09 11:15:19",
    response: {
        value: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937944f379ec80453fe3c3c"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"64-L3CKJ/g1Noe1ueCsuB2lTDzyjl4\""
    },
    body: null,
    requestId: "7619da0b-a852-45d6-9e2e-d5856c958339",
    "_add_time": 1765250127081,
    "_add_time_str": "2025-12-09 11:15:27",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379451379ec80453fe3c40"),
    url: "/redis/set",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "4319d934-67c3-46aa-9266-07faa488dbf6",
    "_add_time": 1765250129607,
    "_add_time_str": "2025-12-09 11:15:29",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379454379ec80453fe3c44"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-aBeMaiSp+iJ4yl6trKvlvyb9oT4\""
    },
    body: null,
    requestId: "7ea2b241-2617-4472-aba4-d772e889235e",
    "_add_time": 1765250132954,
    "_add_time_str": "2025-12-09 11:15:32",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379459379ec80453fe3c48"),
    url: "/redis/set",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-Qt8KZfM5V5S8IYBil/ByUp/W9Wg\""
    },
    body: null,
    requestId: "e2605cbd-13a3-4796-bdcf-03b60bcb8399",
    "_add_time": 1765250137588,
    "_add_time_str": "2025-12-09 11:15:37",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937945b379ec80453fe3c4c"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-FGWxD6O3ltHLZALGFAWIEz6JMyk\""
    },
    body: null,
    requestId: "8ecf953c-69ac-4ba0-8e1e-afd3eb609568",
    "_add_time": 1765250139893,
    "_add_time_str": "2025-12-09 11:15:39",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937949693c41e938177f2a8"),
    url: "/redis/set",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-ZEjriVVWx1xa/yt5sXKdUymMhA0\""
    },
    body: null,
    requestId: "0aa856f4-25c3-4d3e-b693-eed00d7a34e3",
    "_add_time": 1765250198913,
    "_add_time_str": "2025-12-09 11:16:38",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937949793c41e938177f2ac"),
    url: "/redis",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-olBcu7w6gWLKSrj3w0E702yEI+g\""
    },
    body: null,
    requestId: "7dc4fa07-cfb1-4499-b78e-40b651e5da01",
    "_add_time": 1765250199699,
    "_add_time_str": "2025-12-09 11:16:39",
    response: {
        value: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937949993c41e938177f2b0"),
    url: "/redis/set",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-BgpF3L+EZs23bhDkrZfcTCSw8Is\""
    },
    body: null,
    requestId: "decde01d-a892-48b1-a8c2-305e685d75b7",
    "_add_time": 1765250201379,
    "_add_time_str": "2025-12-09 11:16:41",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794b3500b695f343309ac"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "ec1cb856-cce3-4dfa-8cbc-c272bab73762",
    "_add_time": 1765250227158,
    "_add_time_str": "2025-12-09 11:17:07",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794b9500b695f343309b0"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "bc9f3e7f-f996-4fe0-8957-b645885a5e39",
    "_add_time": 1765250233612,
    "_add_time_str": "2025-12-09 11:17:13",
    response: {
        value: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794c5c485e7227dea4c4f"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-FagucpWGvHPkcT8JZgFROJIVvBc\""
    },
    body: null,
    requestId: "59eb6526-a207-44bc-a7e5-7291b467db4e",
    "_add_time": 1765250245969,
    "_add_time_str": "2025-12-09 11:17:25",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794c9c485e7227dea4c53"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"64-MhJ5THjjwAxeC9T4cuO/0G8Rvmg\""
    },
    body: null,
    requestId: "0261a35f-b676-417a-82da-f16d53749f28",
    "_add_time": 1765250249874,
    "_add_time_str": "2025-12-09 11:17:29",
    response: {
        value: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794d25155af35464554e2"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-zWkuc+5KvPr1StS4eEoKgyd1Kfo\""
    },
    body: null,
    requestId: "48a8e7eb-1bc7-4a73-928a-d5136d980056",
    "_add_time": 1765250258505,
    "_add_time_str": "2025-12-09 11:17:38",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794dd5155af35464554e6"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"64-xDSTU/j+oIO/az1zdm4RccOIB8Q\""
    },
    body: null,
    requestId: "38d8ed75-33a7-4e9b-aebe-08ebd246c190",
    "_add_time": 1765250269158,
    "_add_time_str": "2025-12-09 11:17:49",
    response: {
        value: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794de5155af35464554ea"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-cX3ZSj/SXfx9c/08RtbHHX4mp/s\""
    },
    body: null,
    requestId: "3ddc7d82-1b9b-4ee6-bf1c-e481774cb8a5",
    "_add_time": 1765250270247,
    "_add_time_str": "2025-12-09 11:17:50",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794de5155af35464554ee"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"64-6TDlUi4RC41To+EwNV5mnixA6FI\""
    },
    body: null,
    requestId: "624a0b6f-b7b8-4790-8076-230424d85669",
    "_add_time": 1765250270921,
    "_add_time_str": "2025-12-09 11:17:50",
    response: {
        value: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794f234287c7e014d9bc2"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"64-nVqfsuREe5hsoXqf/Wv83zlrwl8\""
    },
    body: null,
    requestId: "5728d813-4adb-473e-9257-79b6e8d61cae",
    "_add_time": 1765250290638,
    "_add_time_str": "2025-12-09 11:18:10",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794f334287c7e014d9bc6"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-3+0PjcFb/eMvfR62QjWj+kXcj08\""
    },
    body: null,
    requestId: "6e4a3ea6-1c93-4b72-904a-000dad5fd308",
    "_add_time": 1765250291308,
    "_add_time_str": "2025-12-09 11:18:11",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794f434287c7e014d9bca"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-KxWJV9m4yNYTn/cEkfRmV4o2H2o\""
    },
    body: null,
    requestId: "dd1c134a-d14b-40f3-9a4f-30429ef63b94",
    "_add_time": 1765250292037,
    "_add_time_str": "2025-12-09 11:18:12",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794f434287c7e014d9bce"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-kq2ott8C7tj938BghtnCEU3FqnY\""
    },
    body: null,
    requestId: "11613cab-d3c6-4c32-b6e7-fcc02b0b1771",
    "_add_time": 1765250292538,
    "_add_time_str": "2025-12-09 11:18:12",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693794f534287c7e014d9bd2"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-fflgSmhXV8P0wzbPMlCOYxGthRk\""
    },
    body: null,
    requestId: "fbc35607-b4b4-4edc-8533-e43afa6996f6",
    "_add_time": 1765250293234,
    "_add_time_str": "2025-12-09 11:18:13",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379509019667f7fd0b68d0"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-62fvg1cRl//0GQ1VZ/2jSHcmuHw\""
    },
    body: null,
    requestId: "9ecdbe7f-728c-4f40-a515-7e0c82368373",
    "_add_time": 1765250313630,
    "_add_time_str": "2025-12-09 11:18:33",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937950b019667f7fd0b68d4"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-VSUlrNLnp0K7ZbRsZATeIOYHh0s\""
    },
    body: null,
    requestId: "805728e7-2121-47dc-934e-9a08e1b255e2",
    "_add_time": 1765250315268,
    "_add_time_str": "2025-12-09 11:18:35",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379529019667f7fd0b68d8"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-G059pAm3CRC9jTsuCtfgP6cAa4g\""
    },
    body: null,
    requestId: "3d48ad14-eca8-4310-bdf1-0faf5353f41a",
    "_add_time": 1765250345060,
    "_add_time_str": "2025-12-09 11:19:05",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693795388c99172e6a0c5763"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-bc5NhANZpINPAZ4vlgLN4S0q6+U\""
    },
    body: null,
    requestId: "9ace2fea-7517-4d38-a39b-6c8b0223e013",
    "_add_time": 1765250360871,
    "_add_time_str": "2025-12-09 11:19:20",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937953a8c99172e6a0c5767"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-63yF+9hosNodp+A9WnhBIYyBeEM\""
    },
    body: null,
    requestId: "596a9900-f3c0-48d3-972b-47504bfbebe7",
    "_add_time": 1765250362841,
    "_add_time_str": "2025-12-09 11:19:22",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937956477730a14b525adcd"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-bJzlCvB2lFR4o3zk/P2F9uf7xJM\""
    },
    body: null,
    requestId: "296fb402-6be8-4472-9ee6-4ae037ec037b",
    "_add_time": 1765250404990,
    "_add_time_str": "2025-12-09 11:20:04",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937956b77730a14b525add1"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-GntQ0D1sq9EW/01LJOVlErqt25M\""
    },
    body: null,
    requestId: "39e78a7a-dfb1-48af-91ab-8ee777ae00be",
    "_add_time": 1765250411306,
    "_add_time_str": "2025-12-09 11:20:11",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937968cc8cd605834406875"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-N3VssqdFlJHuNMKA5kSsBDdCIEs\""
    },
    body: null,
    requestId: "37eb7ab9-ba63-4484-a8f5-8bf8d4b9270d",
    "_add_time": 1765250700436,
    "_add_time_str": "2025-12-09 11:25:00",
    response: "redi set success!"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379697fbec58f47bf7884f"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6c-S+VLvOC9PL3OUy4KXMzmFAOfxj4\""
    },
    body: null,
    requestId: "f36fe54b-37f3-4cc3-8725-cfdf94056bdc",
    "_add_time": 1765250711466,
    "_add_time_str": "2025-12-09 11:25:11",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379698fbec58f47bf78853"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-Gmo6OBWxAN+sf6AJFcBfQ7Yx43E\""
    },
    body: null,
    requestId: "364964af-2469-4280-9fc3-769595b3593d",
    "_add_time": 1765250712572,
    "_add_time_str": "2025-12-09 11:25:12",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693796d3fbec58f47bf78857"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-XbPeI4anPhIbkpAzIsySIMaXUmI\""
    },
    body: null,
    requestId: "97b29729-3bc0-4747-8199-2792aaf08a6d",
    "_add_time": 1765250771782,
    "_add_time_str": "2025-12-09 11:26:11",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379710fbec58f47bf7885b"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-lKprUNABUoA6PbVphKa2jl4tJVc\""
    },
    body: null,
    requestId: "6d7360ab-09dc-45d7-a194-bcc15d42862b",
    "_add_time": 1765250832866,
    "_add_time_str": "2025-12-09 11:27:12",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693797342ee175b947345921"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-Fhs8A4vfYJ1u+j/a5GXkCdn/IKE\""
    },
    body: null,
    requestId: "83f798f9-1736-42ac-88cd-63fa2b42b3aa",
    "_add_time": 1765250868828,
    "_add_time_str": "2025-12-09 11:27:48",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693797362ee175b947345925"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-y6xIG7i7nf0zFwOz6gaxZERq7oQ\""
    },
    body: null,
    requestId: "2fea78ce-92ae-4e03-8ee5-6685fba834b7",
    "_add_time": 1765250870174,
    "_add_time_str": "2025-12-09 11:27:50",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693797362ee175b947345929"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-asuQ4KkNxMWVz6PpWaCtkuQCUrQ\""
    },
    body: null,
    requestId: "40bcd135-64e4-4ec8-9552-fb01a39bc196",
    "_add_time": 1765250870694,
    "_add_time_str": "2025-12-09 11:27:50",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937973f0f71469ea8af3cc6"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-7v6ZIxa/mAmJNOewSRhAzq1/r0w\""
    },
    body: null,
    requestId: "bd0c43c0-1848-4626-91ab-667dc8446b3d",
    "_add_time": 1765250879905,
    "_add_time_str": "2025-12-09 11:27:59",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937975cf51285f0c30e4576"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-tN7WKxJrv+fmYrCauIm8FANLb+4\""
    },
    body: null,
    requestId: "0476baf9-d1a3-44c2-b8a8-91b4c51b2534",
    "_add_time": 1765250908226,
    "_add_time_str": "2025-12-09 11:28:28",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937975df51285f0c30e457a"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-Oge8qEnqKETT3bD7ED784eSMIRo\""
    },
    body: null,
    requestId: "9d5e4e2f-4725-4817-a399-2cebabfcd1c7",
    "_add_time": 1765250909016,
    "_add_time_str": "2025-12-09 11:28:29",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937975df51285f0c30e457e"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-QekqGC+R8CDIFb+2MYo8pjNoE+c\""
    },
    body: null,
    requestId: "7fdaf8d6-de1e-48f8-9f0b-792b86070dec",
    "_add_time": 1765250909533,
    "_add_time_str": "2025-12-09 11:28:29",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379773e5026fb8a597be08"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-7wyKtnckgfbxGcaNCssaZU1M6Lo\""
    },
    body: null,
    requestId: "03072b23-8256-475c-8daf-006c278fe28e",
    "_add_time": 1765250931725,
    "_add_time_str": "2025-12-09 11:28:51",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693797f59f7a055840b310eb"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-/m3Sj8XCXASCVsdK/Q4KhTnPJvY\""
    },
    body: null,
    requestId: "2d87e626-fa50-4d23-ac0f-df882310b1a5",
    "_add_time": 1765251061554,
    "_add_time_str": "2025-12-09 11:31:01",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937995d6e89f9f8fdd960ea"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-J/BLtVuoh8Uc1NwPxSx+KhYvNjA\""
    },
    body: null,
    requestId: "caed3f4f-6089-4c48-914d-bb2f02155262",
    "_add_time": 1765251421119,
    "_add_time_str": "2025-12-09 11:37:01",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693799a66e89f9f8fdd960ee"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-23g+Udg7LW36/MyWiLAde4g6RYY\""
    },
    body: null,
    requestId: "160daedc-cec8-4dfc-b913-6bc6a72e0c65",
    "_add_time": 1765251494817,
    "_add_time_str": "2025-12-09 11:38:14",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693799ab6e89f9f8fdd960f2"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-xUeGdycKtR4UEZIQM900hL2gQKU\""
    },
    body: null,
    requestId: "01269323-1a52-4eb2-9cc6-d7cdb6a3203f",
    "_add_time": 1765251499054,
    "_add_time_str": "2025-12-09 11:38:19",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693799ab6e89f9f8fdd960f6"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-Odw3JTOrF128nRnOXmSr86uyXz8\""
    },
    body: null,
    requestId: "d9433fba-04e9-4f0e-a525-7a880766b732",
    "_add_time": 1765251499926,
    "_add_time_str": "2025-12-09 11:38:19",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693799b56e89f9f8fdd960fa"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-hZhm+/ezI/oxSgdGQcm+J6fasaY\""
    },
    body: null,
    requestId: "536ae388-aca8-4ddf-bb54-588635d88888",
    "_add_time": 1765251509644,
    "_add_time_str": "2025-12-09 11:38:29",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379a4afc6d57a8b9359229"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-TSG2pNq/fnAZevYmhun6elw5kmA\""
    },
    body: null,
    requestId: "733c9fd8-f408-41a1-874b-67a0a09995ed",
    "_add_time": 1765251658120,
    "_add_time_str": "2025-12-09 11:40:58",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379afd6af8fe86ef405bb4"),
    url: "/getCacheStats",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "c6557146-536e-4575-8d71-99e66ad3903b",
    "_add_time": 1765251837887,
    "_add_time_str": "2025-12-09 11:43:57",
    response: {
        type: null,
        time: "2025-12-09T03:43:57.899Z"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379b166af8fe86ef405bb8"),
    url: "/getCacheStats",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"7c-sTxAzT0ZRUEA3hR2pKicnrkWBx4\""
    },
    body: null,
    requestId: "6e68afaf-1bc7-4d33-8165-522753332bfd",
    "_add_time": 1765251862802,
    "_add_time_str": "2025-12-09 11:44:22",
    response: {
        type: null,
        time: "2025-12-09T03:44:22.804Z"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379b176af8fe86ef405bbc"),
    url: "/getCacheStats",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"7c-nqNPi0ZWH0PD4w8B6AFwxrd+fGg\""
    },
    body: null,
    requestId: "546b6326-9705-44f9-8bf2-5fb26f22c24e",
    "_add_time": 1765251863017,
    "_add_time_str": "2025-12-09 11:44:23",
    response: {
        type: null,
        time: "2025-12-09T03:44:23.018Z"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379b2c6af8fe86ef405bc0"),
    url: "/getCacheStats",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"7c-iPl7flZTg/c+P5W1GhljaQcm2C0\""
    },
    body: null,
    requestId: "2fba48c2-5726-4dd3-af9c-dfb286999d24",
    "_add_time": 1765251884098,
    "_add_time_str": "2025-12-09 11:44:44",
    response: {
        type: null,
        time: "2025-12-09T03:44:44.100Z"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379befdabd3359f4437611"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-bxNkzGf7ABnj/93s1yFm9ypDwrI\""
    },
    body: null,
    requestId: "af4254ec-cc9e-42e7-8ea4-9cb573b83b86",
    "_add_time": 1765252079202,
    "_add_time_str": "2025-12-09 11:47:59",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379c2506ac059e23f710e7"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-oH4QOlwbVbUSXcghH5lEKiohnNg\""
    },
    body: null,
    requestId: "0f79942d-5fba-4aa8-966e-722634c97aa1",
    "_add_time": 1765252133971,
    "_add_time_str": "2025-12-09 11:48:53",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379c2e06ac059e23f710eb"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-nLPCux5Q/3RvYYh6Z0MNQGHqyx8\""
    },
    body: null,
    requestId: "c8e51d85-374a-40bb-b699-fe5f2c920ef8",
    "_add_time": 1765252142325,
    "_add_time_str": "2025-12-09 11:49:02",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379c3206ac059e23f710ef"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-qzwyatfP/5RLoZNXVZhwMdDxAbw\""
    },
    body: null,
    requestId: "ef0bbaf8-2aa4-460c-a856-93509378db6f",
    "_add_time": 1765252146901,
    "_add_time_str": "2025-12-09 11:49:06",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379c3f1b3dbfb70715deb9"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-27vDDyO+q36bGjcsH513EyHLCII\""
    },
    body: null,
    requestId: "0ba174df-c1b1-4e3d-a606-75ed1fe7d405",
    "_add_time": 1765252159330,
    "_add_time_str": "2025-12-09 11:49:19",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379c401b3dbfb70715debd"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-JId69JC5loWkB6UDV0iw0tUil7U\""
    },
    body: null,
    requestId: "aa79cb00-c4c0-426d-ad6f-a1d3f424569e",
    "_add_time": 1765252160424,
    "_add_time_str": "2025-12-09 11:49:20",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379c791b3dbfb70715dec1"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-kVf7GQsU5exdBff+lGfG5d6wul8\""
    },
    body: null,
    requestId: "4a6beefe-1587-4901-a8aa-9d654be030d9",
    "_add_time": 1765252217412,
    "_add_time_str": "2025-12-09 11:50:17",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379c7a1b3dbfb70715dec5"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-Oq1Y/uBjljxsh3Y2fm2g2nGoglY\""
    },
    body: null,
    requestId: "686ea49e-b64b-4344-826b-2a61f69590a5",
    "_add_time": 1765252218023,
    "_add_time_str": "2025-12-09 11:50:18",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d48ec9ad2f6951532ae"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-O5DeJ1iKVfdtQ49fFL0yFB4JxDM\""
    },
    body: null,
    requestId: "d1df88ee-6d71-4ec2-a96a-fba5aad89df6",
    "_add_time": 1765252424916,
    "_add_time_str": "2025-12-09 11:53:44",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d49ec9ad2f6951532b2"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-MlUVq/6THpol5AlnpyvDRpnTMFo\""
    },
    body: null,
    requestId: "ca8f0451-b8d3-4684-a991-57c21de7924e",
    "_add_time": 1765252425450,
    "_add_time_str": "2025-12-09 11:53:45",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d49ec9ad2f6951532b6"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-rg6/H6EOcBq7cofORVqNdJdQxfA\""
    },
    body: null,
    requestId: "f65d36cb-a6b6-4e90-8e4d-72cbf6feaa00",
    "_add_time": 1765252425638,
    "_add_time_str": "2025-12-09 11:53:45",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d4dec9ad2f6951532ba"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-vxRH8+6UJVBSecoBchje4F2CzzM\""
    },
    body: null,
    requestId: "3d86de6f-852e-42f4-9ac1-e4beceeab9fd",
    "_add_time": 1765252429266,
    "_add_time_str": "2025-12-09 11:53:49",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d50ec9ad2f6951532be"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-FzNTvwOkvyuN+AXmTKeIeaShiUA\""
    },
    body: null,
    requestId: "39a7cc53-a7f7-4dce-86fd-86c19df60428",
    "_add_time": 1765252432257,
    "_add_time_str": "2025-12-09 11:53:52",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d51ec9ad2f6951532c2"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-Z5BUzqHTkQUfy4P09u8zv4jr9hg\""
    },
    body: null,
    requestId: "9bb7fe73-4cda-422e-b4f0-0e43314c7b34",
    "_add_time": 1765252433020,
    "_add_time_str": "2025-12-09 11:53:53",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d9ac4da9f73fb82556a"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-aRQcVv+EhAdBfggzN+vkeSeltOw\""
    },
    body: null,
    requestId: "f97a6e6c-994b-4975-8b9c-a5d1746cb3b8",
    "_add_time": 1765252506731,
    "_add_time_str": "2025-12-09 11:55:06",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d9bc4da9f73fb82556e"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-mvOfL/X9zkSG2aGDyDa/seqUEZY\""
    },
    body: null,
    requestId: "b9983237-98b9-4833-b595-5d803d911f1a",
    "_add_time": 1765252507333,
    "_add_time_str": "2025-12-09 11:55:07",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379d9bc4da9f73fb825572"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-X60/zrRYak3b9s42v+ekuIErmNY\""
    },
    body: null,
    requestId: "58e47d45-9b31-4344-9cf7-40d84f2a30d9",
    "_add_time": 1765252507836,
    "_add_time_str": "2025-12-09 11:55:07",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379dccfac1f7ea4e5adc5c"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-5JROlWlOujMnbeVomt14l69JOvM\""
    },
    body: null,
    requestId: "74ce7d28-c9cd-4acc-b3a5-8b559338ee2c",
    "_add_time": 1765252556177,
    "_add_time_str": "2025-12-09 11:55:56",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379dccfac1f7ea4e5adc60"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-yFCsqMbQ+1mX4X8x6mC/kLtOtUg\""
    },
    body: null,
    requestId: "2ecf98a6-690d-495a-a2b1-1c2e1096889d",
    "_add_time": 1765252556731,
    "_add_time_str": "2025-12-09 11:55:56",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379dcdfac1f7ea4e5adc64"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-T3zFcfx1kb/LwkivybNth2iVWL4\""
    },
    body: null,
    requestId: "2dd6385e-d7b3-47ee-b2d7-3afb93d02627",
    "_add_time": 1765252557182,
    "_add_time_str": "2025-12-09 11:55:57",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379e7da7ff693be50d7b91"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-5qu64ui2FgKbMkE+HWFQgbYVLVc\""
    },
    body: null,
    requestId: "95ae2f99-7b94-4a13-8b19-e384418fd9bb",
    "_add_time": 1765252733515,
    "_add_time_str": "2025-12-09 11:58:53",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379e7ea7ff693be50d7b95"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-b1hEaV43IJjqrr3YDoLAZYJyFpg\""
    },
    body: null,
    requestId: "8f99fec4-4c98-4355-93ac-88781f7fc289",
    "_add_time": 1765252734007,
    "_add_time_str": "2025-12-09 11:58:54",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379e7ea7ff693be50d7b99"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-h4lwbviJwLMyfc0BeOJbgiHO0Ys\""
    },
    body: null,
    requestId: "7aef8b9f-194b-4eba-bd42-9428fae00d47",
    "_add_time": 1765252734748,
    "_add_time_str": "2025-12-09 11:58:54",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379e92d4c17dddfd4013e3"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-yCfSyabr84D5ODHoq4ISr6Vk6vE\""
    },
    body: null,
    requestId: "93b56db8-4f8e-49e0-8c4e-550c5fd06949",
    "_add_time": 1765252754032,
    "_add_time_str": "2025-12-09 11:59:14",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379e93d4c17dddfd4013e7"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-LadI9ZfQ4LgtqDWC4E6mubsRGvk\""
    },
    body: null,
    requestId: "8078ed28-8b61-4949-be7a-ec6b9812bfe6",
    "_add_time": 1765252755244,
    "_add_time_str": "2025-12-09 11:59:15",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379e93d4c17dddfd4013eb"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-y6DPNnfvMGfH5UGGTg1pPIfp5eQ\""
    },
    body: null,
    requestId: "f78373c9-d18c-46eb-b63f-5a274e2ff482",
    "_add_time": 1765252755621,
    "_add_time_str": "2025-12-09 11:59:15",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379ed88c8d9644c3f98841"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("0"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-opLkEQCVEnzL1krldAugAE2yDro\""
    },
    body: null,
    requestId: "71822862-f561-484f-8824-699782fe10f0",
    "_add_time": 1765252824765,
    "_add_time_str": "2025-12-09 12:00:24",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379ed88c8d9644c3f98843"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-BJfwBDU4xZZ5VpLPXYoSm9v/g/4\""
    },
    body: null,
    requestId: "8068ac77-7e6c-4f13-8fca-a54882263bf9",
    "_add_time": 1765252824781,
    "_add_time_str": "2025-12-09 12:00:24",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379ed88c8d9644c3f98845"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "b4823f01-9416-4010-a27e-86b2dda1eb28",
    "_add_time": 1765252824782,
    "_add_time_str": "2025-12-09 12:00:24",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69379eda8c8d9644c3f9884c"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-Fv/NUwZPPvnTdw+qs4MTO+/3RBU\""
    },
    body: null,
    requestId: "c3607054-e559-4e07-96f1-7d64d16a7ed9",
    "_add_time": 1765252826320,
    "_add_time_str": "2025-12-09 12:00:26",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a1772a268adf365ac338"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-Z6ufxEg7aGFfK8EFWVTPhd4mVm0\""
    },
    body: null,
    requestId: "cba73569-09b7-407d-ba8a-3a295375684e",
    "_add_time": 1765253495816,
    "_add_time_str": "2025-12-09 12:11:35",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a188e1443acfaad1c319"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-0eG35r/N9G/gVZaZlZpT9cq4ZzQ\""
    },
    body: null,
    requestId: "2a3c2611-3d87-4eec-9d5c-6a973c2bcb7a",
    "_add_time": 1765253512014,
    "_add_time_str": "2025-12-09 12:11:52",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a195e1443acfaad1c31d"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-zsl9XBAyS4dH0caVRPe4Q78/r5w\""
    },
    body: null,
    requestId: "5aa02a66-c7ab-4ec5-8a53-040ec460cddb",
    "_add_time": 1765253525085,
    "_add_time_str": "2025-12-09 12:12:05",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a195e1443acfaad1c321"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-GY/QApcXET8VPWuJZSIgEo6lFKw\""
    },
    body: null,
    requestId: "3fbba29d-997d-4d02-aa59-dec8fc8c2871",
    "_add_time": 1765253525302,
    "_add_time_str": "2025-12-09 12:12:05",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a195e1443acfaad1c325"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-E3oRcw0rfN4Oa99vcsS2FCRRbS8\""
    },
    body: null,
    requestId: "a0939c92-3129-49c8-8300-090b1aec5dd0",
    "_add_time": 1765253525503,
    "_add_time_str": "2025-12-09 12:12:05",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a195e1443acfaad1c329"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-xFz61LuMLELjgmi/m0h7NS7b1WU\""
    },
    body: null,
    requestId: "2616e8ad-51f0-4f0f-adab-003c8f1ef3c3",
    "_add_time": 1765253525660,
    "_add_time_str": "2025-12-09 12:12:05",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a195e1443acfaad1c32d"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-061C87/7BH4Df0bN3COt1kDvMMk\""
    },
    body: null,
    requestId: "1cfbeafc-b0d7-449c-b82d-764089382eca",
    "_add_time": 1765253525815,
    "_add_time_str": "2025-12-09 12:12:05",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a195e1443acfaad1c331"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-lraygT3wNgq7F95eRQYPHcmalZY\""
    },
    body: null,
    requestId: "6875d86c-36ed-447b-b3b6-e04e9aac2445",
    "_add_time": 1765253525942,
    "_add_time_str": "2025-12-09 12:12:05",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6937a384de11b645605856ef"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-McT7YkbOWDlPcnm3/DAPpzt2KtA\""
    },
    body: null,
    requestId: "4864e1d2-1d95-43f6-aa86-5580a06b1939",
    "_add_time": 1765254020787,
    "_add_time_str": "2025-12-09 12:20:20",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b94588a0996dd2e148b85"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "eca6d90b-c57e-4d15-befb-c7c3a3aec4d7",
    "_add_time": 1765512280175,
    "_add_time_str": "2025-12-12 12:04:40",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b945a8a0996dd2e148b89"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "a905b81b-f1aa-410f-ae27-4f2cf7dec1d6",
    "_add_time": 1765512282713,
    "_add_time_str": "2025-12-12 12:04:42",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9475739f7012337fc729"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-Ja0U6JI8+O7Nslz8nXU9C/GQ3YY\""
    },
    body: null,
    requestId: "efc263d0-3675-4945-959b-27d41c77cffe",
    "_add_time": 1765512309729,
    "_add_time_str": "2025-12-12 12:05:09",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9477739f7012337fc72d"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-Hrm3leHRjme3x/J/xviCUvQ09oE\""
    },
    body: null,
    requestId: "f455fd01-3c76-445c-ba0d-7e7bb27b01ca",
    "_add_time": 1765512311694,
    "_add_time_str": "2025-12-12 12:05:11",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9479739f7012337fc731"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-sVAHYHCyPSnIUxhwzu13IL9OFg0\""
    },
    body: null,
    requestId: "fb4e316d-6abe-4e73-b499-4166a29140d3",
    "_add_time": 1765512313884,
    "_add_time_str": "2025-12-12 12:05:13",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b947f739f7012337fc735"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-72DndYGXMdekDY9h/gvcL8HlpJM\""
    },
    body: null,
    requestId: "f8c960b7-ab97-4b21-9e74-71fb050d2270",
    "_add_time": 1765512319101,
    "_add_time_str": "2025-12-12 12:05:19",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95642f8b45bed3325342"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-KuT9L2EOvUHfVZ7SaM0T8mLorzU\""
    },
    body: null,
    requestId: "da1e7a9e-e216-46df-96ea-67be548f4ef9",
    "_add_time": 1765512548466,
    "_add_time_str": "2025-12-12 12:09:08",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95790402999071238839"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-yyDF7u74tr9L4ow6xGFwFwGpYpY\""
    },
    body: null,
    requestId: "563a77ca-ee7b-434e-98db-0b99f3a285f5",
    "_add_time": 1765512569254,
    "_add_time_str": "2025-12-12 12:09:29",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9591040299907123883d"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-xaweNzQXsl5WCaAAbEqbxNLQiD4\""
    },
    body: null,
    requestId: "5dab0ab0-130f-4d08-b046-10febb04ac42",
    "_add_time": 1765512593856,
    "_add_time_str": "2025-12-12 12:09:53",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95960402999071238841"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-+sg/1/genXkOOLpzrYEe6mut0vQ\""
    },
    body: null,
    requestId: "1c4795a6-add0-4d67-b052-a85b877a083c",
    "_add_time": 1765512598182,
    "_add_time_str": "2025-12-12 12:09:58",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b959e81fcaf3a1f052887"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-Fl95SdRuk1uqMqrUi6wjvoWFNQo\""
    },
    body: null,
    requestId: "b0682167-a69a-4016-bca0-32162d4bf729",
    "_add_time": 1765512606716,
    "_add_time_str": "2025-12-12 12:10:06",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95a281fcaf3a1f05288b"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-vOrqc4RTZcZNcYJac+y5omEFA0c\""
    },
    body: null,
    requestId: "731ffece-9dca-44f8-b5ae-7e669d21c6e1",
    "_add_time": 1765512610432,
    "_add_time_str": "2025-12-12 12:10:10",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95a381fcaf3a1f05288f"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-Klkv6R6mmXji0DZwOPgcaXpjHCA\""
    },
    body: null,
    requestId: "75ebcf71-37a1-4cc5-85a7-ba03baa7e75b",
    "_add_time": 1765512611606,
    "_add_time_str": "2025-12-12 12:10:11",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95bebb2ab7ef121beb29"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "c0498d79-768c-4f95-a742-e71a04ec87bd",
    "_add_time": 1765512638330,
    "_add_time_str": "2025-12-12 12:10:38",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95bfbb2ab7ef121beb2d"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-hhTCZQj2jp8IL8HvEoCSvuGtYH0\""
    },
    body: null,
    requestId: "6287452e-34df-4528-94f8-a2e4ae4ce1a9",
    "_add_time": 1765512639453,
    "_add_time_str": "2025-12-12 12:10:39",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95d5ae1e9e7c3ae15424"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-5CjUuh4UYyejbxcWE8ePVi1YsXA\""
    },
    body: null,
    requestId: "dc2833ad-0296-4e1a-96e4-9b2d671e69d8",
    "_add_time": 1765512661980,
    "_add_time_str": "2025-12-12 12:11:01",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95d6ae1e9e7c3ae15428"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-PcutCQ/QG+HAoewCRqU+h0H8BAM\""
    },
    body: null,
    requestId: "bc4598ab-2c17-4f40-a43c-374b2e3bbd44",
    "_add_time": 1765512662555,
    "_add_time_str": "2025-12-12 12:11:02",
    response: {
        value: NumberInt("10086")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95fe7b1e343aaa179fcf"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"68-L/LyFWlx8oaMqeTNN2yLCJt8lcI\""
    },
    body: null,
    requestId: "7109d978-5331-4ae8-86e6-94f05c5d30ca",
    "_add_time": 1765512702160,
    "_add_time_str": "2025-12-12 12:11:42",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95fe7b1e343aaa179fd3"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-78B8kwEInRhUcdrelroAYbwsLwo\""
    },
    body: null,
    requestId: "2437d1e3-32de-4e9d-9668-e2380893a689",
    "_add_time": 1765512702372,
    "_add_time_str": "2025-12-12 12:11:42",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b95fe7b1e343aaa179fd7"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-fOCg9QHbClYzVOoRTy3rJMvFWGA\""
    },
    body: null,
    requestId: "0f8b357a-b25f-4595-ace9-9d76f4af9026",
    "_add_time": 1765512702551,
    "_add_time_str": "2025-12-12 12:11:42",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b960f7b1e343aaa179fdb"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-FuRe3MfB7FT+2Sewmx/C5WlSO/s\""
    },
    body: null,
    requestId: "f4fe1a0f-7fb4-49d8-9b53-c7be98f297af",
    "_add_time": 1765512719388,
    "_add_time_str": "2025-12-12 12:11:59",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96107b1e343aaa179fdf"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-wJs0szoWTfuxZGQ2AHH9WlUQ3vI\""
    },
    body: null,
    requestId: "ad961b25-6f9b-47a8-a1bd-9c95793b9898",
    "_add_time": 1765512720398,
    "_add_time_str": "2025-12-12 12:12:00",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b961b7b1e343aaa179fe3"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-PxMJxdVixEQgYUh1tVfbzUpSuQI\""
    },
    body: null,
    requestId: "6a1e478f-5dc3-4b01-8f78-d9d833872a09",
    "_add_time": 1765512731430,
    "_add_time_str": "2025-12-12 12:12:11",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b961d7b1e343aaa179fe7"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-9OLZoyLaKWTUF3fgA+4Tkogqmtg\""
    },
    body: null,
    requestId: "b532a202-2290-4e6b-a05a-2cebae46fd91",
    "_add_time": 1765512733886,
    "_add_time_str": "2025-12-12 12:12:13",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96207b1e343aaa179feb"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-D/M92TZC3xzwMcKCb4F0nPLyTgk\""
    },
    body: null,
    requestId: "35572853-c7ad-4528-b370-777dc28d45ba",
    "_add_time": 1765512736234,
    "_add_time_str": "2025-12-12 12:12:16",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b962b9d2fd7a7cd55d040"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-F6kyvriZzrSSCHrlzZNQ3f+0WUQ\""
    },
    body: null,
    requestId: "3523e38a-6cd0-40c5-8dc8-991b9408aa26",
    "_add_time": 1765512747498,
    "_add_time_str": "2025-12-12 12:12:27",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96309d2fd7a7cd55d044"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-XceOx/m5pxvGuzMawb+ZuE9ys2o\""
    },
    body: null,
    requestId: "e8fc0e54-2ea0-47ce-a881-31ff8e67f193",
    "_add_time": 1765512752752,
    "_add_time_str": "2025-12-12 12:12:32",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9644d02f19fa449886f1"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-eNYxw8oYALBKzPLLMyQOCjZPwnA\""
    },
    body: null,
    requestId: "c6d8647e-ef1f-4e2c-8200-f94354a28eed",
    "_add_time": 1765512772667,
    "_add_time_str": "2025-12-12 12:12:52",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9648d02f19fa449886f5"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-oagAvsm0bMU6yeXtszmnAfvaUkg\""
    },
    body: null,
    requestId: "535d828e-31bf-406d-b912-736285e458c0",
    "_add_time": 1765512776117,
    "_add_time_str": "2025-12-12 12:12:56",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9649d02f19fa449886f9"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-7ITudVzyRQL/QRwDbpiLqJhRNr0\""
    },
    body: null,
    requestId: "9aaf52e3-60c7-4c60-81f4-99bb62cbc877",
    "_add_time": 1765512777053,
    "_add_time_str": "2025-12-12 12:12:57",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9649d02f19fa449886fd"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-oMFv0rToDN6MewvLPx5CKNK6iG4\""
    },
    body: null,
    requestId: "ae89e969-452a-47f2-bdd9-683b49e3d2ed",
    "_add_time": 1765512777344,
    "_add_time_str": "2025-12-12 12:12:57",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9652d02f19fa44988701"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-DWWFGh083KILhPh13VuO+i8+4ok\""
    },
    body: null,
    requestId: "c625387b-76ea-4fe8-b1d8-883700f75433",
    "_add_time": 1765512785999,
    "_add_time_str": "2025-12-12 12:13:05",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9653d02f19fa44988705"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-s3GpWg07vUctQispNqPx66oPYOk\""
    },
    body: null,
    requestId: "f9eacb20-f99c-4c95-882f-d8f3fbe0dec1",
    "_add_time": 1765512787500,
    "_add_time_str": "2025-12-12 12:13:07",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b967dd52d20b2105e32e2"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-IcJmHKD9es+bVnbDfMdJ9rFyaBE\""
    },
    body: null,
    requestId: "01a6df9d-7005-439b-9ebb-0a8d912ca0d3",
    "_add_time": 1765512829049,
    "_add_time_str": "2025-12-12 12:13:49",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9685d52d20b2105e32e6"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-+DH2Qv886RKjY0Tentd3b60+SdM\""
    },
    body: null,
    requestId: "095fd429-ae9a-4ecc-903b-15ba54356027",
    "_add_time": 1765512837184,
    "_add_time_str": "2025-12-12 12:13:57",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b9686d52d20b2105e32ea"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-iPt5o+kbeRb+TpmhUDBIoy5r0lQ\""
    },
    body: null,
    requestId: "3042af3a-794c-48a5-a361-4dffac10bcdd",
    "_add_time": 1765512838476,
    "_add_time_str": "2025-12-12 12:13:58",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b968d43fb24f8a324dd10"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-eXtM3r9Q32xxJ9Hdr6vS6+yP3p8\""
    },
    body: null,
    requestId: "303316ad-1944-4b40-909e-9bc1b57137a4",
    "_add_time": 1765512845978,
    "_add_time_str": "2025-12-12 12:14:05",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b968f43fb24f8a324dd14"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-MyHC+TNP4reTJtFe+qMYlH8718g\""
    },
    body: null,
    requestId: "532bf2b4-07ad-4962-add5-e675281d8ff9",
    "_add_time": 1765512847928,
    "_add_time_str": "2025-12-12 12:14:07",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b969043fb24f8a324dd18"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-q5nZ/oMZevFU8/BxkGfVdw0NBqg\""
    },
    body: null,
    requestId: "d0b70984-b3f2-4196-af2f-23dda0dfaabc",
    "_add_time": 1765512848940,
    "_add_time_str": "2025-12-12 12:14:08",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b969743fb24f8a324dd1c"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-tNwzl9WaxqJznCKVKrGJjdM+/W0\""
    },
    body: null,
    requestId: "19c010ee-7fdc-4bf0-bbe3-3f2b3cf6a657",
    "_add_time": 1765512855253,
    "_add_time_str": "2025-12-12 12:14:15",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96b5593faabd74076b00"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-P4hbTf1cHaUc5Q4znVsGMcALtnU\""
    },
    body: null,
    requestId: "9ef1507f-7d14-40f4-b050-00e843528dd9",
    "_add_time": 1765512885836,
    "_add_time_str": "2025-12-12 12:14:45",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96b7593faabd74076b04"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-p8pMU+uxKlaM8gOIOd8jCD+dKKg\""
    },
    body: null,
    requestId: "a9149f14-e472-4b7e-a965-e8e1d850fac4",
    "_add_time": 1765512887153,
    "_add_time_str": "2025-12-12 12:14:47",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96b8593faabd74076b08"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-6E4JKP3fIfW0PLbZDcEnhVNdHzY\""
    },
    body: null,
    requestId: "c8247650-de2e-4bdf-9e4a-d720b7652b69",
    "_add_time": 1765512888147,
    "_add_time_str": "2025-12-12 12:14:48",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96d49de6391e65391b37"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-FXAJtbDj+GptmHBwnGvSd+CDsXU\""
    },
    body: null,
    requestId: "0bd7024a-d18b-4efc-965d-20187a765444",
    "_add_time": 1765512916865,
    "_add_time_str": "2025-12-12 12:15:16",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96e34bcfe82e0d327410"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-ysPJ4nMJ77MeJI4LcdzIuLCc2BM\""
    },
    body: null,
    requestId: "56533ec8-f33f-4d65-be45-85f7d00b6cd8",
    "_add_time": 1765512931370,
    "_add_time_str": "2025-12-12 12:15:31",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b96ed30b688853ce3c849"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-s1cnGSailJ+U/IshiUvPIIpwzUA\""
    },
    body: null,
    requestId: "50d6a529-aae7-49df-8889-473c923eeaf3",
    "_add_time": 1765512941467,
    "_add_time_str": "2025-12-12 12:15:41",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b97191359068f342070b7"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-M+hGNK4Tk6+LqtxLTj9x4twIyRA\""
    },
    body: null,
    requestId: "1fe188bf-9857-4221-99e5-b02d32c3f242",
    "_add_time": 1765512985296,
    "_add_time_str": "2025-12-12 12:16:25",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b97191359068f342070bb"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-ie6kxAUf4bHnG0Nbb5j0+qCGwms\""
    },
    body: null,
    requestId: "878c1177-a61b-409f-a88e-39acda5e87fa",
    "_add_time": 1765512985554,
    "_add_time_str": "2025-12-12 12:16:25",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b971a1359068f342070bf"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-b87aCyRADv6mcOKDZdZz8N34N7Y\""
    },
    body: null,
    requestId: "cfadd9d5-8f6b-444a-8c2b-f83bf5cee6c1",
    "_add_time": 1765512986169,
    "_add_time_str": "2025-12-12 12:16:26",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693b971f1359068f342070c3"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-Rg92LGsC30p6J8LYCQ6vgWWUwuk\""
    },
    body: null,
    requestId: "a65c2a95-a8d9-4c3f-b985-0d552c89ae79",
    "_add_time": 1765512991873,
    "_add_time_str": "2025-12-12 12:16:31",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba54ec058901d5241f177"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-bH8hUajWyJZYalk2WhAvY5HO8KU\""
    },
    body: null,
    requestId: "6fc4c9c0-3fbb-442b-993c-415f501d707f",
    "_add_time": 1765516622307,
    "_add_time_str": "2025-12-12 13:17:02",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba559957c3773a006a771"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-VIcEAfUN2Ecvq3fOkOgTjBumQz0\""
    },
    body: null,
    requestId: "483f9996-30c0-40aa-8baf-f7e456058ae1",
    "_add_time": 1765516633617,
    "_add_time_str": "2025-12-12 13:17:13",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba560957c3773a006a775"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-Uf0s2oPTpvK65FYlHEonPncyKZQ\""
    },
    body: null,
    requestId: "52e315f4-5c09-4d69-a51c-352aae319eec",
    "_add_time": 1765516640124,
    "_add_time_str": "2025-12-12 13:17:20",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba563957c3773a006a779"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-ERcbD/Omea9XLEPoG6ASzr+qBIs\""
    },
    body: null,
    requestId: "0d454e92-9344-4aa5-a526-009430de3b72",
    "_add_time": 1765516643773,
    "_add_time_str": "2025-12-12 13:17:23",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba56e957c3773a006a77d"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-A/fyPZ1XNagOsXSQpNY8oDvYj0g\""
    },
    body: null,
    requestId: "32882bcc-d691-4bce-af41-5ac4976e95c0",
    "_add_time": 1765516654637,
    "_add_time_str": "2025-12-12 13:17:34",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba5cb6c61d89ee776fe2a"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-Gx/k8F8/nXmzsTL97SFClI4Xt94\""
    },
    body: null,
    requestId: "5d598228-b5e5-4392-bd68-d0559fe2cabf",
    "_add_time": 1765516747499,
    "_add_time_str": "2025-12-12 13:19:07",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba5cc6c61d89ee776fe2e"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-E4dUAZFjey/JbGptrURnyqi9uXM\""
    },
    body: null,
    requestId: "21e358ac-8b41-49f8-a97b-bcceb1f9b39a",
    "_add_time": 1765516748127,
    "_add_time_str": "2025-12-12 13:19:08",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba5cf6c61d89ee776fe32"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("0"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-qNTpXAJW124wtmGXyxSjdYmoI2U\""
    },
    body: null,
    requestId: "25e6a5d1-44df-469e-aa3e-8e8d69e7401b",
    "_add_time": 1765516751650,
    "_add_time_str": "2025-12-12 13:19:11"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba62d23d16c1aa481c51d"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-bkl05TJ36kubX12KhqoMiUsJmnE\""
    },
    body: null,
    requestId: "c653f150-a0c3-4e1f-a1ac-91c04b673881",
    "_add_time": 1765516845331,
    "_add_time_str": "2025-12-12 13:20:45",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba63123d16c1aa481c521"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("0"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-qNTpXAJW124wtmGXyxSjdYmoI2U\""
    },
    body: null,
    requestId: "fdbe2048-ef57-444c-b026-c48976899bbf",
    "_add_time": 1765516849855,
    "_add_time_str": "2025-12-12 13:20:49"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba65a9ad2a22db39d59f1"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-qNTpXAJW124wtmGXyxSjdYmoI2U\""
    },
    body: null,
    requestId: "e15c9b03-6470-46be-a08b-cfcf9211fda7",
    "_add_time": 1765516890240,
    "_add_time_str": "2025-12-12 13:21:30",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba65c9ad2a22db39d59f5"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-1yG2xQOH3w7gHJpt4elHhZzNW4s\""
    },
    body: null,
    requestId: "0c3ea3c7-5373-414d-ac8a-702b45af2fb3",
    "_add_time": 1765516892160,
    "_add_time_str": "2025-12-12 13:21:32",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba6609ad2a22db39d59f9"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-yLzqz9+H3m7RSLpMClyoAwiWDBg\""
    },
    body: null,
    requestId: "2914aabc-e1cc-4b87-8d91-af5e29cb6c96",
    "_add_time": 1765516896103,
    "_add_time_str": "2025-12-12 13:21:36",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba6639ad2a22db39d59fd"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("0"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-jU45pQw1zfD8X72eB4C0FzgxeUY\""
    },
    body: null,
    requestId: "e48ad0a8-ca20-4a01-9a37-99ae28592c40",
    "_add_time": 1765516899326,
    "_add_time_str": "2025-12-12 13:21:39"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba86a7ba098ee180ad082"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-jU45pQw1zfD8X72eB4C0FzgxeUY\""
    },
    body: null,
    requestId: "266dcd65-e541-4cfc-8b3b-fbe92a2aa904",
    "_add_time": 1765517418045,
    "_add_time_str": "2025-12-12 13:30:18",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba86c7ba098ee180ad086"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-aTaCsd7xbwwLchgd+pWOXHtgcGg\""
    },
    body: null,
    requestId: "93f0f02d-0201-42be-8632-1edce9204e5a",
    "_add_time": 1765517420978,
    "_add_time_str": "2025-12-12 13:30:20",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba86e7ba098ee180ad08a"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-tH/FMjdFvFcOUCUK22EwrqSyHPU\""
    },
    body: null,
    requestId: "c5d8893e-0677-40b0-bd15-da611ec677cb",
    "_add_time": 1765517422443,
    "_add_time_str": "2025-12-12 13:30:22",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba883ec15d57ba756f140"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-JfDM7HFLkqBmme78LN2tS7O6u78\""
    },
    body: null,
    requestId: "abd42356-5125-4726-a6c1-8278372076dc",
    "_add_time": 1765517443715,
    "_add_time_str": "2025-12-12 13:30:43",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba884ec15d57ba756f144"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-OS/Yczx0kwUKuaOsYsrFtSDrdok\""
    },
    body: null,
    requestId: "30937315-2544-4a2f-a8c0-614061050cab",
    "_add_time": 1765517444942,
    "_add_time_str": "2025-12-12 13:30:44",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba886ec15d57ba756f148"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-qcp1BidngFT/Yxu70NGbvGAn3Oc\""
    },
    body: null,
    requestId: "53fe406d-e263-4988-8ffa-e78507f1a3de",
    "_add_time": 1765517446367,
    "_add_time_str": "2025-12-12 13:30:46",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8949fd049640908b694"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-L3vfnVhSdIdINn0/0WD4sbDLRJo\""
    },
    body: null,
    requestId: "be0ee391-6856-49dc-a7c3-652aba8c9e15",
    "_add_time": 1765517460303,
    "_add_time_str": "2025-12-12 13:31:00",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8989fd049640908b698"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-pvgqz2O0twcq5hwdU9uwunc5dmw\""
    },
    body: null,
    requestId: "9766197f-2a21-44cb-bb87-dffc35444e84",
    "_add_time": 1765517464407,
    "_add_time_str": "2025-12-12 13:31:04",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba89a9fd049640908b69c"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-dLh1v8Hi5rOdve7iGsTluTRyogQ\""
    },
    body: null,
    requestId: "3ae25a9a-ec0f-4bfe-aa71-0e02e57997a2",
    "_add_time": 1765517466977,
    "_add_time_str": "2025-12-12 13:31:06",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8b8ac37b5863079b4d0"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-G/lIZHodSQdKzlNEIcKjPF3D92I\""
    },
    body: null,
    requestId: "50b9ef3e-f3d5-4d2d-80d4-4fe43cd551a6",
    "_add_time": 1765517496710,
    "_add_time_str": "2025-12-12 13:31:36",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8baac37b5863079b4d4"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-YP11yvLepBruEbehK1W/JwbvmHI\""
    },
    body: null,
    requestId: "ccbb6ce9-eff1-4150-9f1a-7de6ee1fa2db",
    "_add_time": 1765517498408,
    "_add_time_str": "2025-12-12 13:31:38",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8bbac37b5863079b4d8"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-PWBNPujCQmW+/U2vu3+lXMzjZwQ\""
    },
    body: null,
    requestId: "97d9470a-2da6-488e-b1f8-6f111e5509cd",
    "_add_time": 1765517499933,
    "_add_time_str": "2025-12-12 13:31:39",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8bcac37b5863079b4dc"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-nLbKLamHwZIZa00+tfXlfUl28uE\""
    },
    body: null,
    requestId: "898baec3-3da5-4760-8873-3e535e540fc2",
    "_add_time": 1765517500446,
    "_add_time_str": "2025-12-12 13:31:40",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8d555295c60e86a3217"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "9dea39cf-b959-4a96-8d89-a0a4ba83f94d",
    "_add_time": 1765517525476,
    "_add_time_str": "2025-12-12 13:32:05",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8df8f81ee138dfae4d9"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-cZr+6gEOMBhAUIiLzUO1RFZC2sg\""
    },
    body: null,
    requestId: "68787666-d7c7-447f-a1f9-9539b548ad2c",
    "_add_time": 1765517535838,
    "_add_time_str": "2025-12-12 13:32:15",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8e08f81ee138dfae4dd"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-3+SNCYTrPbybOKaEcUnNZQdIHDo\""
    },
    body: null,
    requestId: "35074892-80d9-4fc5-b48b-e597e8e79694",
    "_add_time": 1765517536584,
    "_add_time_str": "2025-12-12 13:32:16",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8e58f81ee138dfae4e1"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-icE4dl2vX2Nrzj9/3U4Wb3EhaM4\""
    },
    body: null,
    requestId: "40d81c3c-43f9-4618-8076-14c39c40ec2d",
    "_add_time": 1765517541127,
    "_add_time_str": "2025-12-12 13:32:21",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba8e58f81ee138dfae4e5"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-BJMkhfb9F7hli4JpE3dT+hie4KU\""
    },
    body: null,
    requestId: "2d92fee6-7928-46d1-8df9-68fc285be1fe",
    "_add_time": 1765517541904,
    "_add_time_str": "2025-12-12 13:32:21",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba909c8ba7b92dd3403f0"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-PdmsKB7Gbt8HxsYRQwAmOsUufW0\""
    },
    body: null,
    requestId: "a10a006f-665a-4736-be24-7b30804f325b",
    "_add_time": 1765517577404,
    "_add_time_str": "2025-12-12 13:32:57",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba90bc8ba7b92dd3403f4"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-28EZNlNjCGlDD81OSPx6cfcP9Z4\""
    },
    body: null,
    requestId: "7ff68466-df89-4ef4-8771-b2861f0fe3ae",
    "_add_time": 1765517579542,
    "_add_time_str": "2025-12-12 13:32:59",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("693ba90cc8ba7b92dd3403f8"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Chromium\";v=\"142\", \"Google Chrome\";v=\"142\", \"Not_A Brand\";v=\"99\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-OYpamq3p65Ena2VmPtaHo4VTbu0\""
    },
    body: null,
    requestId: "001dbb6e-4a02-445a-9f74-0719c7a14da5",
    "_add_time": 1765517580876,
    "_add_time_str": "2025-12-12 13:33:00",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a9145876ac472f7a0be2"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "409e71af-a049-41c3-bd3b-37aca066c6fe",
    "_add_time": 1766369556787,
    "_add_time_str": "2025-12-22 10:12:36",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a9195876ac472f7a0be6"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "9c426762-8952-4e97-be07-95a16fdff965",
    "_add_time": 1766369561257,
    "_add_time_str": "2025-12-22 10:12:41",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a9265876ac472f7a0bea"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-qXNV6cb1/dW9B8nXkiOWoqLAGwQ\""
    },
    body: null,
    requestId: "e2389508-9feb-4fd4-9bd2-7b8226d60169",
    "_add_time": 1766369574341,
    "_add_time_str": "2025-12-22 10:12:54",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a9382df61799725914e6"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-xGu+MEI8RljAEFPKMvFc949FfOI\""
    },
    body: null,
    requestId: "803b2d44-4a43-4628-979f-a3cd817ebb11",
    "_add_time": 1766369592124,
    "_add_time_str": "2025-12-22 10:13:12",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a93a2df61799725914ea"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-RpH9EznBf7t/lQCe225/m/TEUjY\""
    },
    body: null,
    requestId: "19b548fe-e3ed-4523-9cc1-abd421245f32",
    "_add_time": 1766369594659,
    "_add_time_str": "2025-12-22 10:13:14",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a93c2df61799725914ee"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-5ZfjtPAslyoHf+xoPcBzD/0QwwE\""
    },
    body: null,
    requestId: "45b97bf5-954f-4d33-ab8c-4a51f378a729",
    "_add_time": 1766369596779,
    "_add_time_str": "2025-12-22 10:13:16",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a955e158b34683cd651a"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-2wIrJgSco/YOVq4yTjIIaIEIPWQ\""
    },
    body: null,
    requestId: "3078a875-14d8-475e-bc0b-6d5b49536374",
    "_add_time": 1766369621269,
    "_add_time_str": "2025-12-22 10:13:41",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a958e158b34683cd651e"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-+D7lq9L1bRQ2F79NyzC/tF6dcpw\""
    },
    body: null,
    requestId: "b15e6b85-d659-4380-8a7e-9bc17dbe0337",
    "_add_time": 1766369624073,
    "_add_time_str": "2025-12-22 10:13:44",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a969e158b34683cd6522"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-CMUPklJGDoEtTKK08qmSLl+AD5o\""
    },
    body: null,
    requestId: "9d43a76a-1592-4e2a-9f65-d9f4483a2096",
    "_add_time": 1766369641037,
    "_add_time_str": "2025-12-22 10:14:01",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948a96ae158b34683cd6526"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-S74c3IrYQpMF3WNdvKefyV4S5n0\""
    },
    body: null,
    requestId: "499d7a07-257a-49ea-83c4-7a73c61d6c57",
    "_add_time": 1766369642692,
    "_add_time_str": "2025-12-22 10:14:02",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948aa0002ad3a183b8df955"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-WxzSpHsa0pL0u58aFjco7YgKz8E\""
    },
    body: null,
    requestId: "ae2d9d13-f1f9-40b3-a48a-c8b94276b131",
    "_add_time": 1766369792724,
    "_add_time_str": "2025-12-22 10:16:32",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948aa0202ad3a183b8df959"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-q7f/KZaCYJQxu9F7rWMruaHYXKU\""
    },
    body: null,
    requestId: "44a11fc6-1fb8-4544-b0ac-4192fd4400e8",
    "_add_time": 1766369794664,
    "_add_time_str": "2025-12-22 10:16:34",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948aa0e02ad3a183b8df95d"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-knqG9SjqOjKjvFfFCD5sWcod2sM\""
    },
    body: null,
    requestId: "08296ede-f7c0-4b10-8075-7c8eee7a6651",
    "_add_time": 1766369806267,
    "_add_time_str": "2025-12-22 10:16:46",
    response: {
        value: {
            name: NumberInt("1")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948aa1c2d339fe524725183"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-9D2Z9jIrpbtEGJdZbok1R4A7e1A\""
    },
    body: null,
    requestId: "0e62820f-6349-4a20-b10e-cffdd1ab4185",
    "_add_time": 1766369820638,
    "_add_time_str": "2025-12-22 10:17:00",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948ab5507828643125c8e5e"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-uCb/Tn4IRHqUUF3Tpm9am85iac0\""
    },
    body: null,
    requestId: "3a8f065b-6240-447a-a0d1-4494f5d902ec",
    "_add_time": 1766370133334,
    "_add_time_str": "2025-12-22 10:22:13",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948ac086adb52f14cbee5b9"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-ORMvJIVolC3TbfHBiH6oGud/Dcg\""
    },
    body: null,
    requestId: "bd21adbc-21eb-4600-885f-71c108ec975a",
    "_add_time": 1766370312469,
    "_add_time_str": "2025-12-22 10:25:12",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948ac25a44805937d48a730"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-x9vdKby/ugKln7O7eE5uZNP9Vts\""
    },
    body: null,
    requestId: "01296ba6-e37f-42dc-9d71-15159f20fe7d",
    "_add_time": 1766370341216,
    "_add_time_str": "2025-12-22 10:25:41",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948ac47a44805937d48a734"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-/MiD4F1MIj/WaMVchRkKU90AFTc\""
    },
    body: null,
    requestId: "2fac6ed9-cb6c-449c-a076-351123f35500",
    "_add_time": 1766370375506,
    "_add_time_str": "2025-12-22 10:26:15",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948ac55a44805937d48a738"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-UgvA8FL1SFEl6vfRxaKA7qssMbo\""
    },
    body: null,
    requestId: "be2a2275-7405-4cc4-a761-4ebc4d134007",
    "_add_time": 1766370389439,
    "_add_time_str": "2025-12-22 10:26:29",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948aca0a44805937d48a73c"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"6d-1F3PBFHCeWJok414/xdW9heQOYA\""
    },
    body: null,
    requestId: "086f155d-467b-47ac-be77-6cf979ac80fa",
    "_add_time": 1766370464656,
    "_add_time_str": "2025-12-22 10:27:44",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948aca1a44805937d48a740"),
    url: "/cacheRead",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"5b-Vk5PmDRquc5NzI+cWji9KhLpsvc\""
    },
    body: null,
    requestId: "1cb3e57c-5870-4606-b7ee-8e949a717b73",
    "_add_time": 1766370465482,
    "_add_time_str": "2025-12-22 10:27:45",
    response: {
        value: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948aca2a44805937d48a744"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        "sec-purpose": "prefetch;prerender",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-wBZ71gDmi9LtqVIlA4YG393HMuk\""
    },
    body: null,
    requestId: "04843a5e-fc67-4996-9678-19ad4737ca68",
    "_add_time": 1766370466625,
    "_add_time_str": "2025-12-22 10:27:46",
    response: null
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("6948ad486f3b8d72697d5824"),
    url: "/cacheSet",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "127.0.0.1:3001",
        connection: "keep-alive",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Google Chrome\";v=\"143\", \"Chromium\";v=\"143\", \"Not A(Brand\";v=\"24\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"51-kCbaSUyJ/Tz7GnLpnDprrjVslak\""
    },
    body: null,
    requestId: "a97dee82-ce8d-426c-87a8-10a39d6a2e47",
    "_add_time": 1766370632704,
    "_add_time_str": "2025-12-22 10:30:32",
    response: null
} ]);

// ----------------------------
// Collection structure for qa-menus
// ----------------------------
db.getCollection("qa-menus").drop();
db.createCollection("qa-menus");

// ----------------------------
// Documents of qa-menus
// ----------------------------
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("672b207918a1950fd5ed570b"),
    "_add_time": NumberLong("1596416400000"),
    enable: true,
    icon: "tools",
    "menu_id": "system",
    title: "系统设置",
    name: "system",
    sort: NumberInt("110"),
    component: null,
    "parent_id": null,
    path: null
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("672b209618a1950fd5ed570c"),
    "_add_time": NumberLong("1596416400000"),
    enable: true,
    icon: "folder-opened",
    "menu_id": "system-uni-uni-id-files",
    title: "素材管理",
    name: "systemFile",
    "parent_id": "system",
    sort: NumberInt("2"),
    component: "/src/pages/system/systemFile",
    path: "system/system-file"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("672dc39fef2124dea37e285d"),
    "_add_time": NumberLong("1596416400000"),
    comment: "1个角色可以分配多个角色",
    enable: true,
    icon: "user-filled",
    "menu_id": "sys-user-manage",
    title: "系统用户管理",
    name: "systemUser",
    "parent_id": "system",
    sort: NumberInt("1"),
    component: "/src/pages/system/systemUser",
    path: "system/system-user"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("672dc3c2ef2124dea37e285e"),
    "_add_time": NumberLong("1596416400000"),
    comment: "1个角色可以分配多个权限和菜单",
    enable: true,
    icon: "user",
    "menu_id": "sys-role-manage",
    title: "角色管理",
    name: "systemRole",
    "parent_id": "system",
    sort: NumberInt("3"),
    component: "/src/pages/system/systemRole/index",
    path: "system/system-role"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("672dc3d5ef2124dea37e285f"),
    "_add_time": NumberLong("1596416400000"),
    comment: "控制admin左侧菜单的显示和隐藏",
    enable: true,
    icon: "Menu",
    "menu_id": "sys-menus-manage",
    title: "菜单管理",
    name: "systemMenu",
    "parent_id": "system",
    sort: NumberInt("4"),
    component: "/src/pages/system/systemMenu",
    path: "system/system-menu"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("673f2966f80f4613e73ed0cc"),
    "parent_id": "system",
    "menu_id": "enable",
    title: "健身",
    icon: "AlarmClock",
    "_add_time": NumberLong("1732192614508"),
    "_add_time_str": "2024-11-21 20:36:54",
    enable: true,
    name: "muscle",
    component: "/src/pages/muscle/muscleManage",
    path: "Muscle/muscleManage",
    sort: null
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("6740620e947e19874d59330d"),
    "parent_id": "system",
    "menu_id": "system-log",
    icon: "Document",
    path: "system/system-log",
    "_add_time": NumberLong("1732272654771"),
    "_add_time_str": "2024-11-22 18:50:54",
    component: "/src/pages/system/systemLog",
    sort: null,
    title: "请求日志",
    enable: true,
    name: "systemLog"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("68f43fe1bcda844d0bc82270"),
    "parent_id": "system",
    "menu_id": "system-permission",
    icon: "Document",
    path: "system/system-permission",
    "_add_time": NumberLong("1732272654771"),
    "_add_time_str": "2024-11-22 18:50:54",
    component: "/src/pages/system/systemPermission",
    sort: null,
    title: "权限管理",
    enable: true,
    name: "systemPermission"
} ]);

// ----------------------------
// Collection structure for qa-permissions
// ----------------------------
db.getCollection("qa-permissions").drop();
db.createCollection("qa-permissions");

// ----------------------------
// Documents of qa-permissions
// ----------------------------
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("672b201418a1950fd5ed1701"),
    "_add_time": NumberLong("1596416400000"),
    comment: "",
    enable: true,
    "permission_id": "sys-log",
    "permission_name": "系统-请求日志",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemLog/*"
    ],
    "match_mode": NumberInt("0")
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("674548c891b2ac8efc8bc950"),
    "_add_time": NumberLong("1596416400000"),
    comment: "",
    enable: true,
    "permission_id": "sys-menu",
    "permission_name": "系统-菜单管理",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemMenu/systemMenu/add",
        "/app/admin/system/systemMenu/systemMenu/delete",
        "/app/admin/system/systemMenu/systemMenu/update",
        "/app/admin/system/systemMenu/systemMenu/getList",
        "/app/admin/auth/auth/getDynamicMenu"
    ],
    "match_mode": NumberInt("0")
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("674548ec91b2ac8efc8bc951"),
    "_add_time": NumberLong("1596416400000"),
    comment: "",
    enable: true,
    "permission_id": "sys-role",
    "permission_name": "系统-角色管理",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemRole/systemRole/add",
        "/app/admin/system/systemRole/systemRole/delete",
        "/app/admin/system/systemRole/systemRole/update",
        "/app/admin/system/systemRole/systemRole/getList",
        "/app/admin/system/systemRole/systemRole/getAllPermissions"
    ],
    "match_mode": null
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6745490491b2ac8efc8bc952"),
    "_add_time": NumberLong("1596416400000"),
    comment: "",
    enable: true,
    "permission_id": "sys-file",
    "permission_name": "系统-素材管理",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemFile/systemFile/add",
        "/app/admin/system/systemFile/systemFile/delete",
        "/app/admin/system/systemFile/systemFile/update",
        "/app/admin/system/systemFile/systemFile/getList"
    ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6745903f91b2ac8efc8bc9ab"),
    "_add_time": NumberLong("1596416400000"),
    comment: "CRUD权限",
    enable: true,
    "permission_id": "sys-permission",
    "permission_name": "系统内置权限",
    sort: NumberInt("0"),
    url: [ ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6745907091b2ac8efc8bc9ad"),
    "_add_time": NumberLong("1596416400000"),
    comment: "所有路由以add结尾路由",
    enable: true,
    "permission_id": "sys-add",
    "permission_name": "系统内置 - 增",
    sort: NumberInt("0"),
    url: [
        "*/add"
    ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6745911391b2ac8efc8bc9ae"),
    "_add_time": NumberLong("1596416400000"),
    comment: "所有路由以delete结尾路由",
    enable: true,
    "permission_id": "sys-delete",
    "permission_name": "系统内置 - 删",
    sort: NumberInt("0"),
    url: [
        "*/delete"
    ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6745917291b2ac8efc8bc9b0"),
    "_add_time": NumberLong("1596416400000"),
    comment: "所有路由以update结尾路由",
    enable: true,
    "permission_id": "sys-update",
    "permission_name": "系统内置 - 改",
    sort: NumberInt("0"),
    url: [
        "*/update"
    ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6745919991b2ac8efc8bc9b1"),
    "_add_time": NumberLong("1596416400000"),
    comment: "所有查询",
    enable: true,
    "permission_id": "sys-read",
    "permission_name": "系统内置 - 查",
    sort: NumberInt("0"),
    url: [
        "*/getList",
        "*/select",
        "*/getAll",
        "*/getDynamicMenu"
    ]
} ]);

// ----------------------------
// Collection structure for qa-roles
// ----------------------------
db.getCollection("qa-roles").drop();
db.createCollection("qa-roles");

// ----------------------------
// Documents of qa-roles
// ----------------------------
db.getCollection("qa-roles").insert([ {
    _id: ObjectId("672b1fc518a1950fd5ed56ff"),
    "_add_time": NumberLong("1760595008000"),
    "_add_time_str": "2025-10-16 14:10:08",
    comment: "系统角色-请勿删除",
    enable: true,
    permission: [ ],
    "role_id": "admin",
    "role_name": "超级管理员",
    no: NumberInt("1"),
    menu: [
        "system",
        "system-uni-uni-id-files",
        "sys-user-manage",
        "sys-role-manage",
        "sys-menus-manage",
        "enable",
        "system-log"
    ]
} ]);
db.getCollection("qa-roles").insert([ {
    _id: ObjectId("672b1fc518a1950fd5ed565f"),
    "_add_time": NumberLong("1760595008000"),
    "_add_time_str": "2025-10-16 14:10:08",
    comment: "二级管理员",
    enable: true,
    permission: [
        "sys-log",
        "sys-menu",
        "sys-role",
        "sys-file",
        "sys-permission",
        "sys-add",
        "sys-delete",
        "sys-update",
        "sys-read"
    ],
    "role_id": "agent",
    "role_name": "代理商",
    no: NumberInt("2"),
    menu: [
        "system",
        "system-uni-uni-id-files",
        "sys-user-manage",
        "sys-role-manage",
        "sys-menus-manage",
        "enable",
        "system-log",
        "system-permission"
    ]
} ]);
db.getCollection("qa-roles").insert([ {
    _id: ObjectId("68f099d01c5507ab49971458"),
    "role_id": "test",
    "role_name": "测试角色1",
    comment: "测试角色",
    enable: true,
    permission: [
        "sys-manage",
        "sys-log",
        "sys-user",
        "sys-menu",
        "sys-role",
        "sys-file"
    ],
    "_add_time": NumberLong("1760598480627"),
    "_add_time_str": "2025-10-16 15:08:00",
    menu: [
        "system",
        "system-uni-uni-id-files",
        "sys-user-manage",
        "sys-role-manage",
        "sys-menus-manage",
        "enable",
        "system-log",
        "system-permission"
    ]
} ]);

// ----------------------------
// Collection structure for qa-users
// ----------------------------
db.getCollection("qa-users").drop();
db.createCollection("qa-users");

// ----------------------------
// Documents of qa-users
// ----------------------------
db.getCollection("qa-users").insert([ {
    _id: ObjectId("672b901c0fcabce5e29faef5"),
    username: "admin",
    password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
    role: [
        "admin"
    ],
    "_add_time": NumberLong("1730908188567"),
    "_add_time_str": "2024-11-06 23:49:48",
    no: NumberInt("2"),
    image: "https://avatars.githubusercontent.com/u/53579755?v=4",
    avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
    lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
    token: [
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjYzODIxNTIsImV4cCI6MTc2Njk4Njk1Mn0._Uuq-tNI_jxBZg2FFxPQrs6VSf-X65JpUsYurretuHM",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjYzODIzMjcsImV4cCI6MTc2Njk4NzEyN30.nF8l1bQgb1YX2UJo9xR9ikEG-H9UEcN3gUfBJHsy4DU",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjYzODIzNzEsImV4cCI6MTc2Njk4NzE3MX0.hBCsWh7SJvYtw7KBrYoeY-DsX5sUuWe9JvveWcPC7AE"
    ],
    "last_login_date": 1766382371675,
    "last_login_ip": "未知IP",
    object: {
        name: "小明",
        age: NumberInt("18")
    },
    userInfo: {
        name: "小明",
        age: NumberInt("18"),
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        nickname: "你猜"
    }
} ]);
db.getCollection("qa-users").insert([ {
    _id: ObjectId("68bb20b94f8c40661556f27c"),
    username: "agent",
    password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
    role: [
        "agent"
    ],
    "_add_time": NumberLong("1730908188567"),
    "_add_time_str": "2024-11-06 23:49:48",
    no: NumberInt("2"),
    image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
    avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
    lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
    token: [
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NjYzODY2MzEsImV4cCI6MTc2Njk5MTQzMX0.KcNveLeFnQ08_oXIzhAtfNnk3Egz6Wuj4BdqQRcckbY",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NjYzODY3NTksImV4cCI6MTc2Njk5MTU1OX0.Qdz4j7i7oX88EIqD6RUJJ7TRvwh5NKQVB5MDrwFkqq4",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NjYzODY4MjQsImV4cCI6MTc2Njk5MTYyNH0.Vvbinte4DhJLw_0GnH6sOsV6waHHflfW3T0PrJVTwEY"
    ],
    "last_login_date": 1766386824046,
    "last_login_ip": "未知IP",
    object: {
        name: "小王",
        age: NumberInt("18")
    },
    userInfo: {
        name: "小明",
        age: NumberInt("18"),
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        nickname: "你猜"
    }
} ]);
db.getCollection("qa-users").insert([ {
    _id: ObjectId("69363a37ad318b61c3f0ab7a"),
    username: "test",
    password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
    role: [
        "test"
    ],
    "_add_time": NumberLong("1730908188567"),
    "_add_time_str": "2024-11-06 23:49:48",
    no: NumberInt("2"),
    image: "https://avatars.githubusercontent.com/u/53579755?v=4",
    avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
    lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
    token: [
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTM2M2EzN2FkMzE4YjYxYzNmMGFiN2EiLCJpYXQiOjE3NjUxNjIyNzQsImV4cCI6MTc2NTc2NzA3NH0.VGb4lHLAtWfDPWVTBSmnzHSHrcAs6KTlG3XMWG4ad7g",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTM2M2EzN2FkMzE4YjYxYzNmMGFiN2EiLCJpYXQiOjE3NjUxNjIzMzAsImV4cCI6MTc2NTc2NzEzMH0.kxzrfBCSco_WoJXYy6rK4IYtexOFkd85q3QOtgXnlrE",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OTM2M2EzN2FkMzE4YjYxYzNmMGFiN2EiLCJpYXQiOjE3NjUxNjIzNDIsImV4cCI6MTc2NTc2NzE0Mn0.IurejyU7jWkY7PtA0G7NVziVsh1c5yD31wXl9USFACQ"
    ],
    "last_login_date": 1765162342818,
    "last_login_ip": "未知IP",
    object: {
        name: "小明",
        age: NumberInt("18")
    },
    userInfo: {
        name: "小明",
        age: NumberInt("18"),
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        nickname: "你猜"
    }
} ]);
