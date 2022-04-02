//
//  HomeView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct FriendListView: View {
    var body: some View {
        List(friendTable, id: \.id) { friendTable in
            NavigationLink(destination: FriendProfileView()) {
                FriendRow(friendTable: friendTable)
            }
            .listRowSeparator(.hidden)  // リストの仕切りを消す
        }
        .listStyle(GroupedListStyle()) // リストの外枠を消す
        .onAppear {
            // メッセージ画面の背景を空色にしたいけどこれだとタブ画面も空色になる
            UITableView.appearance().backgroundColor = UIColor(Color.white)
        }
    }
}
