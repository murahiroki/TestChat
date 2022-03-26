//
//  ChatModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct ChatBubble: View {
    var message = ""
    var isMymessage = false
    
    var body: some View {
        HStack {
            if isMymessage {
                // 自分のメッセージは右寄り
                Spacer()
                Text(message)
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(40)
                    .foregroundColor(Color.black)
                    .font(.footnote)
                    .frame(width: 232, height: nil, alignment: .trailing)
            } else {
                // 相手のメッセージは左寄り
                HStack() {
                    TalkRoomIcon()
                        .frame(width: 40, height: 40, alignment: .bottom)
                        .padding(.top, 5.0)
                    Text(message)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(6)
                        .foregroundColor(Color.black)
                        .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.black))
                        .font(.footnote)
                        .frame(width: 232, height: nil, alignment: .leading)
                }
                Spacer()
            }
        }
        .listRowSeparator(.hidden)          // リスト表示した時に各リストの間にある仕切りを表示しない
        .padding(.horizontal, -10.0)        // 画面の両端ギリギリまで使う
        .listRowBackground(Color.clear)     // 各メッセージの背景色(MessageViewに表示した時に背景を同化させるため)
    }
    
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            // 試しにリスト表示してみる
            List(testMessage, id: \.id) { testMessage in
                ChatBubble(message: testMessage.message, isMymessage: testMessage.ismy)
                    .listRowSeparator(.hidden)
            }
            .listStyle(GroupedListStyle()) // リストの外枠をなくす(画面の両端ギリギリまで使うため)
        }
    }
}
