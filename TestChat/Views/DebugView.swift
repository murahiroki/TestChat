//
//  DebugView.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/04/02.
//

import SwiftUI

struct DebugView: View {
    
    @EnvironmentObject var cm : CommonObject                // 全てのViewで使える変数
    
    var body: some View {
//        List{
//            ForEach(0 ..< cm.debugLog.count){ index in
//                Text(cm.debugLog[index])
//            }
//        }
        Text("操作ログ取得")
    }
#if MYDEBUG
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            DebugView()
        }
    }
#endif
}
