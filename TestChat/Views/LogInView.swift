//
//  LogInView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

//// アプリ全体で共有するプロパティ
//class ObsevedFuga: ObservableObject {
//    @Published var myName = ""  // ログイン名格納変数
//}
// ログイン画面
struct LogInView: View {
    
//    @EnvironmentObject var object: ObsevedFuga
    @State var myName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // 200×200で自分のアイコンを表示(タップするとフォトライブラリから画像選択できる)
                ImageSetIcon(iconWidth: 200, iconHeight: 200)
                
                // 名前の入力欄
//                TextField("名前 ", text: $object.myName)
                TextField("名前 ", text: $myName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()  // 見栄え良くするために上下左右に隙間を入れる
                
                // ログインボタン
//                if object.myName != "" {
                if myName != "" {
                    // 名前が入力されたらタブビューに遷移するログインボタンを表示する
                    NavigationLink(destination: TopTabView(myName: myName)) {
                        HStack {
                            Text("ログイン")
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                    }
                    .frame(width: 100, height: 54)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(27)
                    .padding(.bottom, 15)
                }
            }.padding(.bottom, 100.0)   // 下に100スペースを入れてアイコンのスタート位置を若干上めにする
        }
    }
    
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            LogInView()
        }
    }
    
}
