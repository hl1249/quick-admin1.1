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

 Date: 06/09/2025 03:26:12
*/


// ----------------------------
// Collection structure for qa-logs
// ----------------------------
db.getCollection("qa-logs").drop();
db.createCollection("qa-logs");

// ----------------------------
// Documents of qa-logs
// ----------------------------

// ----------------------------
// Collection structure for qa-menus
// ----------------------------
db.getCollection("qa-menus").drop();
db.createCollection("qa-menus");

// ----------------------------
// Documents of qa-menus
// ----------------------------

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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTcwODk4MTksImV4cCI6MTc1NzY5NDYxOX0.j5bOqdySbYqWbR6qHYXfDG7psMP2kBhENw_y5yHOKi8",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTcwOTAxNDgsImV4cCI6MTc1NzY5NDk0OH0.jlP4tFdDcZvOoRYU10uFJtAepc5UFq0CeYxljni_xFU",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTcwOTIyNDEsImV4cCI6MTc1NzY5NzA0MX0.LvduHPhHkIc-hyyMu5-SLrj-dPxwjHDjA1GnOzZQhuw"
    ],
    "last_login_date": 1757092241598,
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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NTcwOTQyMTIsImV4cCI6MTc1NzY5OTAxMn0.CZ0ZahlMM0dW2kPDmMLeuD4pIVB8uw58znW9QMLw90o"
    ],
    "last_login_date": 1757094212472,
    "last_login_ip": "127.0.0.1"
} ]);
