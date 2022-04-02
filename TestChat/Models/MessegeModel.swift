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
    var hostName: String
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
                        let hostName = i.document.get("hostName") as! String
                        let message = i.document.get("message") as! String
                        let id = i.document.documentID

                        self.messages.append(messageDataType(id: id, hostName: hostName, message: message))
                    }
                }
            }
        }
    }
    // メッセージ追加関数
    func addMessage(hostName: String, message: String) {
        
        let data = [
            "hostName": hostName,
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
