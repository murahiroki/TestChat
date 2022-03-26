//
//  MessageViewModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import Foundation
import Firebase

struct messageDataType: Identifiable {
    var id: String
    var hostName: String
    var message: String
}

class MessageViewModel: ObservableObject {
    @Published var messages = [messageDataType]()

    init() {
        let db = Firestore.firestore()
        
        // Firebaseに"message"テーブルを追加
        db.collection("messages").addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
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

    func addMessage(message: String , hostUser: String) {
        let data = [
            "message": message,
            "hostName": hostUser
        ]

        let db = Firestore.firestore()

        db.collection("messages").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            print("success")
        }
    }

}
