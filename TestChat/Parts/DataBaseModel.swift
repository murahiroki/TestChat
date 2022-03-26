//
//  DataBaseModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

// ホームタブ画面のフレンドリスト一覧用
struct FriendTable {
    var id: Int
    var host_name: String
    var friend_name: String
}

// メッッセージタブ画面のフレンド一覧用
struct MessageListTable {
    var id: Int
    var friend: String
    var last_message: String
    var last_time: String
}

// メッセージ内容
struct TestMessage {
    var id: Int
    var ismy: Bool
    var message: String
    var time: String
}
