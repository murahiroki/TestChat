//
//  TestModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

var friendTable: Array<FriendTable> = [FriendTable.init(id: 1, host_name: "My Account", friend_name: "Test User1"),
                                       FriendTable.init(id: 2, host_name: "My Account", friend_name: "Test User2"),
                                       FriendTable.init(id: 3, host_name: "My Account", friend_name: "Test User3"),
                                       FriendTable.init(id: 4, host_name: "My Account", friend_name: "Test user4"),
                                       FriendTable.init(id: 5, host_name: "My Account", friend_name: "Test User5"),
]

var messageListTable: Array <MessageListTable> = [MessageListTable.init(id: 1, friend: "Test User1",
                                                                        last_message: "最後のメッセージああああああああああああああああああああ", last_time: "12:27"),
                                                  MessageListTable.init(id: 2, friend: "Test User2",
                                                                        last_message: "最後のメッセージ", last_time: "22:45"),
                                                  MessageListTable.init(id: 3, friend: "Test User3",
                                                                        last_message: "最後のメッセージ", last_time: "8:24"),
                                                  MessageListTable.init(id: 4, friend: "Test User4",
                                                                        last_message: "最後のメッセージ", last_time: "4:22"),
                                                  ]

var testMessage: Array <TestMessage> = [TestMessage.init(id: 1, ismy: false, message: "相手メッセージ", time: "12:26"),
                                        TestMessage.init(id: 2, ismy: true, message: "自分メッセージ", time: "12:27"),
                                        TestMessage.init(id: 3, ismy: false, message: "aaaaaaaaaaaaaaaaaaaaaaaaaaa", time: "12:28"),
                                        TestMessage.init(id: 4, ismy: true, message: "ああああああああああああああああ", time: "12:29"),
                                        TestMessage.init(id: 5, ismy: false, message: "ああああああああああああああああ", time: "12:30"),
                                        TestMessage.init(id: 6, ismy: true, message: "aaaaaaaaaaaaaaaaaaaaaaaaaaa", time: "12:31"),
]


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
