//
//  UsersModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/31.
//

import Foundation
import Firebase

struct usersDataType: Identifiable {
    var id: String
    var userName: String
}

class UsersModel: ObservableObject {
    @Published var users = [usersDataType]()
    
    init() {
        let db = Firestore.firestore()
        
        // usersコレクションの変化をリッスンする
        db.collection("users").addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                // データの追加(.added)を検知
                for i in snap.documentChanges {
                    if i.type == .added {
                        let userName = i.document.get("userName") as! String
                        let id = i.document.documentID

                        self.users.append(usersDataType(id: id, userName: userName))
                    }
                }
            }
        }
    }
    // ユーザー追加関数
    func addUser(userName: String) {
        let data = [
            "userName": userName
        ]

        let db = Firestore.firestore()

        // addDocumentはドキュメントIDを自動で生成する
        db.collection("users").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            print("success")
        }
    }

}
