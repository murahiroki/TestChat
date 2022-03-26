//
//  ImageSetIcon.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/26.
//

import SwiftUI

// ログイン画面、自分のプロフィール表示専用アイコン(タップすると画像を選べる)
struct ImageSetIcon: View {
    // 呼び出し時に引数で大きさを変えられるようにする
    var iconWidth : CGFloat = 0     // 横幅
    var iconHeight : CGFloat = 0    // 高さ
    
    // ImagePicker.swft関連
    // フォトライブラリーから画像を選択するのに必要らしいけどよくわからん
    @State var myiconimage: UIImage?
    @State var showingImagePicker = false
    @State private var isShowingView: Bool = false
    
    var body: some View {
        // アイコンをボタンにしてタップでアイコン画像選択できるようにする
        Button(action: {
            showingImagePicker = true
        }) {
            if let uiImage = myiconimage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: iconWidth, height: iconHeight)
            } else {
                Text("No Image")
                    .font(Font.system(size: 24).bold())
                    .foregroundColor(Color.white)
                    .frame(width: iconWidth, height: iconHeight)
                    .background(Color(UIColor.lightGray))
                    .scaledToFill()
                    .clipShape(Circle())
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $myiconimage)
        }
    }
    
    // プレビュー確認用
    struct ContentView_Previews: PreviewProvider {
        // 200×200で表示してみる
        static var previews: some View {
            ImageSetIcon(iconWidth: 200, iconHeight: 200)
        }
    }
}
