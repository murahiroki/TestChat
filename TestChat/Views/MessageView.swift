//
//  MessageView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct MessageView: View {
    
    @Environment(\.dismiss) var dismiss                     // トークルームリスト画面に戻るボタンの名前を相手の名前にカスタマイズするために必要
    @ObservedObject var messagesModel = MessagesModel()       // "messages"コレクションモデル
    @EnvironmentObject var cm : CommonObject                // 全てのViewで使える変数
    @State var typeMessage = ""                             // 送るメッセージ格納用変数
    var friendName = ""                                     // やり取りしているフレンド名
    let dt = Date()                                         // 現在時刻取得用
    let dateFormatter = DateFormatter()                     // 現在時刻取得用
    
    var body: some View {
        VStack {
            List(messagesModel.messages, id: \.id) {i in
                if (i.toName == friendName && i.fromName == cm.myName) || (i.toName == cm.myName && i.fromName == friendName) {
                    // 自分から選んだフレンドに送ったメッセージもしくは、選んだフレンドが自分宛に送ったメッセージのみ表示する
                    if i.fromName == cm.myName {
                        // 自分のメッセージは右よせ
                        ChatBubble(message: i.message, isMyMessage: true, time: i.time)
                            .listStyle(GroupedListStyle()) // リストの外枠を消す
                    } else {
                        // 相手のメッセージは左よせ
                        ChatBubble(message: i.message, isMyMessage: false, time: i.time)
                            .listStyle(GroupedListStyle()) // リストの外枠を消す
                    }
                }
            }
            .onAppear {
                // メッセージ画面の背景を空色にする(タブ画面に戻った時にタブ画面も空色になる)
                UITableView.appearance().backgroundColor = UIColor(red: 0.5843, green: 0.7529, blue: 0.9255, alpha: 1.0)
            }
            ZStack {
                HStack {
                    Image(systemName: "camera")// カメラ起動&撮影写真の送信(実装予定)
                    Image(systemName: "photo.artframe")// ライブラリー写真追加ボタン(実装予定)
                    // ↓TextFieldは1行入力用らしいのでTextEditorを使う
//                    TextField("Aa",text: $typeMessage)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    // 高さ可変のTextEditorがSwiftUI単体では現状不可能なので自作 -> DynamicHeightTextview.swift
                    // ↓色々問題があるので使うのは一旦保留(表示キーボードがバグる、テキストエディタの高さは可変になるけどメッセージ送信後後も変化した高さが保持される)
//                    DynamicHeightTextEditor(text: $typeMessage, placeholder: "Aa", minHeight: 35, maxHeight: 160)
                    TextEditor(text: $typeMessage)
                        .frame(width: nil, height: 35)
                        .border(Color.black)
                    Button(action: {
                        if typeMessage != "" {
                            // メッセージが入力されていれば送信
                            // ToDo 送信したらテキストエディタの大きさを元に戻したいけどどうやるのかわからん
                            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
                            messagesModel.addMessage(fromName: cm.myName, toName: friendName, message: typeMessage, time: dateFormatter.string(from: dt))
                            typeMessage = ""
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                    }
                }.padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        // トークルームリスト画面に戻るボタンの名前を相手の名前にカスタマイズする
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        HStack{
                            Text("＜")
                            Text(friendName)
                        }
                    }
                ).tint(.black)
            }
        }
        .padding(.bottom, 15.0)     // 下の隙間間隔を15に固定して上はTextEditorの行数によって可変になるようにする
    }
}
