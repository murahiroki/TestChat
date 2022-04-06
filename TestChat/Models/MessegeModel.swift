//
//  FirebaseModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI
import Firebase

struct messageDataType: Identifiable {
    var id: String
    var fromName: String
    var toName: String
    var message: String
}

class MessegeModel: ObservableObject {
    @Published var messages = [messageDataType]()
    
    init() {
        let db = Firestore.firestore()
        
        // messageコレクションの変化をリッスンする
        db.collection("messages").addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                // データの追加(.added)を検知
                for i in snap.documentChanges {
                    if i.type == .added {
                        let fromName = i.document.get("fromName") as! String
                        let toName = i.document.get("toName") as! String
                        let message = i.document.get("message") as! String
                        let id = i.document.documentID

                        self.messages.append(messageDataType(id: id, fromName: fromName, toName: toName, message: message))
                    }
                }
            }
        }
    }
    // メッセージ追加関数
    func addMessage(fromName: String, toName: String, message: String) {
        
        let data = [
            "fromName": fromName,
            "toName": toName,
            "message": message
        ]

        let db = Firestore.firestore()

        db.collection("messages").addDocument(data: data) { error in
            if let error = error {
                // ここは相手にメッセージが届かなかったことを知らせるロジックを組む
                print(error.localizedDescription)
                return
            }

            print("success")
        }
    }

}
