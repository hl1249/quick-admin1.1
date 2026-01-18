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

 Date: 18/01/2026 13:51:53
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
    _id: ObjectId("68e778d9c635e46a2c8c4b82"),
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
    requestId: "e1de129c-05e6-4d99-80e0-0b2015499a29",
    "_add_time": 1760000217615,
    "_add_time_str": "2025-10-09 16:56:57",
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
    _id: ObjectId("68e778dec635e46a2c8c4b88"),
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
    requestId: "a745ba84-c395-4aba-879b-afa03e080a91",
    "_add_time": 1760000222572,
    "_add_time_str": "2025-10-09 16:57:02",
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
    _id: ObjectId("68e778dfc635e46a2c8c4b8e"),
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
    requestId: "3a7a1df8-8c5c-4a73-89c4-ed9582483482",
    "_add_time": 1760000223755,
    "_add_time_str": "2025-10-09 16:57:03",
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
    title: "健身管理1",
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
        "*/getAll",
        "*/getDynamicMenu"
    ]
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
    menu: [
        "sys-menus-manage",
        "system"
    ]
} ]);
db.getCollection("qa-roles").insert([ {
    _id: ObjectId("672b1fc518a1950fd5ed565f"),
    "_add_time": NumberLong("1760595008000"),
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
    }
} ]);
