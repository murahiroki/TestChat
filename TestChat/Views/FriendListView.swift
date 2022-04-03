//
//  HomeView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct FriendListView: View {
    
    @ObservedObject var friendsModel = FriendsModel()
    
    var body: some View {
        List(friendsModel.friends, id: \.id) { i in
            NavigationLink(destination: FriendProfileView()) {
                FriendRow(friendName: i.friendName)
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
