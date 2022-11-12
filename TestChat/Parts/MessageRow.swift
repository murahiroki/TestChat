//
//  MessageRow.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct MessageRow: View {
    var friendName = ""
    var lastMessage = ""
    var lastTime = ""
    
    var body: some View {
        HStack {
            TalkRoomIcon()
                .frame(width: 50, height: 50)
            //.background(Color.cyan)
            VStack(alignment: .leading){
                Text(friendName)
                Text(lastMessage)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            .frame(width: nil, height: 60, alignment: .leading)
            //.background(Color.blue)
            Spacer()
            
            Text(lastTime)
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(.horizontal, -10.0)    // 画面の両端ギリギリまで使う
        .listRowSeparator(.hidden)      // リスト表示した時に各リストの間にある仕切りを表示しない
        
    }
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            // 試しにメッセージリストを表示してみる
            List(roomsTestModel, id: \.id) { roomsTestModel in
                // Test1としてログインしている想定で表示
                if roomsTestModel.hostName ==  "一郎" {
                    MessageRow(friendName: roomsTestModel.roomName, lastMessage: "最後に送られてきたor送ったメッセージ", lastTime: "00:00")
                }
            }
            .listStyle(GroupedListStyle()) // リストの外枠をなくす(画面の両端ギリギリまで使うため)
        }
    }
}
