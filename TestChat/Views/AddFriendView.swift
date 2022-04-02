//
//  FriendAddView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

// フレンド追加画面
struct AddFriendView: View {
    
    @EnvironmentObject var cm : CommonObject                // 全てのViewで使える変数
    @ObservedObject var friendsModel = FriendsModel()       // "friends"コレクション関連の宣言
    @State var friendName = ""                              // 追加するフレンド用変数
    @State private var isShowAlert: Bool = false            // ポップアップアラート用変数
    
    var body: some View {
        VStack {
            TextField("検索するフレンド名 ", text: $friendName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()  // 見栄え良くするために上下左右に隙間を入れる
            
            if friendName != "" {
                Button(action: {
                    // ここでfriendsコレクションにフレンド追加する関数を呼び出す
                    friendsModel.addFriend(hostName: cm.myName, friendName: friendName)
                    isShowAlert = true
                    friendName = ""
                }){
                    Text("追加")
                }
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text("追加完了"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
