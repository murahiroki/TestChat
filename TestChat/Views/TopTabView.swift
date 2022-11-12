//
//  TabView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/24.
//

import SwiftUI

// タブ画面
struct TopTabView: View {
    /* NavigationViewの中にTabViewを表示するとタブごとにタイトルを設定できないのでタップしたタブを検知してタイトル指定*/
    enum TabsTitle: String {
        case homeTabTitle = "フレンドリスト"
        case messegeTabTitle = "トーク"
        case debugTabTitle = "デバッグ画面(リリースする時消す)"
    }
    
    @State private var navigationTitle: String = TabsTitle.homeTabTitle.rawValue        // タブごとのタイトル格納用変数
    @State private var selectedTab: TabsTitle = .homeTabTitle                           // 現在選んでるタブを記憶する変数
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // ホームタブアイコン
            FriendListView().tabItem{
                Image(systemName: "house")
                Text("ホーム")
            }.tag(TabsTitle.homeTabTitle)
            
            // メッセージタブ
            TalkRoomListView().tabItem{
                Image(systemName: "message")
                Text("メッセージ")
            }.tag(TabsTitle.messegeTabTitle)
            
            // デバッグタブ
            DebugView().tabItem{
                Image(systemName: "server.rack")
                Text("デバッグ")
            }.tag(TabsTitle.messegeTabTitle)
        }
        // タブごとにタイトルを設定する処理
        .navigationBarTitle(navigationTitle, displayMode: .automatic)
        .onChange(of: selectedTab) { tab in
            navigationTitle = selectedTab.rawValue
        }
        // NavigationViewの機能でログイン画面->タブ画面に来ているのでログイン画面に戻る「Back」ボタンが表示される
        // ログイン後に再度ログイン画面に戻るにはログアウトボタンを別で用意する予定なのでタブ画面からは戻れないようにする
        .navigationBarBackButtonHidden(true)    // ログイン画面に戻る「Back」ボタンを消す
        // iOS15.4をターゲットにしたアプリなので.navigationBarItemsは非推奨らしい
        // 代わりに.toolbarを使う
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                // フレンド追加ボタン押下でフレンド追加画面へ
                NavigationLink(destination:AddFriendView()){
                    Image(systemName: "person.badge.plus")// フレンド追加ボタン

                }
                // 設定ボタン押下で設定画面へ
                NavigationLink(destination: SettingView()){
                    Image(systemName: "gearshape") // 設定ボタン
                }
            }
        }
    }
#if MYDEBUG
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            TopTabView()
        }
    }
#endif
}
