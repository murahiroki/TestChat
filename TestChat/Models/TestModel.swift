//
//  TestModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

// "users"コレクションモデル
struct usersTable {
    var id: Int
    var userName: String
}
var usersModel: Array<usersTable> = [
    usersTable.init(id: 1, userName: "一郎"),
    usersTable.init(id: 2, userName: "二郎"),
    usersTable.init(id: 3, userName: "三郎"),
]

// "friends"コレクションモデル
struct friendsTable {
    var id: Int
    var hostName: String
    var friendName: String
}
var friendsTestModel: Array<friendsTable> = [
    friendsTable.init(id: 1, hostName: "一郎", friendName: "二郎"),
    friendsTable.init(id: 2, hostName: "一郎", friendName: "三郎"),
    friendsTable.init(id: 3, hostName: "二郎", friendName: "一郎"),
    friendsTable.init(id: 4, hostName: "三郎", friendName: "一郎"),
]

// "rooms"コレクションモデル
struct roomsTable {
    var id: Int
    var hostName: String
    var roomName: String
}
var roomsTestModel: Array<roomsTable> = [
    roomsTable.init(id: 1, hostName: "一郎", roomName: "二郎"),
    roomsTable.init(id: 2, hostName: "一郎", roomName: "三郎"),
    roomsTable.init(id: 3, hostName: "二郎", roomName: "一郎"),
    roomsTable.init(id: 4, hostName: "三郎", roomName: "一郎"),
]

// "messages"コレクションモデル
struct messagesTable {
    var id: Int
    var fromName: String
    var toName: String
    var message: String
    var time: String
}
var messagesTestModel: Array<messagesTable> = [
    messagesTable.init(id: 1, fromName: "一郎", toName: "二郎", message: "二郎さん", time: "2022年1月2日 03:07:06"),
    messagesTable.init(id: 2, fromName: "一郎", toName: "二郎", message: "こんにちは。", time: "2022年1月2日 03:07:10"),
    messagesTable.init(id: 3, fromName: "二郎", toName: "一郎", message: "一郎さん", time: "2022年1月2日 10:12:06"),
    messagesTable.init(id: 4, fromName: "二郎", toName: "一郎", message: "こんにちは。", time: "2022年1月2日 10:12:10"),
]
