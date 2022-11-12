//
//  HomeView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct FriendListView: View {
    
    @EnvironmentObject var cm : CommonObject                // 全てのViewで使える変数
    @ObservedObject var friendsModel = FriendsModel()       // "friens"コレクションモデル
    
    var body: some View {
        List(friendsModel.friends, id: \.id) { i in
            if i.hostName == cm.myName {
                // 自分のフレンドのみリスト表示(ユーザーが増えると処理が遅くなる可能性あり)
                // フレンドリストをタップするとフレンドプロフィール画面へ遷移
                NavigationLink(destination: FriendProfileView(friendName: i.friendName)) {
                    FriendRow(friendName: i.friendName)
                }
                .listRowSeparator(.hidden)  // リストの仕切りを消す
            }
        }
        .listStyle(GroupedListStyle()) // リストの外枠を消す
        .onAppear {
            // メッセージ画面の背景を空色にしたいけどこれだとタブ画面も空色になる
            UITableView.appearance().backgroundColor = UIColor(Color.white)
        }
    }
}
