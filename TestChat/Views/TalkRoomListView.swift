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
    
    @ObservedObject var roomsModel = RoomsModel()
    @EnvironmentObject var cm : CommonObject                 // 全てのViewで使える変数
    
    var body: some View {
        List(roomsModel.rooms, id: \.id) { i in
            ZStack() {
                if i.hostName ==  cm.myName {
                    MessageRow(friendName: i.roomName, lastMessage: "最後に送られてきたor送ったメッセージ", lastTime: "00:00")
                    NavigationLink(destination: MessageView(friendName: i.roomName)) {
                        EmptyView() // 各リストの下に空ビューを置いてリストを押したら画面遷移するように擬似的に見せる(NavigationLinkの「>」を消すために必要らしい)
                    }
                    .opacity(0)     // NavigationLinkの「>」を消す
                }
            }
            .listRowSeparator(.hidden)  // リストの仕切りを消す
        }
        .listStyle(GroupedListStyle()) // リストの外枠をなくす(画面の両端ギリギリまで使うため)
        .onAppear {
            // トークリスト画面の背景を白色にしたいけどこれだとメッセージ画面からこの画面に戻ると空色になっている
            UITableView.appearance().backgroundColor = UIColor(Color.white)
        }

    }
    
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            TalkRoomListView()
        }
    }
}
