//
//  ChatModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct ChatBubble: View {
    var message = ""
    var isMyMessage = false
    var time = "2000年1月1日 23:59:59"
    
    var body: some View {
        let startIndex = time.index(time.firstIndex(of: " ")!, offsetBy: 1)     // 時間情報文字列から最初の" "+1のインデックス番号を取得
        let lastIndex = time.index(time.lastIndex(of: ":")!, offsetBy: -1)      // 時間情報文字列から最後の":"-1のインデックス番号を取得
        let substring = time[startIndex...lastIndex]                            // 時間情報文字列から時分のみを取得して表示する
        HStack {
            if isMyMessage {
                // 自分のメッセージは右寄り
                Spacer()
                Text(substring)
                    .foregroundColor(Color.gray)
                    .font(.footnote)
                    .padding(.top)
                    .frame(width: nil, height: nil, alignment: .trailing)
                Text(message)
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(40)
                    .foregroundColor(Color.black)
                    .font(.footnote)
                    .frame(width: nil, height: nil, alignment: .trailing)
            } else {
                // 相手のメッセージは左寄り
                HStack() {
                    TalkRoomIcon()
                        .frame(width: 40, height: 40, alignment: .bottom)
                        .padding(.top, 5.0)
                    Text(message)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(40)
                            .foregroundColor(Color.black)
                            .font(.footnote)
                            .frame(width: nil, height: nil, alignment: .leading)
                    Text(substring)
                        .foregroundColor(Color.gray)
                        .font(.footnote)
                        .padding(.top)
                    
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
            List(messagesTestModel, id: \.id) { messagesTestModel in
                if (messagesTestModel.toName == "二郎" && messagesTestModel.fromName == "一郎") || (messagesTestModel.toName == "一郎" && messagesTestModel.fromName == "二郎") {
                    // 自分から選んだフレンドに送ったメッセージもしくは、選んだフレンドが自分宛に送ったメッセージのみ表示する
                    if messagesTestModel.fromName == "一郎" {
                        // 自分のメッセージは右よせ
                        ChatBubble(message: messagesTestModel.message, isMyMessage: true, time: messagesTestModel.time)
                            .listStyle(GroupedListStyle()) // リストの外枠を消す
                    } else {
                        // 相手のメッセージは左よせ
                        ChatBubble(message: messagesTestModel.message, isMyMessage: false, time: messagesTestModel.time)
                            .listStyle(GroupedListStyle()) // リストの外枠を消す
                    }
                }
            }
            .onAppear {
                // メッセージ画面の背景を空色にしたいけどこれだとタブ画面も空色になる
                UITableView.appearance().backgroundColor = UIColor(red: 0.5843, green: 0.7529, blue: 0.9255, alpha: 1.0)
            }
            .listStyle(GroupedListStyle()) // リストの外枠をなくす(画面の両端ギリギリまで使うため)
        }
    }
}
