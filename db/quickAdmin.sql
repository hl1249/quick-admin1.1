/*
 Navicat Premium Data Transfer

 Source Server         : quick
 Source Server Type    : MongoDB
 Source Server Version : 80205
 Source Host           : 43.139.63.227:27017
 Source Schema         : quickAdmin

 Target Server Type    : MongoDB
 Target Server Version : 80205
 File Encoding         : 65001

 Date: 23/03/2026 11:17:37
*/


// ----------------------------
// Collection structure for qa-app-config
// ----------------------------
db.getCollection("qa-app-config").drop();
db.createCollection("qa-app-config");

// ----------------------------
// Documents of qa-app-config
// ----------------------------
db.getCollection("qa-app-config").insert([ {
    _id: ObjectId("69bcbb2e0c34b64800565ec6"),
    "oss_provider": "tencent"
} ]);

// ----------------------------
// Collection structure for qa-files
// ----------------------------
db.getCollection("qa-files").drop();
db.createCollection("qa-files");

// ----------------------------
// Documents of qa-files
// ----------------------------
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69bca6c70c34b64800565e86"),
    "user_id": "686ea0993d029cca22ffc26f",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://mp-dfe03582-4d20-4823-a4af-531996ee3cb6.cdn.bspapp.com/2026/03/20/71075729-13429739-17739697152364532210535bc4a98bd383b9012d32db9.png",
    "display_name": "1773969715236-4532210535bc4a98bd383b9012d32db9.png",
    "original_name": "1773969715236-4532210535bc4a98bd383b9012d32db9.png",
    size: NumberInt("21367"),
    "file_id": "https://mp-dfe03582-4d20-4823-a4af-531996ee3cb6.cdn.bspapp.com/2026/03/20/71075729-13429739-17739697152364532210535bc4a98bd383b9012d32db9.png",
    provider: "unicloud",
    width: NumberInt("500"),
    height: NumberInt("500"),
    "category_id": "69bca58721821bb8e303470d",
    "_add_time": NumberLong("1773971083844"),
    "_add_time_str": "2026-03-20 09:44:43"
} ]);

// ----------------------------
// Collection structure for qa-files-categories
// ----------------------------
db.getCollection("qa-files-categories").drop();
db.createCollection("qa-files-categories");

// ----------------------------
// Documents of qa-files-categories
// ----------------------------

// ----------------------------
// Collection structure for qa-logs
// ----------------------------
db.getCollection("qa-logs").drop();
db.createCollection("qa-logs");

// ----------------------------
// Documents of qa-logs
// ----------------------------
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e778e0c635e46a2c8c4b94"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk5ODI1NzgsImV4cCI6MTc2MDU4NzM3OH0.elDfErLnQL4JOemk8M5TWw9EEGjAP4GlCevvcOktSHc",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "2ca65838-5773-4a6c-b1c7-d6935d09599a",
    "_add_time": 1760000224540,
    "_add_time_str": "2025-10-09 16:57:04",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk1NDMzMDksImV4cCI6MTc2MDE0ODEwOX0.P4jx_yBBs8E4aRlIMAwWu5JCIUsHAqJcbfDcNmtJ08Q",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk1NDM0NzUsImV4cCI6MTc2MDE0ODI3NX0.kesy8Nx4rOrCKlXvNct587VuDAxwVOq8YnSejRdOf6g",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk5ODI1NzgsImV4cCI6MTc2MDU4NzM3OH0.elDfErLnQL4JOemk8M5TWw9EEGjAP4GlCevvcOktSHc"
        ],
        "last_login_date": 1759982578168,
        "last_login_ip": "127.0.0.1"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e8731e9e15e24eb6a4e578"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "d970f994-41db-467b-9f84-b98469105595",
    "_add_time": 1760064286977,
    "_add_time_str": "2025-10-10 10:44:46",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk5ODI1NzgsImV4cCI6MTc2MDU4NzM3OH0.elDfErLnQL4JOemk8M5TWw9EEGjAP4GlCevvcOktSHc",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A"
        ],
        "last_login_date": 1760064273066,
        "last_login_ip": "127.0.0.1"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e873209e15e24eb6a4e57e"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "e5253d85-1124-4aa8-af9c-9fba3de06c00",
    "_add_time": 1760064288135,
    "_add_time_str": "2025-10-10 10:44:48",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk5ODI1NzgsImV4cCI6MTc2MDU4NzM3OH0.elDfErLnQL4JOemk8M5TWw9EEGjAP4GlCevvcOktSHc",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A"
        ],
        "last_login_date": 1760064273066,
        "last_login_ip": "127.0.0.1"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e873209e15e24eb6a4e584"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "3f84a383-9587-4e5f-84f3-44c29a9ab714",
    "_add_time": 1760064288901,
    "_add_time_str": "2025-10-10 10:44:48",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk5ODI1NzgsImV4cCI6MTc2MDU4NzM3OH0.elDfErLnQL4JOemk8M5TWw9EEGjAP4GlCevvcOktSHc",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A"
        ],
        "last_login_date": 1760064273066,
        "last_login_ip": "127.0.0.1"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e873219e15e24eb6a4e58a"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "538b5488-cb1a-4d61-8e82-18db9739cb5c",
    "_add_time": 1760064289680,
    "_add_time_str": "2025-10-10 10:44:49",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk5ODI1NzgsImV4cCI6MTc2MDU4NzM3OH0.elDfErLnQL4JOemk8M5TWw9EEGjAP4GlCevvcOktSHc",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A"
        ],
        "last_login_date": 1760064273066,
        "last_login_ip": "127.0.0.1"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e873229e15e24eb6a4e590"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "e96f0626-a89a-402c-bae2-70bdf692254b",
    "_add_time": 1760064290409,
    "_add_time_str": "2025-10-10 10:44:50",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTk5ODI1NzgsImV4cCI6MTc2MDU4NzM3OH0.elDfErLnQL4JOemk8M5TWw9EEGjAP4GlCevvcOktSHc",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A"
        ],
        "last_login_date": 1760064273066,
        "last_login_ip": "127.0.0.1"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e875d29e15e24eb6a4e5d0"),
    "user_id": "3214",
    date1: 1759593600000,
    "_add_time": 1760064978801,
    "_add_time_str": "2025-10-10 10:56:18"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88420a65dfb1f0206a22d"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "bceb0427-c9a7-49ef-a35f-bfabc28c706b",
    "_add_time": 1760068640129,
    "_add_time_str": "2025-10-10 11:57:20",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88421a65dfb1f0206a233"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "82b07aa7-77c8-49e9-bbdd-13abb31dbfaa",
    "_add_time": 1760068641007,
    "_add_time_str": "2025-10-10 11:57:21",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88421a65dfb1f0206a239"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "4eb5f07c-8846-4697-ac37-55326e3f1a3e",
    "_add_time": 1760068641672,
    "_add_time_str": "2025-10-10 11:57:21",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88422a65dfb1f0206a23f"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "17a9e157-639b-4297-9f73-4b44dfee84b7",
    "_add_time": 1760068642486,
    "_add_time_str": "2025-10-10 11:57:22",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88423a65dfb1f0206a245"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "919a0c21-02ea-4cd1-b5bd-85de2f46f981",
    "_add_time": 1760068643174,
    "_add_time_str": "2025-10-10 11:57:23",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88423a65dfb1f0206a24b"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "d8dc0577-e27d-4d4e-9753-d4e12516543b",
    "_add_time": 1760068643801,
    "_add_time_str": "2025-10-10 11:57:23",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88424a65dfb1f0206a251"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "705430b3-24c1-490c-894a-eb1e16c81499",
    "_add_time": 1760068644514,
    "_add_time_str": "2025-10-10 11:57:24",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88425a65dfb1f0206a257"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "4f630eb0-0269-4ce1-b039-b20422b47643",
    "_add_time": 1760068645153,
    "_add_time_str": "2025-10-10 11:57:25",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88425a65dfb1f0206a25d"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "9266ff5c-001e-4f51-80b5-21e2b6414b74",
    "_add_time": 1760068645751,
    "_add_time_str": "2025-10-10 11:57:25",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88427a65dfb1f0206a269"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "29898e05-e57e-41f6-bbe2-3c3fab8d49c9",
    "_add_time": 1760068647005,
    "_add_time_str": "2025-10-10 11:57:27",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88427a65dfb1f0206a26f"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "6ff897fe-a1e1-43be-8ebc-b6b2dff83a60",
    "_add_time": 1760068647597,
    "_add_time_str": "2025-10-10 11:57:27",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68e88428a65dfb1f0206a275"),
    url: "/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "afb6207f-7ef2-468a-b87e-81e2e0e2f6e1",
    "_add_time": 1760068648288,
    "_add_time_str": "2025-10-10 11:57:28",
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
        image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
        avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
        lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
        token: [
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNTksImV4cCI6MTc2MDY2OTA1OX0.YrzYg4jS-Ziztzhii9dbmObvHRCPjMBMU_VztEVfJAU",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQyNzMsImV4cCI6MTc2MDY2OTA3M30.tfq28X9aLJFl3TablwgdXdVsK2w85_LNElOeQE8Zg5A",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjAwNjQ2NTYsImV4cCI6MTc2MDY2OTQ1Nn0.v4KRslMfta7KNJZ_1mAQRyG7sXsaezwMOH10n_RWYeM"
        ],
        "last_login_date": 1760064656254,
        "last_login_ip": "未知IP"
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4d1179eea4cf6bacb985"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "146e1d28-2227-44a8-9871-6fb5d6a5021c",
    "_add_time": 1768705297910,
    "_add_time_str": "2026-01-18 11:01:37",
    response: NumberInt("1")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4d60fe3d61ccb78dccb3"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "2ff00e16-2850-4c85-a197-27fafb6a0434",
    "_add_time": 1768705376544,
    "_add_time_str": "2026-01-18 11:02:56",
    response: NumberInt("1")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4d64fe3d61ccb78dccb7"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "dc7a0d54-6c04-4f4e-9444-605ffe52f642",
    "_add_time": 1768705380869,
    "_add_time_str": "2026-01-18 11:03:00",
    response: NumberInt("2")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4d68fe3d61ccb78dccbb"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "69c15161-1265-45e2-ae03-4b0c25ea1822",
    "_add_time": 1768705384733,
    "_add_time_str": "2026-01-18 11:03:04",
    response: NumberInt("3")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4d69fe3d61ccb78dccbf"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "2c401788-268d-4e3c-8cd8-d4807e90b51e",
    "_add_time": 1768705385616,
    "_add_time_str": "2026-01-18 11:03:05",
    response: NumberInt("4")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4d6afe3d61ccb78dccc3"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "77f94973-b64d-419a-9ae6-0afd4b6777eb",
    "_add_time": 1768705386341,
    "_add_time_str": "2026-01-18 11:03:06",
    response: NumberInt("5")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4decea62c400a0505418"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "e63a231d-aa69-4ba2-bb51-6e0123e6b691",
    "_add_time": 1768705516059,
    "_add_time_str": "2026-01-18 11:05:16",
    response: NumberInt("1")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4df8ea62c400a050541c"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "23ed9539-c286-48f9-a27d-8e127a5d9d1c",
    "_add_time": 1768705528221,
    "_add_time_str": "2026-01-18 11:05:28",
    response: NumberInt("2")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4fd2b6903c9b4b6a6e6d"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "fa2671b9-b99c-406f-ac0c-7f75da89af7e",
    "_add_time": 1768706002392,
    "_add_time_str": "2026-01-18 11:13:22",
    response: NumberInt("1")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4fd3b6903c9b4b6a6e71"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "945b744c-4bee-49fd-bd45-07f0b3017a84",
    "_add_time": 1768706003454,
    "_add_time_str": "2026-01-18 11:13:23",
    response: NumberInt("2")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("696c4fd4b6903c9b4b6a6e75"),
    url: "/incr",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3001",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "aadbfbee-cff5-46d0-8c71-22ed6ce87863",
    "_add_time": 1768706004348,
    "_add_time_str": "2026-01-18 11:13:24",
    response: NumberInt("3")
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("699dba76387555c28ce2e2d6"),
    url: "/api/select",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "1623346c-8729-44fa-9a04-4d3c7ffcec50",
    "_add_time": 1771944566543,
    "_add_time_str": "2026-02-24 22:49:26",
    response: {
        rows: [ ],
        hasMore: false,
        total: NumberInt("0"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("2")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("699dbaa632149c67c2c6e02c"),
    url: "/api/select",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "7054d963-ea56-4775-9109-08e5b354c7d1",
    "_add_time": 1771944614895,
    "_add_time_str": "2026-02-24 22:50:14",
    response: {
        rows: [ ],
        hasMore: false,
        total: NumberInt("0"),
        getCount: true,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("2")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("699dbabf32149c67c2c6e032"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "d851a40c-1741-4995-9bc3-6e342464f88e",
    "_add_time": 1771944639221,
    "_add_time_str": "2026-02-24 22:50:39",
    response: {
        rows: [
            {
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
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3Njg3MDcxMzMsImV4cCI6MTc2OTMxMTkzM30.dWmarZTbndPNMISzJBVZPnzxjWZAwka0RhO-K0bx9sY",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3Njg3MDcxMzgsImV4cCI6MTc2OTMxMTkzOH0.N90Zk4y09Zx7tMo3-ea-EmoYRoVspxLYMQNPPy3b0SM",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3Njg3MDcxNDcsImV4cCI6MTc2OTMxMTk0N30.1vQl0DeE8r6MgKrj1hYo9TLDkxrYsfzEC_SDYRoVvsM"
                ],
                "last_login_date": 1768707147381,
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
                },
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [
                            "sys-menus-manage",
                            "system"
                        ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3Njg3MTQ3MDAsImV4cCI6MTc2OTMxOTUwMH0.JkWgfDzlUrSJ-mv_4QrV3tOFTy6cqpyEsDLXyor6Osg"
                ],
                "last_login_date": 1768714700550,
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
                },
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-manage",
                            "sys-log",
                            "sys-user",
                            "sys-menu",
                            "sys-role",
                            "sys-file",
                            "sys-manage-permission"
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
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            }
        ],
        hasMore: false,
        total: NumberInt("2"),
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
    _id: ObjectId("699f1222884ca14d6d81becb"),
    url: "/api",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "43.139.63.227:3000",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "accept-encoding": "gzip, deflate",
        "accept-language": "zh-CN,zh;q=0.9",
        cookie: "34332e3133392e36332e3232375f3030343334=c78eeae4be2e958284ceeceb99706e7c",
        "upgrade-insecure-requests": "1"
    },
    body: null,
    requestId: "b23df560-c92b-495c-b3e5-7d5bf2a24b06",
    "_add_time": 1772032546412,
    "_add_time_str": "2026-02-25 23:15:46",
    response: {
        acknowledged: true,
        deletedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("699f12c1884ca14d6d81bed0"),
    url: "/api",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "admin.xxsb.games",
        "x-real-ip": "120.228.125.217",
        "x-forwarded-for": "120.228.125.217",
        connection: "upgrade",
        "sec-ch-ua": "\"Not:A-Brand\";v=\"99\", \"Google Chrome\";v=\"145\", \"Chromium\";v=\"145\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9"
    },
    body: null,
    requestId: "e881576c-6833-455c-b9a8-14b5a77448e8",
    "_add_time": 1772032705169,
    "_add_time_str": "2026-02-25 23:18:25",
    response: {
        acknowledged: true,
        deletedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("699f1317884ca14d6d81befb"),
    url: "/api",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "admin.xxsb.games",
        "x-real-ip": "120.228.125.217",
        "x-forwarded-for": "120.228.125.217",
        connection: "upgrade",
        "sec-ch-ua": "\"Not:A-Brand\";v=\"99\", \"Google Chrome\";v=\"145\", \"Chromium\";v=\"145\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "\"699f100a-21f\"",
        "if-modified-since": "Wed, 25 Feb 2026 15:06:50 GMT"
    },
    body: null,
    requestId: "97d663c5-8af6-4795-a10f-c5dfed5cb15e",
    "_add_time": 1772032791767,
    "_add_time_str": "2026-02-25 23:19:51",
    response: {
        acknowledged: true,
        deletedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("699f131a884ca14d6d81bf00"),
    url: "/api",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "admin.xxsb.games",
        "x-real-ip": "120.228.125.217",
        "x-forwarded-for": "120.228.125.217",
        connection: "upgrade",
        "sec-ch-ua": "\"Not:A-Brand\";v=\"99\", \"Google Chrome\";v=\"145\", \"Chromium\";v=\"145\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"7f-nPFwFQeGUpr/TQjMVgPgUIAfIGc\""
    },
    body: null,
    requestId: "ae5e7ce4-d94b-4c31-95ce-3cb78075d96a",
    "_add_time": 1772032794673,
    "_add_time_str": "2026-02-25 23:19:54",
    response: {
        acknowledged: true,
        deletedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("699f1337884ca14d6d81bf05"),
    url: "/api",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "admin.xxsb.games",
        "x-real-ip": "120.228.125.217",
        "x-forwarded-for": "120.228.125.217",
        connection: "upgrade",
        "cache-control": "max-age=0",
        "sec-ch-ua": "\"Not:A-Brand\";v=\"99\", \"Google Chrome\";v=\"145\", \"Chromium\";v=\"145\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "upgrade-insecure-requests": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "sec-fetch-site": "none",
        "sec-fetch-mode": "navigate",
        "sec-fetch-user": "?1",
        "sec-fetch-dest": "document",
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "zh-CN,zh;q=0.9",
        "if-none-match": "W/\"7f-dS04+tKU/rxjxkH/ixcXdimjaA4\""
    },
    body: null,
    requestId: "273e50c9-54b1-4c24-a703-5727c22efa9e",
    "_add_time": 1772032823355,
    "_add_time_str": "2026-02-25 23:20:23",
    response: {
        acknowledged: true,
        deletedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dc5"),
    url: "/api/adds",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "1944fbd8-e5c5-4063-bc57-453d03ff1004",
    "_add_time": 1774148832168,
    "_add_time_str": "2026-03-22 11:07:12",
    response: {
        acknowledged: true,
        insertedCount: NumberInt("22"),
        insertedIds: {
            0: ObjectId("69bf5ce0e1693723e3000dc7"),
            1: ObjectId("69bf5ce0e1693723e3000dc8"),
            2: ObjectId("69bf5ce0e1693723e3000dc9"),
            3: ObjectId("69bf5ce0e1693723e3000dca"),
            4: ObjectId("69bf5ce0e1693723e3000dcb"),
            5: ObjectId("69bf5ce0e1693723e3000dcc"),
            6: ObjectId("69bf5ce0e1693723e3000dcd"),
            7: ObjectId("69bf5ce0e1693723e3000dce"),
            8: ObjectId("69bf5ce0e1693723e3000dcf"),
            9: ObjectId("69bf5ce0e1693723e3000dd0"),
            10: ObjectId("69bf5ce0e1693723e3000dd1"),
            11: ObjectId("69bf5ce0e1693723e3000dd2"),
            12: ObjectId("69bf5ce0e1693723e3000dd3"),
            13: ObjectId("69bf5ce0e1693723e3000dd4"),
            14: ObjectId("69bf5ce0e1693723e3000dd5"),
            15: ObjectId("69bf5ce0e1693723e3000dd6"),
            16: ObjectId("69bf5ce0e1693723e3000dd7"),
            17: ObjectId("69bf5ce0e1693723e3000dd8"),
            18: ObjectId("69bf5ce0e1693723e3000dd9"),
            19: ObjectId("69bf5ce0e1693723e3000dda"),
            20: ObjectId("69bf5ce0e1693723e3000ddb"),
            21: ObjectId("69bf5ce0e1693723e3000ddc")
        }
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69bf8d2d3bf89b8156fcc5ad"),
    url: "/api/updateById",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "8511ae54-cb94-4587-b496-3aa5ad7123d6",
    "_add_time": 1774161197801,
    "_add_time_str": "2026-03-22 14:33:17",
    response: {
        acknowledged: true,
        modifiedCount: NumberInt("0"),
        upsertedId: null,
        upsertedCount: NumberInt("0"),
        matchedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69bf8d573bf89b8156fcc5b2"),
    url: "/api/updateById",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "4a98abb0-38be-4b7f-b507-023ba5f61a02",
    "_add_time": 1774161239634,
    "_add_time_str": "2026-03-22 14:33:59",
    response: {
        acknowledged: true,
        modifiedCount: NumberInt("0"),
        upsertedId: null,
        upsertedCount: NumberInt("0"),
        matchedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69bf8d81494ff9a1968674f7"),
    url: "/api/updateById",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "3713943d-7b7d-4419-bd1a-5a141bb4399d",
    "_add_time": 1774161281317,
    "_add_time_str": "2026-03-22 14:34:41",
    response: {
        acknowledged: true,
        modifiedCount: NumberInt("0"),
        upsertedId: null,
        upsertedCount: NumberInt("0"),
        matchedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69bf8db64c7975b4b7068d84"),
    url: "/api/updateById",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "2cce7269-5d90-4586-ae83-b7514c0dc7fd",
    "_add_time": 1774161334464,
    "_add_time_str": "2026-03-22 14:35:34",
    response: {
        acknowledged: true,
        modifiedCount: NumberInt("0"),
        upsertedId: null,
        upsertedCount: NumberInt("0"),
        matchedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69bf8dc64c7975b4b7068d89"),
    url: "/api/update",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTY5Nzk4NjUsImV4cCI6MTc1NzU4NDY2NX0.efwqy3d0y3Rq_nxnMnTusT5MxIN31bsaomACTqdKOso",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "753049e5-b5a5-4d5c-9199-e176f5f6548c",
    "_add_time": 1774161350407,
    "_add_time_str": "2026-03-22 14:35:50",
    response: {
        acknowledged: true,
        modifiedCount: NumberInt("1"),
        upsertedId: null,
        upsertedCount: NumberInt("0"),
        matchedCount: NumberInt("1")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69bf8ddbd779b3fa35893d03"),
    url: "/api/update",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NTY5Nzk4NjUsImV4cCI6MTc1NzU4NDY2NX0.efwqy3d0y3Rq_nxnMnTusT5MxIN31bsaomACTqdKOso",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "03e1cadf-8a87-423d-970c-21b1f82832c3",
    "_add_time": 1774161371645,
    "_add_time_str": "2026-03-22 14:36:11",
    response: {
        acknowledged: true,
        modifiedCount: NumberInt("21"),
        upsertedId: null,
        upsertedCount: NumberInt("0"),
        matchedCount: NumberInt("22")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c015fca338e0970ffdd1b2"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "4a3a5e6a-fff6-4a78-a26d-c24d06eb175f",
    "_add_time": 1774196220780,
    "_add_time_str": "2026-03-23 00:17:00",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        status: NumberInt("1")
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c016159d43363471b4a388"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "d9fe8bf0-a277-4141-a81c-c0ec521b163c",
    "_add_time": 1774196245188,
    "_add_time_str": "2026-03-23 00:17:25",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c0164c9d43363471b4a38d"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "71f35d14-b1dc-4ffb-a4af-f16fe71f614b",
    "_add_time": 1774196300810,
    "_add_time_str": "2026-03-23 00:18:20",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c016569d43363471b4a392"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "296218ef-640c-4f82-ad76-1824966f3f7a",
    "_add_time": 1774196310402,
    "_add_time_str": "2026-03-23 00:18:30",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c0166c9d43363471b4a397"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "9204a4e2-d915-4ae1-9e67-e1bdaec885a9",
    "_add_time": 1774196332040,
    "_add_time_str": "2026-03-23 00:18:52",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c016a49d43363471b4a39c"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "babb474f-8497-427b-81be-162ef116a9e8",
    "_add_time": 1774196388338,
    "_add_time_str": "2026-03-23 00:19:48",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
                role: [
                    "admin",
                    "agent",
                    "test"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://avatars.githubusercontent.com/u/53579755?v=4",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c"
                ],
                "last_login_date": 1774194249867,
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
                },
                enable: true,
                nickname: "yellow12321",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [ ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "玩过",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
                ],
                "last_login_date": 1774098992205,
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
                },
                enable: true,
                nickname: "1",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-read",
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
                            "enable",
                            "system-log",
                            "system-permission"
                        ]
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            },
            {
                _id: ObjectId("69b771e8138f8761a51680dc"),
                rate: NumberInt("4"),
                username: "test",
                nickname: "哈哈哈萨达阿萨德",
                password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
                avatar: "1123",
                "_add_time": 1773629928986,
                "_add_time_str": "2026-03-16 10:58:48",
                enable: true,
                token: [ ],
                status: NumberInt("0"),
                role: [ ],
                roles: [ ],
                "role_name": [ ],
                comment: [ ],
                andSex: false
            }
        ],
        hasMore: false,
        total: NumberInt("3"),
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
    _id: ObjectId("69c016c69d43363471b4a3a2"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "ac53ddfa-170e-4a50-9977-181e0f6843bb",
    "_add_time": 1774196422904,
    "_add_time_str": "2026-03-23 00:20:22",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
                role: [
                    "admin",
                    "agent",
                    "test"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://avatars.githubusercontent.com/u/53579755?v=4",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c"
                ],
                "last_login_date": 1774194249867,
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
                },
                enable: true,
                nickname: "yellow12321",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [ ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "玩过",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
                ],
                "last_login_date": 1774098992205,
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
                },
                enable: true,
                nickname: "1",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-read",
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
                            "enable",
                            "system-log",
                            "system-permission"
                        ]
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            },
            {
                _id: ObjectId("69b771e8138f8761a51680dc"),
                rate: NumberInt("4"),
                username: "test",
                nickname: "哈哈哈萨达阿萨德",
                password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
                avatar: "1123",
                "_add_time": 1773629928986,
                "_add_time_str": "2026-03-16 10:58:48",
                enable: true,
                token: [ ],
                status: NumberInt("0"),
                role: [ ],
                roles: [ ],
                "role_name": [ ],
                comment: [ ],
                andSex: false
            }
        ],
        hasMore: false,
        total: NumberInt("3"),
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
    _id: ObjectId("69c016d29d43363471b4a3a8"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "0e27e715-aa2e-4082-a947-df5840aa0dad",
    "_add_time": 1774196434075,
    "_add_time_str": "2026-03-23 00:20:34",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
                role: [
                    "admin",
                    "agent",
                    "test"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://avatars.githubusercontent.com/u/53579755?v=4",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c"
                ],
                "last_login_date": 1774194249867,
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
                },
                enable: true,
                nickname: "yellow12321",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [ ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "玩过",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
                ],
                "last_login_date": 1774098992205,
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
                },
                enable: true,
                nickname: "1",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-read",
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
                            "enable",
                            "system-log",
                            "system-permission"
                        ]
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            },
            {
                _id: ObjectId("69b771e8138f8761a51680dc"),
                rate: NumberInt("4"),
                username: "test",
                nickname: "哈哈哈萨达阿萨德",
                password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
                avatar: "1123",
                "_add_time": 1773629928986,
                "_add_time_str": "2026-03-16 10:58:48",
                enable: true,
                token: [ ],
                status: NumberInt("0"),
                role: [ ],
                roles: [ ],
                "role_name": [ ],
                comment: [ ],
                andSex: false
            }
        ],
        hasMore: false,
        total: NumberInt("3"),
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
    _id: ObjectId("69c016e79d43363471b4a3ae"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "05b480d8-70da-4c5a-9f0a-0ba879487d8b",
    "_add_time": 1774196455211,
    "_add_time_str": "2026-03-23 00:20:55",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
                role: [
                    "admin",
                    "agent",
                    "test"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://avatars.githubusercontent.com/u/53579755?v=4",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c"
                ],
                "last_login_date": 1774194249867,
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
                },
                enable: true,
                nickname: "yellow12321",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [ ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "玩过",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
                ],
                "last_login_date": 1774098992205,
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
                },
                enable: true,
                nickname: "1",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-read",
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
                            "enable",
                            "system-log",
                            "system-permission"
                        ]
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            },
            {
                _id: ObjectId("69b771e8138f8761a51680dc"),
                rate: NumberInt("4"),
                username: "test",
                nickname: "哈哈哈萨达阿萨德",
                password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
                avatar: "1123",
                "_add_time": 1773629928986,
                "_add_time_str": "2026-03-16 10:58:48",
                enable: true,
                token: [ ],
                status: NumberInt("0"),
                role: [ ],
                roles: [ ],
                "role_name": [ ],
                comment: [ ],
                andSex: false
            }
        ],
        hasMore: false,
        total: NumberInt("3"),
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
    _id: ObjectId("69c016eb9d43363471b4a3b4"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "4f534d8f-2be8-4fa2-b1fd-579f39b134dd",
    "_add_time": 1774196459826,
    "_add_time_str": "2026-03-23 00:20:59",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c016f69d43363471b4a3b9"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "b970c907-99d2-4131-8c5a-9e00f35ed15c",
    "_add_time": 1774196470730,
    "_add_time_str": "2026-03-23 00:21:10",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c017009d43363471b4a3be"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "bf172d8b-333e-4f85-a0f1-dc8274e4b637",
    "_add_time": 1774196480631,
    "_add_time_str": "2026-03-23 00:21:20",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
                role: [
                    "admin",
                    "agent",
                    "test"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://avatars.githubusercontent.com/u/53579755?v=4",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c"
                ],
                "last_login_date": 1774194249867,
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
                },
                enable: true,
                nickname: "yellow12321",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [ ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "玩过",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
                ],
                "last_login_date": 1774098992205,
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
                },
                enable: true,
                nickname: "1",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-read",
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
                            "enable",
                            "system-log",
                            "system-permission"
                        ]
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            },
            {
                _id: ObjectId("69b771e8138f8761a51680dc"),
                rate: NumberInt("4"),
                username: "test",
                nickname: "哈哈哈萨达阿萨德",
                password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
                avatar: "1123",
                "_add_time": 1773629928986,
                "_add_time_str": "2026-03-16 10:58:48",
                enable: true,
                token: [ ],
                status: NumberInt("0"),
                role: [ ],
                roles: [ ],
                "role_name": [ ],
                comment: [ ],
                andSex: false
            }
        ],
        hasMore: false,
        total: NumberInt("3"),
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
    _id: ObjectId("69c017189d43363471b4a3c4"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "273b251c-bfc1-4422-8973-9071b67f1a40",
    "_add_time": 1774196504460,
    "_add_time_str": "2026-03-23 00:21:44",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
                role: [
                    "admin",
                    "agent",
                    "test"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://avatars.githubusercontent.com/u/53579755?v=4",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c"
                ],
                "last_login_date": 1774194249867,
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
                },
                enable: true,
                nickname: "yellow12321",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [ ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "玩过",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
                ],
                "last_login_date": 1774098992205,
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
                },
                enable: true,
                nickname: "1",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-read",
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
                            "enable",
                            "system-log",
                            "system-permission"
                        ]
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            },
            {
                _id: ObjectId("69b771e8138f8761a51680dc"),
                rate: NumberInt("4"),
                username: "test",
                nickname: "哈哈哈萨达阿萨德",
                password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
                avatar: "1123",
                "_add_time": 1773629928986,
                "_add_time_str": "2026-03-16 10:58:48",
                enable: true,
                token: [ ],
                status: NumberInt("0"),
                role: [ ],
                roles: [ ],
                "role_name": [ ],
                comment: [ ],
                andSex: false
            }
        ],
        hasMore: false,
        total: NumberInt("3"),
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
    _id: ObjectId("69c0171b9d43363471b4a3ca"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "abf53da1-7852-4985-ab06-99f489b73776",
    "_add_time": 1774196507587,
    "_add_time_str": "2026-03-23 00:21:47",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c0173e9d43363471b4a3cf"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "917c645a-8cd8-44b4-9345-6cf58d3e3138",
    "_add_time": 1774196542037,
    "_add_time_str": "2026-03-23 00:22:22",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    },
                    {
                        _id: ObjectId("69c01733ef4ce60bc51d572f"),
                        name: "xxsbs-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c0174e9d43363471b4a3d4"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "e9d870d9-8f34-4ce0-9d21-00c0a117b389",
    "_add_time": 1774196558121,
    "_add_time_str": "2026-03-23 00:22:38",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    },
                    {
                        _id: ObjectId("69c01733ef4ce60bc51d572f"),
                        name: "xxsbs-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c018759d43363471b4a3d9"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "bbb84a4f-89d5-4431-bda9-79f0c82e7d99",
    "_add_time": 1774196853938,
    "_add_time_str": "2026-03-23 00:27:33",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    },
                    {
                        _id: ObjectId("69c01733ef4ce60bc51d572f"),
                        name: "xxsbs-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c0189d9d43363471b4a3de"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "8fce0136-20b7-44fa-bea3-2099e37e7928",
    "_add_time": 1774196893015,
    "_add_time_str": "2026-03-23 00:28:13",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    },
                    {
                        _id: ObjectId("69c01733ef4ce60bc51d572f"),
                        name: "xxsbs-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c018c89d43363471b4a3e3"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "12373f3a-7d08-4d9e-86b5-79eeca678cd1",
    "_add_time": 1774196936471,
    "_add_time_str": "2026-03-23 00:28:56",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
                role: [
                    "admin",
                    "agent",
                    "test"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://avatars.githubusercontent.com/u/53579755?v=4",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c"
                ],
                "last_login_date": 1774194249867,
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
                },
                enable: true,
                nickname: "yellow12321",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [ ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "玩过",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
                ],
                "last_login_date": 1774098992205,
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
                },
                enable: true,
                nickname: "1",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-read",
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
                            "enable",
                            "system-log",
                            "system-permission"
                        ]
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            },
            {
                _id: ObjectId("69b771e8138f8761a51680dc"),
                rate: NumberInt("4"),
                username: "test",
                nickname: "哈哈哈萨达阿萨德",
                password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
                avatar: "1123",
                "_add_time": 1773629928986,
                "_add_time_str": "2026-03-16 10:58:48",
                enable: true,
                token: [ ],
                status: NumberInt("0"),
                role: [ ],
                roles: [ ],
                "role_name": [ ],
                comment: [ ],
                andSex: false
            }
        ],
        hasMore: false,
        total: NumberInt("3"),
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
    _id: ObjectId("69c019109d43363471b4a3e9"),
    url: "/api/selects",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "600a314d-6079-4c9c-8c5c-b9471edd50e0",
    "_add_time": 1774197008729,
    "_add_time_str": "2026-03-23 00:30:08",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
                role: [
                    "admin",
                    "agent",
                    "test"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://avatars.githubusercontent.com/u/53579755?v=4",
                avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    null,
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c"
                ],
                "last_login_date": 1774194249867,
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
                },
                enable: true,
                nickname: "yellow12321",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed56ff"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "系统角色-请勿删除",
                        enable: true,
                        permission: [
                            "sys-permission",
                            "sys-add",
                            "sys-delete",
                            "sys-update",
                            "sys-read"
                        ],
                        "role_id": "admin",
                        "role_name": "超级管理员",
                        no: NumberInt("1"),
                        menu: [ ]
                    }
                ],
                "role_name": [
                    "admin"
                ],
                comment: [
                    "系统角色-请勿删除"
                ],
                andSex: true
            },
            {
                _id: ObjectId("68bb20b94f8c40661556f27c"),
                username: "agent",
                password: "$2a$10$1AROJQqbbxDa1fmw1IwvreW2M8K.TnnCisTdFi96yHbxWbW5vEPly",
                role: [
                    "agent"
                ],
                "_add_time": 1730908188567,
                "_add_time_str": "2024-11-06 23:49:48",
                no: NumberInt("2"),
                image: "https://imgfiles.pages.dev/file/4f1519414f324c4623dcc.jpg",
                avatar: "玩过",
                lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
                token: [
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
                ],
                "last_login_date": 1774098992205,
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
                },
                enable: true,
                nickname: "1",
                rate: NumberInt("2"),
                status: NumberInt("0"),
                roles: [
                    {
                        _id: ObjectId("672b1fc518a1950fd5ed565f"),
                        "_add_time": 1760595008000,
                        "_add_time_str": "2025-10-16 14:10:08",
                        comment: "二级管理员-1",
                        enable: true,
                        permission: [
                            "sys-read",
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
                            "enable",
                            "system-log",
                            "system-permission"
                        ]
                    }
                ],
                "role_name": [
                    "agent"
                ],
                comment: [
                    "二级管理员-1"
                ],
                andSex: true
            },
            {
                _id: ObjectId("69b771e8138f8761a51680dc"),
                rate: NumberInt("4"),
                username: "test",
                nickname: "哈哈哈萨达阿萨德",
                password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
                avatar: "1123",
                "_add_time": 1773629928986,
                "_add_time_str": "2026-03-16 10:58:48",
                enable: true,
                token: [ ],
                status: NumberInt("0"),
                role: [ ],
                roles: [ ],
                "role_name": [ ],
                comment: [ ],
                andSex: false
            }
        ],
        hasMore: false,
        total: NumberInt("3"),
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
    _id: ObjectId("69c019189d43363471b4a3ef"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "5caeed96-4900-48ec-9330-9fffbdadcfc1",
    "_add_time": 1774197016263,
    "_add_time_str": "2026-03-23 00:30:16",
    response: {
        rows: [
            {
                _id: ObjectId("69bcbb2e0c34b64800565ec6"),
                "oss_provider": "tencent",
                space: [
                    {
                        _id: ObjectId("69bd7047fdc08e554a55374a"),
                        name: "xxsb-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    },
                    {
                        _id: ObjectId("69c01733ef4ce60bc51d572f"),
                        name: "xxsbs-1319368598",
                        region: "ap-guangzhou",
                        status: NumberInt("1"),
                        domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                        "_add_time_str": "2026-03-21 00:08:28",
                        "_add_time": 1774022908000,
                        "_update_time_str": "2026-03-21 00:08:28",
                        "_update_time": 1774022908000,
                        provider: "tencent"
                    }
                ]
            }
        ],
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("10")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c019a96269070732cd850e"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "9b999c99-b180-4c42-b7d0-5b48464f896a",
    "_add_time": 1774197161284,
    "_add_time_str": "2026-03-23 00:32:41",
    response: {
        rows: {
            _id: ObjectId("69bcbb2e0c34b64800565ec6"),
            "oss_provider": "tencent",
            space: {
                _id: ObjectId("69bd7047fdc08e554a55374a"),
                name: "xxsb-1319368598",
                region: "ap-guangzhou",
                status: NumberInt("1"),
                domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                "_add_time_str": "2026-03-21 00:08:28",
                "_add_time": 1774022908000,
                "_update_time_str": "2026-03-21 00:08:28",
                "_update_time": 1774022908000,
                provider: "tencent"
            }
        },
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("1")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c019c912c656bc5c76f4a3"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "f0ac16a0-504d-4e4e-b323-6368e808dfbd",
    "_add_time": 1774197193010,
    "_add_time_str": "2026-03-23 00:33:13",
    response: {
        rows: {
            _id: ObjectId("69bcbb2e0c34b64800565ec6"),
            "oss_provider": "tencent",
            space: {
                _id: ObjectId("69bd7047fdc08e554a55374a"),
                name: "xxsb-1319368598",
                region: "ap-guangzhou",
                status: NumberInt("1"),
                domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                "_add_time_str": "2026-03-21 00:08:28",
                "_add_time": 1774022908000,
                "_update_time_str": "2026-03-21 00:08:28",
                "_update_time": 1774022908000,
                provider: "tencent"
            }
        },
        hasMore: false,
        total: NumberInt("1"),
        getCount: false,
        pagination: {
            pageIndex: NumberInt("1"),
            pageSize: NumberInt("1")
        },
        msg: "查询成功",
        code: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69c01a2435e854c73269db92"),
    url: "/api/ossProvider",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQxOTQyNDksImV4cCI6MTc3NDc5OTA0OX0.xoO-Gh5x2yGGOFyoQ8mUjQS1sVClAa544H-qtxZvH2c",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "8172306a-49db-4642-989c-c18483637947",
    "_add_time": 1774197284503,
    "_add_time_str": "2026-03-23 00:34:44",
    response: [
        {
            _id: ObjectId("69bcbb2e0c34b64800565ec6"),
            "oss_provider": "tencent",
            space: {
                _id: ObjectId("69bd7047fdc08e554a55374a"),
                name: "xxsb-1319368598",
                region: "ap-guangzhou",
                status: NumberInt("1"),
                domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                "_add_time_str": "2026-03-21 00:08:28",
                "_add_time": 1774022908000,
                "_update_time_str": "2026-03-21 00:08:28",
                "_update_time": 1774022908000,
                provider: "tencent"
            }
        }
    ]
} ]);

// ----------------------------
// Collection structure for qa-menus
// ----------------------------
db.getCollection("qa-menus").drop();
db.createCollection("qa-menus",{
    validationLevel: "off",
    validationAction: "error"
});

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
    component: "/src/pages/system/systemFile/index",
    path: "system/system-file",
    comment: null
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
    component: "/src/pages/system/systemUser/index",
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
    title: "健身管理",
    icon: "AlarmClock",
    "_add_time": NumberLong("1732192614508"),
    "_add_time_str": "2024-11-21 20:36:54",
    enable: true,
    name: "muscle",
    component: "/src/pages/muscle/muscleManage",
    path: "Muscle/muscleManage",
    sort: null,
    comment: null
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
    name: "systemLog",
    comment: null
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
db.createCollection("qa-permissions",{
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: [
                "_id",
                "_add_time",
                "comment",
                "enable",
                "permission_id",
                "permission_name",
                "url"
            ],
            properties: {
                _id: {
                    bsonType: "objectId"
                },
                "_add_time": {
                    bsonType: [
                        "long",
                        "double"
                    ]
                },
                "_add_time_str": {
                    bsonType: "string"
                },
                comment: {
                    bsonType: "string"
                },
                enable: {
                    bsonType: "bool"
                },
                "match_mode": {
                    bsonType: "null"
                },
                "parent_id": {
                    bsonType: "string"
                },
                "permission_id": {
                    bsonType: [
                        "string",
                        "null"
                    ]
                },
                "permission_name": {
                    bsonType: [
                        "string",
                        "null"
                    ]
                },
                sort: {
                    bsonType: "int"
                },
                url: {
                    bsonType: "array",
                    items: {
                        bsonType: "string"
                    }
                }
            }
        }
    },
    validationLevel: "off",
    validationAction: "error"
});

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
        "/app/admin/system/systemUser/systemUser/add",
        "/app/admin/system/systemUser/systemUser/delete",
        "/app/admin/system/systemUser/systemUser/update",
        "/app/admin/system/systemUser/systemUser/getList"
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
        "/app/admin/system/systemMenu/systemMenu/add",
        "/app/admin/system/systemMenu/systemMenu/delete",
        "/app/admin/system/systemMenu/systemMenu/update",
        "/app/admin/system/systemMenu/systemMenu/getList"
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
        "/app/admin/system/systemRole/systemRole/add",
        "/app/admin/system/systemRole/systemRole/delete",
        "/app/admin/system/systemRole/systemRole/update",
        "/app/admin/system/systemRole/systemRole/getList"
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
    url: [ ],
    "match_mode": null
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
        "*/update",
        "*/updateBase"
    ],
    "match_mode": null
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
        "*/getAll",
        "*/getDynamicMenu",
        "*/get"
    ],
    "match_mode": null
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("68f346d5a144c9f3f337272d"),
    "_add_time": NumberLong("1596416400000"),
    comment: "菜单权限",
    enable: true,
    "permission_id": "sys-manage",
    "permission_name": "系统菜单权限",
    sort: NumberInt("0"),
    url: [ ]
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("6958a44b8e9017a5cf7f3819"),
    "permission_id": null,
    "permission_name": null,
    "parent_id": "sys-user-manage",
    url: [ ],
    "match_mode": null,
    enable: true,
    comment: "",
    "_add_time": 1767416907201,
    "_add_time_str": "2026-01-03 13:08:27"
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("696c7462bd8ea0992bb94af9"),
    "permission_id": "sys-manage-permission",
    "permission_name": "系统-权限管理",
    "parent_id": "sys-manage",
    url: [
        "/app/admin/system/systemPermission/*"
    ],
    "match_mode": null,
    enable: true,
    comment: null,
    "_add_time": 1768715362864,
    "_add_time_str": "2026-01-18 13:49:22"
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
    permission: [
        "sys-permission",
        "sys-add",
        "sys-delete",
        "sys-update",
        "sys-read"
    ],
    "role_id": "admin",
    "role_name": "超级管理员",
    no: NumberInt("1"),
    menu: [ ]
} ]);
db.getCollection("qa-roles").insert([ {
    _id: ObjectId("672b1fc518a1950fd5ed565f"),
    "_add_time": NumberLong("1760595008000"),
    "_add_time_str": "2025-10-16 14:10:08",
    comment: "二级管理员-1",
    enable: true,
    permission: [
        "sys-read",
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
    "_add_time": NumberLong("1760598480627"),
    "_add_time_str": "2025-10-16 15:08:00",
    menu: [
        "system",
        "system-uni-uni-id-files",
        "sys-user-manage",
        "sys-role-manage",
        "sys-menus-manage",
        "enable",
        "system-log"
    ],
    permission: [
        "sys-permission",
        "sys-add",
        "sys-delete",
        "sys-update",
        "sys-read",
        "sys-manage",
        "sys-log",
        "sys-user",
        "sys-menu",
        "sys-role",
        "sys-file"
    ]
} ]);

// ----------------------------
// Collection structure for qa-storage-config
// ----------------------------
db.getCollection("qa-storage-config").drop();
db.createCollection("qa-storage-config");

// ----------------------------
// Documents of qa-storage-config
// ----------------------------
db.getCollection("qa-storage-config").insert([ {
    _id: ObjectId("69bcba3b0c34b64800565ea7"),
    provider: "tencent",
    accessKey: "AKIDkhS1MTN3ZszuhH6i6HF0Xv65qNhoiPuH",
    secretKey: "DCyXt286rPn8ezCKN2c7RYSAh3FG8qRs",
    appId: "1319368598"
} ]);

// ----------------------------
// Collection structure for qa-storage-region
// ----------------------------
db.getCollection("qa-storage-region").drop();
db.createCollection("qa-storage-region");

// ----------------------------
// Documents of qa-storage-region
// ----------------------------
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dc7"),
    value: "ap-chengdu",
    label: "成都",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dc8"),
    value: "ap-shanghai",
    label: "上海",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dc9"),
    value: "ap-guangzhou",
    label: "广州",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dca"),
    value: "ap-nanjing",
    label: "南京",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dcb"),
    value: "ap-beijing",
    label: "北京",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dcc"),
    value: "ap-chongqing",
    label: "重庆",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dcd"),
    value: "ap-shenzhen-fsi",
    label: "深圳金融",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dce"),
    value: "ap-shanghai-fsi",
    label: "上海金融",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dcf"),
    value: "ap-beijing-fsi",
    label: "北京金融",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd0"),
    value: "ap-hongkong",
    label: "中国香港",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd1"),
    value: "ap-singapore",
    label: "新加坡",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd2"),
    value: "ap-mumbai",
    label: "孟买",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd3"),
    value: "ap-jakarta",
    label: "雅加达",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd4"),
    value: "ap-seoul",
    label: "首尔",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd5"),
    value: "ap-bangkok",
    label: "曼谷",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd6"),
    value: "ap-tokyo",
    label: "东京",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd7"),
    value: "na-siliconvalley",
    label: "硅谷（美西）",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd8"),
    value: "na-ashburn",
    label: "弗吉尼亚（美东）",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dd9"),
    value: "na-toronto",
    label: "多伦多",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000dda"),
    value: "sa-saopaulo",
    label: "圣保罗",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000ddb"),
    value: "eu-frankfurt",
    label: "法兰克福",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);
db.getCollection("qa-storage-region").insert([ {
    _id: ObjectId("69bf5ce0e1693723e3000ddc"),
    value: "eu-moscow",
    label: "莫斯科",
    "storage_id": "69bcba3b0c34b64800565ea7",
    "_add_time": 1774148832197,
    "_add_time_str": "2026-03-22 11:07:12",
    provider: "tencent"
} ]);

// ----------------------------
// Collection structure for qa-storage-space
// ----------------------------
db.getCollection("qa-storage-space").drop();
db.createCollection("qa-storage-space");

// ----------------------------
// Documents of qa-storage-space
// ----------------------------
db.getCollection("qa-storage-space").insert([ {
    _id: ObjectId("69c0ac6b07807c197dfdb97b"),
    name: "ggdx-1319368598",
    region: "ap-shanghai",
    domain: "https://ggdx-1319368598.cos.ap-shanghai.myqcloud.com",
    provider: "tencent",
    accessKey: "AKIDkhS1MTN3ZszuhH6i6HF0Xv65qNhoiPuH",
    secretKey: "DCyXt286rPn8ezCKN2c7RYSAh3FG8qRs",
    acl: "public-read",
    "_update_time": 1774234731656,
    "_update_time_str": "2026-03-23 10:58:51",
    enable: false,
    "_add_time": 1774234731657,
    "_add_time_str": "2026-03-23 10:58:51"
} ]);
db.getCollection("qa-storage-space").insert([ {
    _id: ObjectId("69c0ac6b07807c197dfdb97d"),
    name: "xxsb-1319368598",
    region: "ap-guangzhou",
    domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
    provider: "tencent",
    accessKey: "AKIDkhS1MTN3ZszuhH6i6HF0Xv65qNhoiPuH",
    secretKey: "DCyXt286rPn8ezCKN2c7RYSAh3FG8qRs",
    acl: "public-read",
    "_update_time": 1774234731679,
    "_update_time_str": "2026-03-23 10:58:51",
    enable: false,
    "_add_time": 1774234731679,
    "_add_time_str": "2026-03-23 10:58:51"
} ]);

// ----------------------------
// Collection structure for qa-test
// ----------------------------
db.getCollection("qa-test").drop();
db.createCollection("qa-test");

// ----------------------------
// Documents of qa-test
// ----------------------------
db.getCollection("qa-test").insert([ {
    _id: ObjectId("695b229e33afcb692b6232de"),
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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3Njc0MjE2MjAsImV4cCI6MTc2ODAyNjQyMH0.x7uk2PpygR0yp_xdA4haxpO1OIjYAJvtE9GBfCn-Ics",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3Njc0MjU0OTMsImV4cCI6MTc2ODAzMDI5M30.MgCbA6J4QqonJMauP1_5h9RjEIDRxSYBLszX-n8QEvg",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3Njc0MjU5MTAsImV4cCI6MTc2ODAzMDcxMH0.T-4yri37SkjNT6kmtxMzM0TVTk6_owcKlV0O8w4DUgM"
    ],
    "last_login_date": NumberLong("1767425910908"),
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
db.getCollection("qa-test").insert([ {
    _id: ObjectId("695b22b933afcb692b6232e2"),
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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NjA3NzQxNDMsImV4cCI6MTc2MTM3ODk0M30.C6KsNTmm3Pp4aM4P20ozpTP7irTscNn-qrfBOIfqHzo",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NjA3NzQ3NTQsImV4cCI6MTc2MTM3OTU1NH0.HaNh7ywd5VxDfL9fbQ8GOU1ClzhI95mgOpfatO9OrIs",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NjA4MzYzNTEsImV4cCI6MTc2MTQ0MTE1MX0.RMhyi1UR0spfHL7waT00op8UF7bIKBWvD8V0EKArTEA"
    ],
    "last_login_date": NumberLong("1760836351787"),
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
    password: "$2b$10$q5gojq/nkjynRaLuZouM8uP35LrSOWFMmbrbRgjpl0.Mi0fT6DmIy",
    role: [
        "admin",
        "agent",
        "test"
    ],
    "_add_time": NumberLong("1730908188567"),
    "_add_time_str": "2024-11-06 23:49:48",
    no: NumberInt("2"),
    image: "https://avatars.githubusercontent.com/u/53579755?v=4",
    avatar: "https://avatars.githubusercontent.com/u/53579755?v=4",
    lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
    token: [
        null,
        null,
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzQyMzAxODMsImV4cCI6MTc3NDgzNDk4M30.oDAdLHlYu--uf-9CHt56S1_0cHdWlUEWP5uQD9GlWMI"
    ],
    "last_login_date": 1774230183324,
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
    },
    enable: true,
    nickname: "yellow12321",
    rate: NumberInt("2"),
    status: NumberInt("0")
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
    avatar: "玩过",
    lastLogin: ISODate("2025-09-04T20:32:41.523Z"),
    token: [
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3MzYsImV4cCI6MTc3NDcwMzUzNn0.aX500m-bsCFWwH1QKTxRAhgpeliBmjUIgw16JAayGMI",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg3NTQsImV4cCI6MTc3NDcwMzU1NH0.yVtNh6HZBV-LCnpZt-b5l5MNejks7iK0ZjDHmx5eIis",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzQwOTg5OTIsImV4cCI6MTc3NDcwMzc5Mn0.mRkBFJY_wxDvt-NiGYJzHlTTp3GvTxG4n6_ENQ5-uvY"
    ],
    "last_login_date": 1774098992205,
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
    },
    enable: true,
    nickname: "1",
    rate: NumberInt("2"),
    status: NumberInt("0")
} ]);
db.getCollection("qa-users").insert([ {
    _id: ObjectId("69b771e8138f8761a51680dc"),
    rate: NumberInt("4"),
    username: "test",
    nickname: "哈哈哈萨达阿萨德",
    password: "$2b$10$mFWkdpnUcsKK.mupwyBcH.DNiwxynvs5EnERuNsemfWFG9foSjc/K",
    avatar: "1123",
    "_add_time": 1773629928986,
    "_add_time_str": "2026-03-16 10:58:48",
    enable: true,
    token: [ ],
    status: NumberInt("0"),
    role: [ ]
} ]);
