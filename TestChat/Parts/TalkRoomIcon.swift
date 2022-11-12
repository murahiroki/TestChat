//
//  Icon.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

// トークルームリスト専用アイコン(タップしても何も起きないただのアイコン)
struct TalkRoomIcon: View {
    var body: some View {
        HStack {
            Image("TestIconImage")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
        }
    }
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        // 200×200で表示してみる
        static var previews: some View {
            TalkRoomIcon()
                .frame(width: 200, height: 200)
        }
    }
}
