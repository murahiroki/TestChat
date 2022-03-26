//
//  TalkRoomListView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct TalkRoomListView: View {
    /*
     トークルームリストの背景色を白にしたいけど適応されない。(空色になっている)
     たぶん各トークルームの行をNavigationLinkでメッセージ画面に遷移させるようにすると
     メッセージ画面の背景がトークルームリストにも影響する？
     */
    var body: some View {
        List(messageListTable, id: \.id) { messageListTable in
            ZStack() {
                MessageRow(friendName: messageListTable.friend, lastMessage: messageListTable.last_message, lastTime: messageListTable.last_time)
                NavigationLink(destination: MessageView(friendName: messageListTable.friend)) {
                    EmptyView() // 各リストの下に空ビューを置いてリストを押したら画面遷移するように擬似的に見せる(NavigationLinkの「>」を消すために必要らしい)
                }
                .opacity(0)     // NavigationLinkの「>」を消す
            }
            .listRowSeparator(.hidden)  // リストの仕切りを消す
        }
        .listStyle(GroupedListStyle()) // リストの外枠をなくす(画面の両端ギリギリまで使うため)
    }
    
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            TalkRoomListView()
        }
    }
}
