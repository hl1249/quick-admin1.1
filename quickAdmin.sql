/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MongoDB
 Source Server Version : 80003
 Source Host           : localhost:27017
 Source Schema         : quickAdmin

 Target Server Type    : MongoDB
 Target Server Version : 80003
 File Encoding         : 65001

 Date: 08/09/2025 08:02:18
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
    _id: ObjectId("68bb7759b8697b2e34eb1764"),
    url: "/app/admin/auth/auth/login",
    method: "POST",
    statusCode: NumberInt("200"),
    headers: {
        host: "localhost:3000",
        connection: "close",
        "content-length": "44",
        "sec-ch-ua-platform": "\"Windows\"",
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTcxMTYyMjEsImV4cCI6MTc1NzcyMTAyMX0.t1Xr2evVclINEQu9h1ErQQx5dZBXiYa7ysBiWgJVbIo",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36",
        accept: "application/json, text/plain, */*",
        "sec-ch-ua": "\"Not;A=Brand\";v=\"99\", \"Google Chrome\";v=\"139\", \"Chromium\";v=\"139\"",
        "content-type": "application/json",
        "sec-ch-ua-mobile": "?0",
        origin: "http://localhost:1818",
        "sec-fetch-site": "same-origin",
        "sec-fetch-mode": "cors",
        "sec-fetch-dest": "empty",
        referer: "http://localhost:1818/login",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: {
        username: "admin",
        password: "hr20001124"
    },
    requestId: "833442a4-88e2-4e84-bbd7-9a78a13ef849",
    "_add_time": 1757116249610,
    "_add_time_str": "2025-09-06 07:50:49",
    response: {
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTcxMTYyNDksImV4cCI6MTc1NzcyMTA0OX0.OfscvJ0e-bc2vqGQ2Sz9sCJrcL7PKp0MVKHR0S9KsRk",
        expired: 1757721049000,
        userInfo: {
            _id: ObjectId("672b901c0fcabce5e29faef5"),
            username: "admin",
            role: [
                "admin"
            ],
            "_add_time": 1730908188567,
            "_add_time_str": "2024-11-06 23:49:48",
            no: NumberInt("2"),
            image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
            avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
            lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
            "last_login_date": 1757116221286,
            "last_login_ip": "未知IP"
        }
    }
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
    component: "/src/pages/system/systemRole",
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
    "parent_id": "systemRole",
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
    "parent_id": "sys-manage",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemLog/*"
    ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6745485d91b2ac8efc8bc94e"),
    "_add_time": NumberLong("1596416400000"),
    comment: "",
    enable: true,
    "permission_id": "sys-user",
    "permission_name": "系统-用户管理",
    "parent_id": "sys-manage",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemUser/*"
    ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("674548c891b2ac8efc8bc950"),
    "_add_time": NumberLong("1596416400000"),
    comment: "",
    enable: true,
    "permission_id": "sys-menu",
    "permission_name": "系统-菜单管理",
    "parent_id": "sys-manage",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemMenu/*"
    ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("674548ec91b2ac8efc8bc951"),
    "_add_time": NumberLong("1596416400000"),
    comment: "",
    enable: true,
    "permission_id": "sys-role",
    "permission_name": "系统-角色管理",
    "parent_id": "sys-manage",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemRole/*"
    ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6745490491b2ac8efc8bc952"),
    "_add_time": NumberLong("1596416400000"),
    comment: "",
    enable: true,
    "permission_id": "sys-file",
    "permission_name": "系统-素材管理",
    "parent_id": "sys-manage",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemFile/*"
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
    "parent_id": "sys-permission",
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
    "parent_id": "sys-permission",
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
    "parent_id": "sys-permission",
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
    "parent_id": "sys-permission",
    "permission_name": "系统内置 - 查",
    sort: NumberInt("0"),
    url: [
        "*/getList",
        "*/select",
        "*/getAll"
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
    "_add_time": NumberLong("1596416400000"),
    comment: "系统内置角色 - 请勿修改",
    enable: true,
    permission: [
        "sys-permission",
        "sys-file",
        "sys-auth"
    ],
    "role_id": "admin",
    "role_name": "超级管理员",
    no: NumberInt("1")
} ]);
db.getCollection("qa-roles").insert([ {
    _id: ObjectId("672b1fc518a1950fd5ed565f"),
    "_add_time": NumberLong("1731550508000"),
    comment: "系统内置角色 - 请勿修改",
    enable: true,
    permission: [
        "sys-manage",
        "sys-role",
        "sys-file",
        "sys-menu",
        "sys-log",
        "sys-user",
        "sys-permission"
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
        "system-log"
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
    image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
    avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
    lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
    token: [
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTcyODg2MTMsImV4cCI6MTc1Nzg5MzQxM30.eh97-S9fqk43sOPnCMFZwgeZ7-pAALP46L3_QM_JqrA",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTcyODg2MTcsImV4cCI6MTc1Nzg5MzQxN30.UPGZj_Zqavx_8U60rXD6bUgVjjPjXAS7D2ohrssHyyw",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTcyODk1NDUsImV4cCI6MTc1Nzg5NDM0NX0.lHJiqo-nx2tvLtLZruVtjmHW-fPReoEP7vjm67wei3E"
    ],
    "last_login_date": 1757289545327,
    "last_login_ip": "127.0.0.1"
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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NTcwOTQyMTIsImV4cCI6MTc1NzY5OTAxMn0.CZ0ZahlMM0dW2kPDmMLeuD4pIVB8uw58znW9QMLw90o",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NTcxMDY0MjEsImV4cCI6MTc1NzcxMTIyMX0.mGxrVIGRn-I3ew1gWVS5MD_MJqYv790er8vDa7aH2I4"
    ],
    "last_login_date": 1757106421363,
    "last_login_ip": "127.0.0.1"
} ]);
