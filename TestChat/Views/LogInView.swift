//
//  LogInView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

// ログイン画面
struct LogInView: View {
    
    @EnvironmentObject var cm : CommonObject                // 全てのViewで使える変数
    @ObservedObject var userModel = UsersModel()            // "users"コレクション関連の宣言
    @State private var shouldshowtopTabView: Bool = false   // この値がtrueになったらtopTabViewに遷移する(ボタンを押したら画面遷移するロジックのために必要)
    @State var testMyName = ""                              // // cm.myNameを使う処理はなぜかプレビューできないのでプレビュー用変数を用意
    
    var body: some View {
        NavigationView {
            VStack {
                // 200×200で自分のアイコンを表示(タップするとフォトライブラリから画像選択できる)
                ImageSetIcon(iconWidth: 200, iconHeight: 200)
                
#if MYDEBUG
                // cm.myNameを使う処理はなぜかプレビューできないのでプレビュー用ルートを用意
                // 名前の入力欄
                TextField("名前 ", text: $testMyName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())      // テキストフィールドの枠に丸みをつける
                    .padding()                                          // 見栄え良くするためにテキストフィールドの上下左右に隙間を入れる
#else
                TextField("名前 ", text: $cm.myName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())      // テキストフィールドの枠に丸みをつける
                    .padding()                                          // 見栄え良くするためにテキストフィールドの上下左右に隙間を入れる
#endif
                
#if MYDEBUG
                // cm.myNameを使う処理はなぜかプレビューできないのでプレビュー用ルートを用意
                // ログインボタン
                if testMyName != "" {
                    // 名前の入力がされたらボタンを表示する
                    // NavigationLinkのisActiveプロパティを使うことでボタンを押したら何か処理をさせる&画面遷移する動きになる
                    NavigationLink(destination: TopTabView(), isActive: $shouldshowtopTabView) {
                        EmptyView()
                    }
                    Button {
                        // ユーザー登録後に画面遷移(ログイン)
                        shouldshowtopTabView = true
                    } label: {
                        // ボタンデザイン
                        HStack {
                            // ボタンの文字
                            Text("ログイン")
                            // ボタンパーツ(右矢印のシステム画像)
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()                    // 縦横比をフレームに合わせてリサイズする
                                .frame(width: 20, height: 20)   // フレームサイズ
                        }
                        .frame(width: 100, height: 54)  // ボタンの大きさ
                        .background(Color.green)        // ボタンの色
                        .foregroundColor(Color.white)   // ボタンのテキスト文字色
                        .cornerRadius(27)               // ボタンの角に丸みをつける

                    }
                } else {
                    // テキストフィールドに何も入力されていなければボタンは表示しない(次の画面には遷移できないようにする)
                }
#else
                // ログインボタン
                if cm.myName != "" {
                    // 名前の入力がされたらボタンを表示する
                    // NavigationLinkのisActiveプロパティを使うことでボタンを押したら何か処理をさせる&画面遷移する動きになる
                    NavigationLink(destination: TopTabView(), isActive: $shouldshowtopTabView) {
                        EmptyView()
                    }
                    Button {
                        // ボタン押した時に”users”コレクションに入力したユーザーを登録
                        userModel.addUser(userName: cm.myName)
                        // ユーザー登録後に画面遷移(ログイン)
                        shouldshowtopTabView = true
                    } label: {
                        // ボタンデザイン
                        HStack {
                            // ボタンの文字
                            Text("ログイン")
                            // ボタンパーツ(右矢印のシステム画像)
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()                    // 縦横比をフレームに合わせてリサイズする
                                .frame(width: 20, height: 20)   // フレームサイズ
                        }
                        .frame(width: 100, height: 54)  // ボタンの大きさ
                        .background(Color.green)        // ボタンの色
                        .foregroundColor(Color.white)   // ボタンのテキスト文字色
                        .cornerRadius(27)               // ボタンの角に丸みをつける

                    }
                } else {
                    // テキストフィールドに何も入力されていなければボタンは表示しない(次の画面には遷移できないようにする)
                }
#endif
            }.padding(.bottom, 200)   // 下に200スペースを入れてアイコンのスタート位置を若干上めにする
        }
    }
#if MYDEBUG
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            LogInView()
        }
    }
#endif
}
