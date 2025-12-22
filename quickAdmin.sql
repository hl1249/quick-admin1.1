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

 Date: 22/12/2025 17:58:23
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
    _id: ObjectId("68e73412133974dcd6ba3b12"),
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
    requestId: "b26c3a1a-5f72-47fd-8e65-516258dbfd53",
    "_add_time": 1759982610253,
    "_add_time_str": "2025-10-09 12:03:30",
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
    _id: ObjectId("68e88428a65dfb1f0206a27b"),
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
    requestId: "550e45c4-fa86-4999-b306-0aa115af5dbe",
    "_add_time": 1760068648926,
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
    _id: ObjectId("68ec5cd84ef2a4b6b64b2485"),
    "user_id": "1008",
    "_add_time": 1760320728489,
    "_add_time_str": "2025-10-13 09:58:48"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68ec5cdb4ef2a4b6b64b248d"),
    "user_id": "10081",
    "_add_time": 1760320731499,
    "_add_time_str": "2025-10-13 09:58:51"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68ec5e134ef2a4b6b64b24aa"),
    "user_id": "我叼你妈",
    "_add_time": 1760321043454,
    "_add_time_str": "2025-10-13 10:04:03"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68ec5e1e4ef2a4b6b64b24bd"),
    "user_id": "我叼你妈的",
    "_add_time": 1760321054724,
    "_add_time_str": "2025-10-13 10:04:14"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68ec5e484ef2a4b6b64b24c5"),
    "user_id": "我叼你妈的",
    "_add_time": 1760321096330,
    "_add_time_str": "2025-10-13 10:04:56"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68ec5e5c4ef2a4b6b64b24d8"),
    "user_id": "自定义文案",
    "_add_time": 1760321116006,
    "_add_time_str": "2025-10-13 10:05:16"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68eda4c08ffc792b4b04bce0"),
    "user_id": "我叼你妈的",
    "_add_time": 1760404672922,
    "_add_time_str": "2025-10-14 09:17:52"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68eda4c38ffc792b4b04bce8"),
    "user_id": "我叼你妈的",
    "_add_time": 1760404675617,
    "_add_time_str": "2025-10-14 09:17:55"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68eda9518ffc792b4b04bcf7"),
    "user_id": "我叼你妈的",
    "_add_time": 1760405841181,
    "_add_time_str": "2025-10-14 09:37:21"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68eda9f48ffc792b4b04bd14"),
    "user_id": "我叼你妈的",
    "_add_time": 1760406004714,
    "_add_time_str": "2025-10-14 09:40:04"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68edaad28ffc792b4b04bd2e"),
    "user_id": "我叼你妈的",
    "_add_time": 1760406226061,
    "_add_time_str": "2025-10-14 09:43:46"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68edab1d8ffc792b4b04bd41"),
    "user_id": "我叼你妈的",
    "_add_time": 1760406301404,
    "_add_time_str": "2025-10-14 09:45:01"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68edab3b8ffc792b4b04bd59"),
    "user_id": "自定义文案",
    date1: 1759680000000,
    "_add_time": 1760406331992,
    "_add_time_str": "2025-10-14 09:45:31"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68edac2e8ffc792b4b04bd6f"),
    "user_id": "到底是SB",
    "_add_time": 1760406574498,
    "_add_time_str": "2025-10-14 09:49:34"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68edaf3a8ffc792b4b04bdc9"),
    "user_id": "assda",
    "_add_time": 1760407354131,
    "_add_time_str": "2025-10-14 10:02:34"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68f043c40dcd5301a935f106"),
    "user_id": "插槽的数据",
    "_add_time": 1760576452739,
    "_add_time_str": "2025-10-16 09:00:52"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68f044170dcd5301a935f10e"),
    "user_id": "我叼你妈的",
    "_add_time": 1760576535582,
    "_add_time_str": "2025-10-16 09:02:15"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68f0512c0dcd5301a935f12d"),
    "user_id": "21321",
    "_add_time": 1760579884878,
    "_add_time_str": "2025-10-16 09:58:04"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68f436cd732bed4455fa51de"),
    "user_id": "11123",
    "_add_time": 1760835277402,
    "_add_time_str": "2025-10-19 08:54:37"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68f43780732bed4455fa5233"),
    "user_id": "21312",
    "_add_time": 1760835456975,
    "_add_time_str": "2025-10-19 08:57:36"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68f4378e732bed4455fa523b"),
    "user_id": "12345",
    "_add_time": 1760835470293,
    "_add_time_str": "2025-10-19 08:57:50"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("68f437b8732bed4455fa5243"),
    "user_id": "12345",
    "_add_time": 1760835512760,
    "_add_time_str": "2025-10-19 08:58:32"
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
        "sys-permission",
        "sys-add",
        "sys-delete",
        "sys-update",
        "sys-read",
        "sys-log",
        "sys-user",
        "sys-menu",
        "sys-file",
        "sys-manage"
    ],
    "role_id": "agent",
    "role_name": "代理商",
    no: NumberInt("2"),
    menu: [
        "sys-role-manage",
        "system"
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
        null,
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjYzOTYyNTQsImV4cCI6MTc2NzAwMTA1NH0.FOOdf5w_Hmov-tmEbVmp93VcDeyLamRTNHGVtWZzy1s",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NjYzOTYzMDIsImV4cCI6MTc2NzAwMTEwMn0.YDdJ0_G2jjt8U0vJ3DvAHq7Rw9XEtZEsdjRmGwGLu_0"
    ],
    "last_login_date": 1766396302740,
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
