//
//  FriendRow.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct FriendRow: View {
    var friendName: String
    
    var body: some View {
        HStack {
            TalkRoomIcon().frame(width: 50, height: 50)
            Text(friendName)
        }
        .padding(.horizontal, -10.0)    // 画面の両端ギリギリまで使う
        .listRowSeparator(.hidden)      // リスト表示した時に各リストの間にある仕切りを表示しない
    }
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            // 試しにメッセージリストを表示してみる
            List(friendsTestModel, id: \.id) { friendsTestModel in
                // 一郎としてログインしている想定で表示
                if friendsTestModel.hostName ==  "一郎" {
                    FriendRow(friendName: friendsTestModel.friendName)
                }
            }
            .listStyle(GroupedListStyle()) // リストの外枠をなくす(画面の両端ギリギリまで使うため)
        }
    }
}
