//
//  MessageView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct MessageView: View {
    // メッセージ画面の背景色(空色)
    //    init() {
    //        UITableView.appearance().backgroundColor = UIColor(red: 0.5843, green: 0.7529, blue: 0.9255, alpha: 1.0)
    //    }
    // トークルームリスト画面に戻るボタンの名前を相手の名前にカスタマイズするために必要
    @Environment(\.dismiss) var dismiss
    
    var myName = "" // 自分の名前
    var friendName = "" // 戻るボタンを相手の名前にするための変数
    @ObservedObject var messegeModel = MessegeModel()
    @State var typeMessage = ""
    
    var body: some View {
        VStack {
            List(messegeModel.messages, id: \.id) {i in
                if i.hostName == self.myName {
                    ChatBubble(message: i.message, isMyMessage: true)
                        .listStyle(GroupedListStyle()) // リストの外枠を消す
                } else {
                    ChatBubble(message: i.message, isMyMessage: false)
                        .listStyle(GroupedListStyle()) // リストの外枠を消す
                }
            }
            ZStack {
                HStack {
                    Image(systemName: "camera")// カメラ起動&撮影写真の送信(実装予定)
                    Image(systemName: "photo.artframe")// ライブラリー写真追加ボタン(実装予定)
                    // TextFieldは1行入力用らしいのでTextEditorを使う
                    // 高さ可変のTextEditorがSwiftUI単体では現状不可能なので自作 -> DynamicHeightTextview.swift
                    DynamicHeightTextEditor(text: $typeMessage, placeholder: "Aa", minHeight: 35, maxHeight: 160)
                    Button(action: {
                        if typeMessage != "" {
                            // メッセージが入力されていれば送信
                            // ToDo 送信したらテキストエディタの大きさを元に戻したいけどどうやるのかわからん
                            self.messegeModel.addMessage(message: self.typeMessage, hostUser: self.myName)
                            self.typeMessage = ""
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

// プレビュー確認用
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
