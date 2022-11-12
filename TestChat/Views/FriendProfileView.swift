//
//  FriendProfileView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct FriendProfileView: View {
    
    @ObservedObject var roomsModel = RoomsModel()            // "rooms"コレクションモデル
    @EnvironmentObject var cm : CommonObject                 // 全てのViewで使える変数
    @State private var shouldshowmessageView: Bool = false   // この値がtrueになったらMessageViewに遷移する(ボタンを押したら画面遷移するロジックのために必要)
    var friendName: String = ""                              // フレンドリストから選んだフレンド名格納用変数
    
    var body: some View {
        VStack {
            Text("フレンドのプロフィールを表示予定")
            Text("とりあえず\(friendName)とメッセージのやり取りをするボタンだけ配置")
            NavigationLink(destination: MessageView(friendName: friendName), isActive: $shouldshowmessageView) {
                EmptyView()
            }
            Button {
#if MYDEBUG
                // cm.myNameを使う処理はなぜかプレビューできないのでプレビュー用ルートを用意
#else
                // 遷移と同時にフレンドとのトークルームを作る
                roomsModel.addRoom(hostName: cm.myName, roomName: friendName)
                // フレンドとのトークルームを作ると同時に相手側にも自分とのトークルームを強制的に作成
                //roomsModel.addRoom(hostName: friendName, roomName: cm.myName)
#endif
                // ボタン押した時にMessageViewに画面遷移
                shouldshowmessageView = true
            } label: {
                Text("メッセージ")
            }
        }
    }
#if MYDEBUG
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            FriendProfileView()
        }
    }
#endif
}
