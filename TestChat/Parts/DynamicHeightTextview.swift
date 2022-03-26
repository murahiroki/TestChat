//
//  DynamicHeightTextview.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//
//  SwiftUIで高さ可変のTextEditorを使用したいけどSwiftUI単体では実装できそうにないので、UIKitを併用する

import UIKit
import SwiftUI

struct DynamicHeightTextview: UIViewRepresentable {

    //入力値を反映するプロパティ
    @Binding var text: String

    //入力値を考慮したTextViewの高さを保持するプロパティ
    @Binding var height: CGFloat

    let textView = UITextView()

    //実装必須
    func makeUIView(context: Context) -> UITextView {
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16)
        textView.delegate = context.coordinator

        return textView
    }

    //実装必須
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    //Delegateメソッドを定義したクラスを返す
    func makeCoordinator() -> Coordinator {
        return Coordinator(dynamicHeightTextView: self)
    }

    //UITextViewのDelegateメソッドを実装する
    class Coordinator: NSObject, UITextViewDelegate {

        let dynamicHeightTextView: DynamicHeightTextview
        let textView: UITextView

        init(dynamicHeightTextView: DynamicHeightTextview) {
            self.dynamicHeightTextView = dynamicHeightTextView
            self.textView = dynamicHeightTextView.textView
        }

        func textViewDidChange(_ textView: UITextView) {
            dynamicHeightTextView.text = textView.text
            let textViewSize = textView.sizeThatFits(textView.bounds.size)
            dynamicHeightTextView.height = textViewSize.height
        }
    }
}

struct DynamicHeightTextEditor: View {

    @Binding var text: String
    @State var textHeight: CGFloat = 0

    var placeholder: String
    var minHeight: CGFloat
    var maxHeight: CGFloat

    //TextEditorの高さを保持するプロパティ
    var textEditorHeight: CGFloat {
        if textHeight < minHeight {
            return minHeight
        }

        if textHeight > maxHeight {
            return maxHeight
        }

        return textHeight
    }

    var body: some View {
        ZStack {
            //TextEditorの背景色
            Color(red: 0.933, green: 0.917, blue: 0.956)

            //Placeholder
            if text.isEmpty {
                HStack {
                    Text(placeholder)
                        .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                        .padding(.leading, 2)
                    Spacer()
                }
            }

            DynamicHeightTextview(text: $text, height: $textHeight)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .frame(height: textEditorHeight) //← ここで高さを反映
    }
}
