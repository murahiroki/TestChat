//
//  UsersModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/31.
//

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
                // 検索した結果がなくてもここに入ってくるわけではない(例外的なエラーになった時?)
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                // データの追加(.added)を検知
                for i in snap.documentChanges {
                    if i.type == .added {
                        // フィールドを追加する時はシミュレータのアプリを消してからビルドしないと内部で保持しているデータとの整合性が合わずにアプリが落ちる
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

        // "users"コレクションには同じユーザーを重複して登録しないようにロジックを作る
        db.collection("users").whereField("userName", isEqualTo: userName).getDocuments { (snap, error) in
            if let error = error {
                // 例外的なエラーになった時?
                print(error.localizedDescription)   // ワーニング回避処理
            } else {
                // 例)"ひろき"でログインした場合、すでに"users"コレクションに"ひろき"があればsnap!.documents = ["userName": ひろき]になる
                // "users"コレクションに"ひろき"が未登録ならsnap!.documents = []になる
                if snap!.documents == [] {
                    // ログイン名が"users"コレクションになければ登録
                    db.collection("users").addDocument(data: data) { error in   // addDocumentはドキュメントIDを自動で生成する
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }

                        print("success")
                    }
                } else {
                    // ログイン名が"users"コレクションにあれば何もしない
                    print("success")
                }
            }
        }
    }
}
