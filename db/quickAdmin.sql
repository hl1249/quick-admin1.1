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

 Date: 25/04/2026 13:39:56
*/


// ----------------------------
// Collection structure for custom
// ----------------------------
db.getCollection("custom").drop();
db.createCollection("custom",{
    validator: {
        $jsonSchema: {
            bsonType: "object",
            properties: {
                username: {
                    bsonType: "string"
                },
                password: {
                    bsonType: "string"
                },
                age: {
                    bsonType: "int"
                },
                sex: {
                    bsonType: "int"
                },
                groupId: {
                    bsonType: [
                        "int",
                        "string"
                    ]
                }
            },
            required: [
                "username",
                "password"
            ]
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

// ----------------------------
// Documents of custom
// ----------------------------
db.getCollection("custom").insert([ {
    _id: ObjectId("69db06ba99ec443353ad8768"),
    username: "1",
    password: "1234561",
    age: NumberInt("15"),
    sex: NumberInt("0"),
    groupId: "video",
    "_add_time": 1775961786850,
    "_add_time_str": "2026-04-12 10:43:06"
} ]);

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
    "oss_provider": "tencent",
    "_update_time": 1776736244925,
    "_update_time_str": "2026-04-21 09:50:44"
} ]);

// ----------------------------
// Collection structure for qa-appids
// ----------------------------
db.getCollection("qa-appids").drop();
db.createCollection("qa-appids",{
    validator: {
        $jsonSchema: {
            bsonType: "object",
            properties: {
                appid: {
                    bsonType: "string"
                },
                secret: {
                    bsonType: "string"
                },
                appname: {
                    bsonType: "string"
                }
            },
            required: [
                "appid",
                "secret",
                "appname"
            ]
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

// ----------------------------
// Documents of qa-appids
// ----------------------------
db.getCollection("qa-appids").insert([ {
    _id: ObjectId("69dcbcb474ed375188bf790c"),
    appid: "wx65f51726f2c3e73a",
    secret: "05b6d16e2563d186a3912ee3af6991b0",
    appname: "呱呱工具箱",
    "_add_time": 1776073908631,
    "_add_time_str": "2026-04-13 17:51:48",
    "pay_config": "69e6db05e2352f74ec8d3fc4"
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
    _id: ObjectId("69cc8711e67959fa820633e3"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "file",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775011601277-d85a032b45a046d1bd4395f0dc9d1d66.txt",
    "display_name": "1775011601277-d85a032b45a046d1bd4395f0dc9d1d66.txt",
    "original_name": "1.txt",
    size: NumberInt("0"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775011601277-d85a032b45a046d1bd4395f0dc9d1d66.txt",
    provider: "tencent",
    width: null,
    height: null,
    "category_id": null,
    "_add_time": 1775011601549,
    "_add_time_str": "2026-04-01 10:46:41"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69cdc5811b35ba12433f2878"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "file",
    url: "http://file.xxsb.games/attach/2026/04/1775093121110-8dbf303e834747efa84a113cfadec9f1.json",
    "display_name": "1775093121110-8dbf303e834747efa84a113cfadec9f1.json",
    "original_name": "HeapSnapshot-strings-20260330T140052.json",
    size: NumberInt("5432200"),
    "file_id": "http://file.xxsb.games/attach/2026/04/1775093121110-8dbf303e834747efa84a113cfadec9f1.json",
    provider: "qiniu",
    width: null,
    height: null,
    "category_id": null,
    "_add_time": 1775093121668,
    "_add_time_str": "2026-04-02 09:25:21"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69cdce541b35ba12433f28eb"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "file",
    url: "http://file.xxsb.games/attach/2026/04/1775095380611-68f0a10705c544fdafb4af0f638cc4f1.json",
    "display_name": "1775095380611-68f0a10705c544fdafb4af0f638cc4f1.json",
    "original_name": "a.json",
    size: NumberInt("19779"),
    "file_id": "http://file.xxsb.games/attach/2026/04/1775095380611-68f0a10705c544fdafb4af0f638cc4f1.json",
    provider: "qiniu",
    width: null,
    height: null,
    "category_id": null,
    "_add_time": 1775095380730,
    "_add_time_str": "2026-04-02 10:03:00"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69cf4bec73b752fd836bc77b"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775193068096-87e945655796412ca64843274dcb8496.png",
    "display_name": "1775193068096-87e945655796412ca64843274dcb8496.png",
    "original_name": "彭帅的简历 - 副本 (3).png",
    size: NumberInt("3779334"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775193068096-87e945655796412ca64843274dcb8496.png",
    provider: "tencent",
    width: NumberInt("820"),
    height: NumberInt("1150"),
    "category_id": "69ce0893139664eda4dc2da0",
    "_add_time": 1775193068711,
    "_add_time_str": "2026-04-03 13:11:08",
    "_update_time": 1775395884323,
    "_update_time_str": "2026-04-05 21:31:24"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69cf646c89210344a23817b4"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775199339995-045c72b93a524053a2c855c5b22ebef2.png",
    "display_name": "1775199339995-045c72b93a524053a2c855c5b22ebef2.png",
    "original_name": "1774885904094.png",
    size: NumberInt("97925"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775199339995-045c72b93a524053a2c855c5b22ebef2.png",
    provider: "tencent",
    width: NumberInt("1416"),
    height: NumberInt("863"),
    "category_id": "69ce0893139664eda4dc2da0",
    "_add_time": 1775199340309,
    "_add_time_str": "2026-04-03 14:55:40",
    "_update_time": 1775395884323,
    "_update_time_str": "2026-04-05 21:31:24"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69cf647389210344a23817b9"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775199347587-0b0bd3e2989d40439f807424c974c6ab.png",
    "display_name": "1775199347587-0b0bd3e2989d40439f807424c974c6ab.png",
    "original_name": "1774885904094.png",
    size: NumberInt("97925"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775199347587-0b0bd3e2989d40439f807424c974c6ab.png",
    provider: "tencent",
    width: NumberInt("1416"),
    height: NumberInt("863"),
    "category_id": "69ce0893139664eda4dc2da0",
    "_add_time": 1775199347668,
    "_add_time_str": "2026-04-03 14:55:47",
    "_update_time": 1775395884323,
    "_update_time_str": "2026-04-05 21:31:24"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69cf8bce067a4fb3b8190247"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "video",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775209417779-b89a44076c084b78a35228d432769487.mp4",
    "display_name": "1775209417779-b89a44076c084b78a35228d432769487.mp4",
    "original_name": "1774884031863-59b15c7f315147a19a536f51bfd507d0.mp4",
    size: NumberInt("34408377"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775209417779-b89a44076c084b78a35228d432769487.mp4",
    provider: "tencent",
    width: null,
    height: null,
    "category_id": null,
    "_add_time": 1775209422796,
    "_add_time_str": "2026-04-03 17:43:42"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69cf8c21067a4fb3b819026f"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775209505385-7dba4eb7a46e45919fba540cdbd73847.png",
    "display_name": "1775209505385-7dba4eb7a46e45919fba540cdbd73847.png",
    "original_name": "1774885904094.png",
    size: NumberInt("97925"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775209505385-7dba4eb7a46e45919fba540cdbd73847.png",
    provider: "tencent",
    width: NumberInt("1416"),
    height: NumberInt("863"),
    "category_id": null,
    "_add_time": 1775209505645,
    "_add_time_str": "2026-04-03 17:45:05"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69cf8c5e067a4fb3b8190282"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775209565828-661ef56c5f6a43608a8f38b352fef401.png",
    "display_name": "1775209565828-661ef56c5f6a43608a8f38b352fef401.png",
    "original_name": "1774885904094.png",
    size: NumberInt("97925"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775209565828-661ef56c5f6a43608a8f38b352fef401.png",
    provider: "tencent",
    width: NumberInt("1416"),
    height: NumberInt("863"),
    "category_id": null,
    "_add_time": 1775209566235,
    "_add_time_str": "2026-04-03 17:46:06"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69d0dde9dc4bd4536df7f5f8"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775295976714-d6f83dc623684dffa0a6362220c04043.png",
    "display_name": "1775295976714-d6f83dc623684dffa0a6362220c04043.png",
    "original_name": "image.png",
    size: NumberInt("488785"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775295976714-d6f83dc623684dffa0a6362220c04043.png",
    provider: "tencent",
    width: NumberInt("1902"),
    height: NumberInt("2440"),
    "category_id": null,
    "_add_time": 1775295977155,
    "_add_time_str": "2026-04-04 17:46:17"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69d12643f0c26718ed7524b2"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775314499711-fbb21afdcd854ca9b47ea7b523cf99f5.png",
    "display_name": "1775314499711-fbb21afdcd854ca9b47ea7b523cf99f5.png",
    "original_name": "黄弱的液体",
    size: NumberInt("351112"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775314499711-fbb21afdcd854ca9b47ea7b523cf99f5.png",
    provider: "tencent",
    width: NumberInt("503"),
    height: NumberInt("580"),
    "category_id": null,
    "_add_time": 1775314499847,
    "_add_time_str": "2026-04-04 22:54:59",
    "_update_time": 1775314514647,
    "_update_time_str": "2026-04-04 22:55:14"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69d12657f0c26718ed7524bf"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775314519043-20609096afa944c0941635ef5ad97bd8.png",
    "display_name": "1775314519043-20609096afa944c0941635ef5ad97bd8.png",
    "original_name": "亮猛的液体",
    size: NumberInt("380547"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775314519043-20609096afa944c0941635ef5ad97bd8.png",
    provider: "tencent",
    width: NumberInt("616"),
    height: NumberInt("624"),
    "category_id": null,
    "_add_time": 1775314519111,
    "_add_time_str": "2026-04-04 22:55:19",
    "_update_time": 1775314526637,
    "_update_time_str": "2026-04-04 22:55:26"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69d5321340fba40bb8b8c66f"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775579667244-441c7e5fe8be49faa5446d28ada1a3a2.png",
    "display_name": "1775579667244-441c7e5fe8be49faa5446d28ada1a3a2.png",
    "original_name": "image (4).png",
    size: NumberInt("497407"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775579667244-441c7e5fe8be49faa5446d28ada1a3a2.png",
    provider: "tencent",
    width: NumberInt("1179"),
    height: NumberInt("2556"),
    "category_id": null,
    "_add_time": 1775579667535,
    "_add_time_str": "2026-04-08 00:34:27"
} ]);
db.getCollection("qa-files").insert([ {
    _id: ObjectId("69e6d7fae2352f74ec8d3f86"),
    "user_id": "672b901c0fcabce5e29faef5",
    sort: NumberInt("0"),
    status: NumberInt("0"),
    type: "image",
    url: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1776736250523-1b33696a29d945eabb96487019354e3d.jpg",
    "display_name": "1776736250523-1b33696a29d945eabb96487019354e3d.jpg",
    "original_name": "2QkSWzRYu0W.jpg",
    size: NumberInt("202472"),
    "file_id": "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1776736250523-1b33696a29d945eabb96487019354e3d.jpg",
    provider: "tencent",
    width: NumberInt("1216"),
    height: NumberInt("2640"),
    "category_id": null,
    "_add_time": 1776736250902,
    "_add_time_str": "2026-04-21 09:50:50"
} ]);

// ----------------------------
// Collection structure for qa-files-categories
// ----------------------------
db.getCollection("qa-files-categories").drop();
db.createCollection("qa-files-categories");

// ----------------------------
// Documents of qa-files-categories
// ----------------------------
db.getCollection("qa-files-categories").insert([ {
    _id: ObjectId("69ca88cd031c8f39933d18e3"),
    type: "video",
    name: "默认视频组",
    "_add_time": 1774880973018,
    "_add_time_str": "2026-03-30 22:29:33"
} ]);
db.getCollection("qa-files-categories").insert([ {
    _id: ObjectId("69ce0893139664eda4dc2da0"),
    type: "image",
    name: "默认图片组",
    url: null,
    "_add_time": NumberLong("1775110291856"),
    "_add_time_str": "2026-04-02 14:11:31"
} ]);

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
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d12704f0c26718ed752583"),
    "user_id": "32412",
    "_add_time": 1775314692958,
    "_add_time_str": "2026-04-04 22:58:12"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d12710f0c26718ed752589"),
    "user_id": "黄弱啊",
    "_add_time": 1775314704707,
    "_add_time_str": "2026-04-04 22:58:24"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d12714f0c26718ed75258f"),
    "user_id": "亮猛啊",
    "_add_time": 1775314708856,
    "_add_time_str": "2026-04-04 22:58:28"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d1c4bb9111338ca2a67b2d"),
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
    requestId: "d9ab26c0-9607-4e0c-8678-aef2187337a9",
    "_add_time": 1775355067034,
    "_add_time_str": "2026-04-05 10:11:07",
    response: [
        {
            _id: ObjectId("69bcbb2e0c34b64800565ec6"),
            "oss_provider": "tencent",
            "_update_time": 1775144887292,
            "_update_time_str": "2026-04-02 23:48:07",
            space: {
                _id: ObjectId("69c7393fed1c1af21a3f1dcf"),
                name: "xxsb-1319368598",
                region: "ap-guangzhou",
                domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
                provider: "tencent",
                accessKey: "AKIDkhS1MTN3ZszuhH6i6HF0Xv65qNhoiPuH",
                secretKey: "DCyXt286rPn8ezCKN2c7RYSAh3FG8qRs",
                acl: "public-read",
                creationDate: "2026-03-19T15:14:38Z",
                "_update_time": 1774876713603,
                "_update_time_str": "2026-03-30 21:18:33",
                enable: true,
                "_add_time": 1774663999193,
                "_add_time_str": "2026-03-28 10:13:19"
            }
        }
    ]
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d1c5efc99b6367abd23b05"),
    url: "/api/dbList",
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
    requestId: "b9e069fd-5fec-48ea-8821-e2b0eb58b43d",
    "_add_time": 1775355375586,
    "_add_time_str": "2026-04-05 10:16:15",
    response: [
        {
            name: "qa-permissions",
            type: "collection",
            options: {
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
            },
            info: {
                readOnly: false,
                uuid: UUID("0f5a74a0-e141-4cd2-94e2-f6909bb9c31d")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-roles",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("414873f7-1c98-4a2f-9f1f-b5a18e911e3a")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-storage-space",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("4da4d1aa-6f0d-4c75-b14c-c6a3aa861d53")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-test",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("654f61af-061c-4f6c-989e-eb0d94221315")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-files-categories",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("97329a0b-0a89-4f5a-962a-af2a32a10a52")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-storage-config",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("9a44c589-78a1-453f-99eb-f2a3200d5cf4")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-files",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("b2e4dea0-f406-4dfb-9ef7-3cee0c89f21b")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-users",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("cba37cb6-f028-4b89-8a49-bd6197059064")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-app-config",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("d7b90e9d-ac85-4f32-984c-48f0cdeb0304")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-menus",
            type: "collection",
            options: {
                validationLevel: "off",
                validationAction: "error"
            },
            info: {
                readOnly: false,
                uuid: UUID("ef057bda-c864-47d1-a5c8-2689dd8ca919")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        },
        {
            name: "qa-logs",
            type: "collection",
            options: { },
            info: {
                readOnly: false,
                uuid: UUID("f64f5672-7d6a-4ada-aca4-b32d8f24d2a6")
            },
            idIndex: {
                v: NumberInt("2"),
                key: {
                    _id: NumberInt("1")
                },
                name: "_id_"
            }
        }
    ]
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d29650bcdf29b83b2e34f1"),
    url: "/api",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "43.139.63.227",
        "x-real-ip": "185.150.191.165",
        "x-forwarded-for": "185.150.191.165",
        connection: "upgrade",
        "user-agent": "Umai-Scanner/1.0 (+https://umai.entelijan.com/methodology)",
        accept: "text/html, application/json, */*",
        "accept-language": "*",
        "sec-fetch-mode": "cors",
        "accept-encoding": "br, gzip, deflate"
    },
    body: null,
    requestId: "0dab4cde-6598-4ea8-ab75-a5e046b9df2c",
    "_add_time": 1775408720737,
    "_add_time_str": "2026-04-06 01:05:20",
    response: {
        acknowledged: true,
        deletedCount: NumberInt("0")
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d5b77415d653328440943d"),
    code: NumberInt("500"),
    "_add_time": 1775613812631,
    "_add_time_str": "2026-04-08 10:03:32"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d5b7a115d653328440944c"),
    statusCode: NumberInt("500"),
    "_add_time": 1775613857608,
    "_add_time_str": "2026-04-08 10:04:17"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d5b7ac15d653328440945e"),
    statusCode: NumberInt("200"),
    "_add_time": 1775613868752,
    "_add_time_str": "2026-04-08 10:04:28"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d70c92f9cd4e085884b0d0"),
    url: "/api/findByWhereJson",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3Njg3OTU2MDEsImV4cCI6MTc2OTQwMDQwMX0.plua9EAL0R-MmEwFOYBteQ1YJIxgqhTtVpxwcI4YxAk",
        "user-agent": "Apifox/1.0.0 (https://apifox.com)",
        accept: "*/*",
        host: "127.0.0.1:3000",
        "accept-encoding": "gzip, deflate, br",
        connection: "keep-alive"
    },
    body: null,
    requestId: "78ba5576-8d9a-449a-b9ad-af24e7c5592a",
    "_add_time": 1775701138616,
    "_add_time_str": "2026-04-09 10:18:58",
    response: {
        _id: ObjectId("672b901c0fcabce5e29faef5"),
        username: "admin",
        password: "$2b$10$MRvFGZuSJqfCWKBhBbirPePjC17AqOF5SJiJwG0WInmvo..NYYAbi",
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
            null,
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzU2OTcxODYsImV4cCI6MTc3NjMwMTk4Nn0.Eqd62utWi-UZzFiMrkILiRb1h_Kqa65wrRd_RkSoW18"
        ],
        "last_login_date": 1775697186412,
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
        wdf: null
    }
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69d70cb0320307a618e1f58f"),
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
    requestId: "30de3cc7-0f94-4399-9e9f-b00afb934df8",
    "_add_time": 1775701168359,
    "_add_time_str": "2026-04-09 10:19:28",
    response: {
        rows: [
            {
                _id: ObjectId("672b901c0fcabce5e29faef5"),
                username: "admin",
                password: "$2b$10$MRvFGZuSJqfCWKBhBbirPePjC17AqOF5SJiJwG0WInmvo..NYYAbi",
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
                    null,
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzU2OTcxODYsImV4cCI6MTc3NjMwMTk4Nn0.Eqd62utWi-UZzFiMrkILiRb1h_Kqa65wrRd_RkSoW18"
                ],
                "last_login_date": 1775697186412,
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
                wdf: null
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
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzU1Nzg5NjAsImV4cCI6MTc3NjE4Mzc2MH0.XFDU-Zzig17wO2AMXJojVij3X7nQVqZoBeyL8sC65fw",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzU1Nzg5NjMsImV4cCI6MTc3NjE4Mzc2M30.gkLJLEaFlO5Mo06HSGTt7l3OywvXL-tVeqDLKN_9B2I",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzU1NzkyNjksImV4cCI6MTc3NjE4NDA2OX0.DmTkaDYwApR4HrcEE0jWA7k7waO4f1V7tzEOgS9MBEQ"
                ],
                "last_login_date": 1775579269545,
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
                wdf: null
            }
        ],
        hasMore: false,
        total: NumberInt("2"),
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
    _id: ObjectId("69d7b2cee81d8a4acaf006ab"),
    statusCode: NumberInt("500"),
    "_add_time": 1775743694602,
    "_add_time_str": "2026-04-09 22:08:14"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69dcb84301bd3d988525012a"),
    "_add_time": 1776072771012,
    "_add_time_str": "2026-04-13 17:32:51"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69dcb84301bd3d988525012c"),
    "_add_time": 1776072771753,
    "_add_time_str": "2026-04-13 17:32:51"
} ]);
db.getCollection("qa-logs").insert([ {
    _id: ObjectId("69e26d552140395234b65f77"),
    url: "/api",
    method: "GET",
    statusCode: NumberInt("200"),
    headers: {
        host: "43.139.63.227:3000",
        "user-agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36",
        accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
        "accept-encoding": "gzip, deflate",
        "accept-language": "zh-CN,zh;q=0.9",
        "cache-control": "max-age=0",
        "upgrade-insecure-requests": "1"
    },
    body: null,
    requestId: "ff9b3191-604d-47f4-8c86-e987b5019316",
    "_add_time": 1776446805299,
    "_add_time_str": "2026-04-18 01:26:45",
    response: {
        acknowledged: true,
        deletedCount: NumberInt("0")
    }
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
    icon: "User",
    "menu_id": "system",
    title: "用户角色权限",
    name: "system",
    sort: "110",
    component: null,
    "parent_id": null,
    path: null,
    comment: null
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("672b209618a1950fd5ed570c"),
    "_add_time": NumberLong("1596416400000"),
    enable: true,
    icon: "FolderOpened",
    "menu_id": "system-uni-uni-id-files",
    title: "素材管理",
    name: "systemFile",
    "parent_id": "system-setting",
    sort: "2",
    component: "/src/pages/system/systemFile/index",
    path: "system/system-file",
    comment: null
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("672dc39fef2124dea37e285d"),
    "_add_time": NumberLong("1596416400000"),
    comment: "1个角色可以分配多个角色",
    enable: true,
    icon: "User",
    "menu_id": "sys-user-manage",
    title: "系统用户管理",
    name: "systemUser",
    "parent_id": "system",
    sort: "1",
    component: "/src/pages/system/systemUser/index",
    path: "system/system-user"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("672dc3c2ef2124dea37e285e"),
    "_add_time": NumberLong("1596416400000"),
    comment: "1个角色可以分配多个权限和菜单",
    enable: true,
    icon: "UserFilled",
    "menu_id": "sys-role-manage",
    title: "角色管理",
    name: "systemRole",
    "parent_id": "system",
    sort: "3",
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
    _id: ObjectId("6740620e947e19874d59330d"),
    "parent_id": "system-setting",
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
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("69cbea2224f1c31e7a581a0c"),
    "menu_id": "system-setting",
    title: "系统设置",
    "parent_id": null,
    component: null,
    icon: "Setting",
    path: null,
    enable: true,
    comment: "",
    "_add_time": NumberLong("1774971426024"),
    "_add_time_str": "2026-03-31 23:37:06",
    sort: "110"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("69db3f8580721c7f0e298e66"),
    "menu_id": "system-setting-socket",
    title: "ws连接管理",
    "parent_id": "system-setting",
    component: "/src/pages/system/systemSocket",
    path: "system/system-socket",
    enable: true,
    comment: "",
    icon: "TurnOff",
    sort: "0",
    "_add_time": NumberLong("1775976325513"),
    "_add_time_str": "2026-04-12 14:45:25",
    name: "systemSocket"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("69dcb98075758f2b09a61601"),
    "menu_id": "sys-appid",
    title: "小程序管理",
    name: "微信小程序管理",
    "parent_id": "system-setting",
    component: "/src/pages/system/sysAppid",
    path: null,
    enable: true,
    comment: "",
    icon: "ChatLineRound",
    sort: "0",
    "_add_time": 1776073088324,
    "_add_time_str": "2026-04-13 17:38:08"
} ]);
db.getCollection("qa-menus").insert([ {
    _id: ObjectId("69e04c963b56c132251aef68"),
    "menu_id": "system-setting-pay-config",
    title: "支付配置",
    name: "支付配置",
    "parent_id": "system-setting",
    component: "/src/pages/system/systemPayConfig",
    path: null,
    enable: true,
    comment: "",
    icon: "Money",
    sort: "0",
    "_add_time": 1776307350480,
    "_add_time_str": "2026-04-16 10:42:30"
} ]);

// ----------------------------
// Collection structure for qa-pay-config
// ----------------------------
db.getCollection("qa-pay-config").drop();
db.createCollection("qa-pay-config",{
    validator: {
        $jsonSchema: {
            bsonType: "object",
            properties: {
                type: {
                    bsonType: "string"
                },
                mchId: {
                    bsonType: "string"
                },
                key: {
                    bsonType: "string"
                },
                pfx: {
                    bsonType: "string"
                },
                version: {
                    bsonType: "string"
                }
            },
            required: [
                "type"
            ]
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

// ----------------------------
// Documents of qa-pay-config
// ----------------------------
db.getCollection("qa-pay-config").insert([ {
    _id: ObjectId("69e6db05e2352f74ec8d3fc4"),
    type: "wx-mini",
    mchId: "商户ID",
    key: "成",
    pfx: "成",
    version: "成",
    "_add_time": 1776737029792,
    "_add_time_str": "2026-04-21 10:03:49"
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
    ],
    "match_mode": null
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
        "/app/admin/system/systemUser/systemUser/getList"
    ],
    "match_mode": null
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
        "/app/admin/system/systemMenu/systemMenu/getList"
    ],
    "match_mode": null
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
        "/app/admin/system/systemRole/systemRole/getList"
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
    "parent_id": "sys-manage",
    sort: NumberInt("1"),
    url: [
        "/app/admin/system/systemFile/systemFile/*"
    ],
    "match_mode": null
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
        "/app/admin/system/systemPermission/systemPermission/getList"
    ],
    "match_mode": null,
    enable: true,
    comment: null,
    "_add_time": 1768715362864,
    "_add_time_str": "2026-01-18 13:49:22"
} ]);
db.getCollection("qa-permissions").insert([ {
    _id: ObjectId("69dc6817c24f89e5d23356fc"),
    "permission_id": "sys-manage-socket",
    "permission_name": "ws连接管理",
    "parent_id": "sys-manage",
    url: [
        "/app/admin/system/sysSocketPool/sysSocketPool/*"
    ],
    "match_mode": null,
    enable: true,
    comment: null,
    "_add_time": 1776052247497,
    "_add_time_str": "2026-04-13 11:50:47"
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
        "sys-manage",
        "sys-log",
        "sys-user",
        "sys-menu",
        "sys-role",
        "sys-file",
        "sys-manage-permission",
        "sys-manage-socket"
    ],
    "role_id": "agent",
    "role_name": "代理商",
    no: NumberInt("2"),
    menu: [
        "system-permission",
        "system-setting-socket",
        "system",
        "system-setting"
    ]
} ]);

// ----------------------------
// Collection structure for qa-schemas
// ----------------------------
db.getCollection("qa-schemas").drop();
db.createCollection("qa-schemas");

// ----------------------------
// Documents of qa-schemas
// ----------------------------
db.getCollection("qa-schemas").insert([ {
    _id: ObjectId("69d5c0ee0cb30e56b1f6c6fa"),
    name: "test",
    fields: [
        {
            id: "8s0lzb8bfag",
            key: "username",
            bsonType: "string",
            description: "",
            required: true,
            typeRules: {
                string: { }
            },
            formType: "text",
            formConfig: {
                placeholder: "用户名"
            }
        },
        {
            id: "nvyngvh57d",
            key: "password",
            bsonType: "string",
            description: "",
            required: true,
            typeRules: {
                string: { }
            },
            formType: "password",
            formConfig: {
                placeholder: "密码"
            }
        },
        {
            id: "cqdaa7vrczj",
            key: "age",
            bsonType: "int",
            description: "",
            required: false,
            typeRules: {
                int: { }
            },
            formType: "number",
            formConfig: {
                step: NumberInt("1"),
                placeholder: "年龄"
            }
        },
        {
            id: "secdhpuy66",
            key: "sex",
            bsonType: "int",
            description: "",
            required: false,
            typeRules: {
                int: { }
            },
            formType: "select",
            formConfig: {
                dataValueType: "number",
                placeholder: "性别",
                data: [
                    {
                        value: NumberInt("0"),
                        label: "男"
                    },
                    {
                        value: NumberInt("1"),
                        label: "女"
                    }
                ]
            }
        },
        {
            id: "yvzet1ekvas",
            key: "groupId",
            bsonType: [
                "int",
                "string"
            ],
            description: "",
            required: false,
            typeRules: {
                int: { },
                string: { }
            },
            formType: "remote-select",
            formConfig: {
                placeholder: "班级",
                action: "/app/admin/system/systemFile/systemCategories/getList",
                propsValue: "type",
                propsLabel: "name"
            }
        },
        {
            id: "tek8r0fcg",
            key: "radio",
            bsonType: "string",
            description: "",
            required: false,
            typeRules: {
                string: { }
            },
            formType: "switch",
            formConfig: {
                useCustomSwitchValue: true,
                switchValueType: "string",
                placeholder: "测试",
                activeValue: "芜湖",
                inactiveValue: "大司马"
            }
        }
    ],
    required: [
        "username",
        "password"
    ],
    jsonSchema: {
        bsonType: "object",
        properties: {
            username: {
                bsonType: "string"
            },
            password: {
                bsonType: "string"
            },
            age: {
                bsonType: "int"
            },
            sex: {
                bsonType: "int"
            },
            groupId: {
                bsonType: [
                    "int",
                    "string"
                ]
            },
            radio: {
                bsonType: "string"
            }
        },
        required: [
            "username",
            "password"
        ]
    },
    fieldCount: NumberInt("6"),
    "_update_time": 1776065303581,
    "_add_time": 1775616238069,
    "_add_time_str": "2026-04-08 10:43:58"
} ]);
db.getCollection("qa-schemas").insert([ {
    _id: ObjectId("69d70efd09b2dcfd66540985"),
    name: "fuck",
    fields: [
        {
            id: "o5l8xcpckp",
            key: "",
            bsonType: "string",
            description: "",
            required: false,
            typeRules: {
                string: { }
            }
        },
        {
            id: "np2tqpks8je",
            key: "",
            bsonType: "string",
            description: "",
            required: false,
            typeRules: {
                string: { }
            }
        }
    ],
    required: [ ],
    jsonSchema: {
        bsonType: "object",
        properties: { }
    },
    fieldCount: NumberInt("0"),
    "_update_time": 1775706952628,
    "_add_time": 1775701757072,
    "_add_time_str": "2026-04-09 10:29:17"
} ]);
db.getCollection("qa-schemas").insert([ {
    _id: ObjectId("69d7b1cee81d8a4acaf00693"),
    name: "黄弱",
    fields: [ ],
    required: [ ],
    jsonSchema: {
        bsonType: "object",
        properties: { }
    },
    fieldCount: NumberInt("0"),
    "_update_time": 1775961403383,
    "_add_time": 1775743438047,
    "_add_time_str": "2026-04-09 22:03:58"
} ]);
db.getCollection("qa-schemas").insert([ {
    _id: ObjectId("69dcac4d6ddf2d7f59ff6f5f"),
    name: "qa-appids",
    fields: [
        {
            id: "sdotixsqolc",
            key: "appid",
            bsonType: "string",
            description: "",
            required: true,
            typeRules: {
                string: { }
            },
            formType: "text",
            formConfig: {
                placeholder: "小程序APPID"
            }
        },
        {
            id: "8j6j2ml7in9",
            key: "secret",
            bsonType: "string",
            description: "",
            required: true,
            typeRules: {
                string: { }
            },
            formType: "text",
            formConfig: {
                placeholder: "小程序秘钥"
            }
        },
        {
            id: "kbx15ocfzxj",
            key: "appname",
            bsonType: "string",
            description: "",
            required: true,
            typeRules: {
                string: { }
            },
            formType: "text",
            formConfig: {
                placeholder: "小程序名"
            }
        }
    ],
    required: [
        "appid",
        "secret",
        "appname"
    ],
    jsonSchema: {
        bsonType: "object",
        properties: {
            appid: {
                bsonType: "string"
            },
            secret: {
                bsonType: "string"
            },
            appname: {
                bsonType: "string"
            }
        },
        required: [
            "appid",
            "secret",
            "appname"
        ]
    },
    fieldCount: NumberInt("3"),
    "_update_time": 1776072958014,
    "_add_time": 1776069709381,
    "_add_time_str": "2026-04-13 16:41:49"
} ]);
db.getCollection("qa-schemas").insert([ {
    _id: ObjectId("69e0475ba775d25f9dd1b49d"),
    name: "qa-pay-config",
    fields: [
        {
            id: "r5dwau7qwn",
            key: "type",
            title: "支付类型",
            bsonType: "string",
            description: "",
            required: true,
            typeRules: {
                string: { }
            },
            formType: "select",
            formConfig: {
                dataValueType: "string",
                multiple: false,
                data: [
                    {
                        value: "wx-mini",
                        label: "微信小程序支付"
                    },
                    {
                        value: "wx-h5",
                        label: "微信H5支付"
                    }
                ],
                placeholder: "支付类型"
            }
        },
        {
            id: "4irxv72kkbo",
            key: "mchId",
            title: "商户ID",
            bsonType: "string",
            description: "",
            required: false,
            typeRules: {
                string: { }
            }
        },
        {
            id: "je6ewr1l8wg",
            key: "key",
            title: "v2证书key",
            bsonType: "string",
            description: "",
            required: false,
            typeRules: {
                string: { }
            }
        },
        {
            id: "y4foez8ljim",
            key: "pfx",
            title: "p12转base64",
            bsonType: "string",
            description: "",
            required: false,
            typeRules: {
                string: { }
            }
        },
        {
            id: "s2my9a9esgl",
            key: "version",
            title: "密钥版本",
            bsonType: "string",
            description: "",
            required: false,
            typeRules: {
                string: { }
            }
        }
    ],
    required: [
        "type"
    ],
    jsonSchema: {
        bsonType: "object",
        properties: {
            type: {
                bsonType: "string"
            },
            mchId: {
                bsonType: "string"
            },
            key: {
                bsonType: "string"
            },
            pfx: {
                bsonType: "string"
            },
            version: {
                bsonType: "string"
            }
        },
        required: [
            "type"
        ]
    },
    fieldCount: NumberInt("5"),
    "_update_time": 1776921337475,
    "_add_time": 1776306011157,
    "_add_time_str": "2026-04-16 10:20:11"
} ]);

// ----------------------------
// Collection structure for qa-socket-pool
// ----------------------------
db.getCollection("qa-socket-pool").drop();
db.createCollection("qa-socket-pool");

// ----------------------------
// Documents of qa-socket-pool
// ----------------------------

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
db.getCollection("qa-storage-config").insert([ {
    _id: ObjectId("69c0b5edd5ae2d553e65b11a"),
    accessKey: "LTAI5tDN2aw1RKondrswFT3w",
    provider: "aliyun",
    secretKey: "iKCzvV1wkhtbiVZuJmzjCDtXNNQcoX"
} ]);
db.getCollection("qa-storage-config").insert([ {
    _id: ObjectId("69c0b852dff8fe39b542d462"),
    accessKey: "3xu7T5Z6A5f35D08xdVg8G6bTqus9ALP6kcaCEjP",
    provider: "qiniu",
    secretKey: "RMXwJd_s5EP308CSr5mcY8mfAXRwaK80XcDUcmUq"
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
    _id: ObjectId("69c1685d783ca4935ad1614a"),
    name: "xxsb10086",
    region: "oss-cn-beijing",
    domain: "http://fileali.xxsb.games",
    provider: "aliyun",
    accessKey: "LTAI5tDN2aw1RKondrswFT3w",
    secretKey: "iKCzvV1wkhtbiVZuJmzjCDtXNNQcoX",
    acl: null,
    creationDate: "2026-03-23T03:41:27.000Z",
    "_update_time": 1774876718857,
    "_update_time_str": "2026-03-30 21:18:38",
    enable: true,
    "_add_time": 1774282845840,
    "_add_time_str": "2026-03-24 00:20:45",
    cdn: null
} ]);
db.getCollection("qa-storage-space").insert([ {
    _id: ObjectId("69c3bbf6a42b37e1bc3ef287"),
    name: "testhrssdsa",
    region: "oss-cn-hangzhou",
    domain: "https://testhrssdsa.oss-cn-hangzhou.aliyuncs.com",
    provider: "aliyun",
    accessKey: "LTAI5tDN2aw1RKondrswFT3w",
    secretKey: "iKCzvV1wkhtbiVZuJmzjCDtXNNQcoX",
    acl: null,
    creationDate: "2026-03-23T03:47:33.000Z",
    "_update_time": 1774435326431,
    "_update_time_str": "2026-03-25 18:42:06",
    enable: false,
    "_add_time": 1774435318079,
    "_add_time_str": "2026-03-25 18:41:58",
    cdn: null
} ]);
db.getCollection("qa-storage-space").insert([ {
    _id: ObjectId("69c7393fed1c1af21a3f1dcf"),
    name: "xxsb-1319368598",
    region: "ap-guangzhou",
    domain: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com",
    provider: "tencent",
    accessKey: "AKIDkhS1MTN3ZszuhH6i6HF0Xv65qNhoiPuH",
    secretKey: "DCyXt286rPn8ezCKN2c7RYSAh3FG8qRs",
    acl: "public-read",
    creationDate: "2026-03-19T15:14:38Z",
    "_update_time": 1774876713603,
    "_update_time_str": "2026-03-30 21:18:33",
    enable: true,
    "_add_time": 1774663999193,
    "_add_time_str": "2026-03-28 10:13:19"
} ]);
db.getCollection("qa-storage-space").insert([ {
    _id: ObjectId("69c74bfe41fc4773be1ba7cb"),
    name: "newxxsb",
    region: "oss-cn-beijing",
    domain: "https://newxxsb.oss-cn-beijing.aliyuncs.com",
    provider: "aliyun",
    acl: "public-read",
    accessKey: "LTAI5tDN2aw1RKondrswFT3w",
    secretKey: "iKCzvV1wkhtbiVZuJmzjCDtXNNQcoX",
    enable: false,
    "_update_time": 1774876718102,
    "_update_time_str": "2026-03-30 21:18:38",
    "_add_time": 1774668798188,
    "_add_time_str": "2026-03-28 11:33:18"
} ]);
db.getCollection("qa-storage-space").insert([ {
    _id: ObjectId("69c7fb6367216e588922e07d"),
    name: "test-1319368598",
    region: "ap-guangzhou",
    domain: "https://filetencent.xxsb.games",
    provider: "tencent",
    accessKey: "AKIDkhS1MTN3ZszuhH6i6HF0Xv65qNhoiPuH",
    secretKey: "DCyXt286rPn8ezCKN2c7RYSAh3FG8qRs",
    acl: "public-read",
    creationDate: "2026-03-25T10:26:33Z",
    "_update_time": 1774876712537,
    "_update_time_str": "2026-03-30 21:18:32",
    enable: false,
    "_add_time": 1774713699658,
    "_add_time_str": "2026-03-29 00:01:39",
    cdn: null
} ]);
db.getCollection("qa-storage-space").insert([ {
    _id: ObjectId("69c9ee452c2278065f0c0a6c"),
    name: "xxsb",
    region: "z2",
    domain: "http://file.xxsb.games",
    provider: "qiniu",
    accessKey: "3xu7T5Z6A5f35D08xdVg8G6bTqus9ALP6kcaCEjP",
    secretKey: "RMXwJd_s5EP308CSr5mcY8mfAXRwaK80XcDUcmUq",
    acl: null,
    creationDate: null,
    "_update_time": 1775031907344,
    "_update_time_str": "2026-04-01 16:25:07",
    enable: true,
    "_add_time": 1774841413334,
    "_add_time_str": "2026-03-30 11:30:13",
    cdn: null
} ]);
db.getCollection("qa-storage-space").insert([ {
    _id: ObjectId("69c9ee452c2278065f0c0a6e"),
    name: "xxsvs",
    region: "na0",
    domain: "",
    provider: "qiniu",
    accessKey: "3xu7T5Z6A5f35D08xdVg8G6bTqus9ALP6kcaCEjP",
    secretKey: "RMXwJd_s5EP308CSr5mcY8mfAXRwaK80XcDUcmUq",
    acl: null,
    creationDate: null,
    "_update_time": 1774841413351,
    "_update_time_str": "2026-03-30 11:30:13",
    enable: false,
    "_add_time": 1774841413351,
    "_add_time_str": "2026-03-30 11:30:13"
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
    password: "$2b$10$KygUBQF9cCA.Xj8aopjW.ObWnEWe7seNtjcUKr4czluBMOV8jhWKG",
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
        null,
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzJiOTAxYzBmY2FiY2U1ZTI5ZmFlZjUiLCJpYXQiOjE3NzY5MjEyMTksImV4cCI6MTc3NzUyNjAxOX0.rLc0qpbmLK9o2M7lx0yKk67XEATGdtX9qV_9ymls5U8"
    ],
    "last_login_date": 1776921219462,
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
    nickname: "陈强",
    rate: NumberInt("2"),
    status: NumberInt("0"),
    wdf: null
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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzU3MjE4MTAsImV4cCI6MTc3NjMyNjYxMH0.aGaBsM212jOSvgtNOT2QhoaGsDeoUB7KFxk7wLVraI4",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzU3MjIzMzMsImV4cCI6MTc3NjMyNzEzM30.z3CsnoEOrG4rqL4pXWs9I0RrAHYapg19bFx6l6XzUXE",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGJiMjBiOTRmOGM0MDY2MTU1NmYyN2MiLCJpYXQiOjE3NzU5NzQwNjAsImV4cCI6MTc3NjU3ODg2MH0.ubn4Mh7L47iXkcdCsCnC5uMSWX3kTBR0o9tMu61_rSc"
    ],
    "last_login_date": 1775974060387,
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
    wdf: null
} ]);
db.getCollection("qa-users").insert([ {
    _id: ObjectId("69d77359a70e45d90689cba4"),
    username: "admin",
    nickname: "阿萨姆",
    password: "123123",
    "is_login": true,
    "_add_time": 1775727449950,
    "_add_time_str": "2026-04-09 17:37:29",
    avatar: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775579667244-441c7e5fe8be49faa5446d28ada1a3a2.png",
    enable: true,
    rate: NumberInt("0"),
    image: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775579667244-441c7e5fe8be49faa5446d28ada1a3a2.png",
    userInfo: {
        name: "小明",
        age: NumberInt("18"),
        avatar: "https://xxsb-1319368598.cos.ap-guangzhou.myqcloud.com/attach/2026/04/1775579667244-441c7e5fe8be49faa5446d28ada1a3a2.png",
        nickname: "你猜"
    }
} ]);
db.getCollection("qa-users").insert([ {
    _id: ObjectId("69e6eb3d9fa307657847c812"),
    appid: "wx65f51726f2c3e73a",
    appname: "呱呱工具箱",
    openid: "oMc8F5Cm4Utv6AhNfX7f14ZZDOdM",
    unionid: null,
    nickname: "XG5E28",
    role: [ ],
    token: [
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWU2ZWIzZDlmYTMwNzY1Nzg0N2M4MTIiLCJpYXQiOjE3NzY3NDExODEsImV4cCI6MTc3NzM0NTk4MX0.OIuPNxwFw9f_0YMGUoYCahfzwXY87gzCoU5M3eKf6jo",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWU2ZWIzZDlmYTMwNzY1Nzg0N2M4MTIiLCJpYXQiOjE3NzY3NDEyMTUsImV4cCI6MTc3NzM0NjAxNX0.WsCiOUZ13RsaSFyEUApECh-mv4WcMXiuigKbzUzgLuQ",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWU2ZWIzZDlmYTMwNzY1Nzg0N2M4MTIiLCJpYXQiOjE3NzY5MTA5ODUsImV4cCI6MTc3NzUxNTc4NX0.NREk0dAgQYB63KfR8OKazA7I6BpmQOI7EJ4ClFiLoBI"
    ],
    enable: true,
    "_add_time": 1776741181939,
    "_add_time_str": "2026-04-21 11:13:01",
    "last_login_date": 1776910985911,
    "last_login_ip": "未知IP"
} ]);
