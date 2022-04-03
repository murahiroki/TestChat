//
//  FriendModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/31.
//

import Firebase

struct FriendsDataType: Identifiable {
    var id: String
    var hostName: String
    var friendName: String
}

class FriendsModel: ObservableObject {
    @Published var friends = [FriendsDataType]()
    
    init() {
        let db = Firestore.firestore()
        
        // friendsコレクションの変化をリッスンする
        db.collection("friends").addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                // データの追加(.added)を検知
                for i in snap.documentChanges {
                    if i.type == .added {
                        // 予期せぬnilエラーでハマった。関連性は不明だけど、ここの順番を変えたらうまくいった。
                        let hostName = i.document.get("hostName") as! String
                        let friendName = i.document.get("friendName") as! String
                        let id = i.document.documentID

                        self.friends.append(FriendsDataType(id: id, hostName: hostName, friendName: friendName))
                    }
                }
            }
        }
    }
    
    // ユーザー追加関数
    func addFriend(hostName: String, friendName: String) {
        let data = [
            "hostName": hostName,
            "friendName": friendName
        ]
        
        let db = Firestore.firestore()

        db.collection("users").whereField("userName", isEqualTo: friendName).getDocuments { (snap, error) in
            if let error = error {
                // 検索した結果がなくてもここに入ってくるわけではない(例外的なエラーになった時?)
                print("フレンド検索時に例外エラー")
                print(error.localizedDescription)
                return
            } else {
                // 例)フレンド"ひろき"を追加しようとした場合、"uses"コレクションに"ひろき"があればsnap!.documents = ["userName": ひろき]になる
                // "users"コレクションに"ひろき"が未登録ならsnap!.documents = []になる
                if snap!.documents == [] {
                    // 追加しようとしたフレンドが"users"コレクションになければフレンド追加しない
                    print("フレンドがデータベースに未登録")
                    return
                } else {
                    // 追加しようとしたフレンドが"users"コレクションにある
                    if hostName == friendName {
                        // 自分をフレンド登録しようとした場合はフレンド追加しない
                        print("自分をフレンド登録しようとした")
                        return
                    } else {
                        // 追加しようとしたフレンドが自分以外の場合はフレンド登録する
                        db.collection("friends").whereField("hostName", isEqualTo: hostName).getDocuments { (snap, error) in
                            if snap!.documents == [] {
                                // フレンドが一人もいないので登録してもOK
                                db.collection("friends").addDocument(data: data) { error in   // addDocumentはドキュメントIDを自動で生成する
                                    if let error = error {
                                        print("フレンド登録時に例外エラー")
                                        print(error.localizedDescription)
                                        return
                                    } else {
                                        print("フレンド0人から登録成功")
                                        return
                                    }
                                }
                            } else {
                                // フレンドが一人以上いる場合
                                for document in snap!.documents {
                                    let friendList = document.data()["friendName"] as? String
                                    if friendName == friendList {
                                        // 自分のフレンドに追加しようとしているフレンドがいる場合何もしない
                                        print("既にフレンドのユーザーを追加しようとした")
                                        return
                                    } else {
                                        db.collection("friends").addDocument(data: data) { error in   // addDocumentはドキュメントIDを自動で生成する
                                            if let error = error {
                                                print("フレンド登録時に例外エラー")
                                                print(error.localizedDescription)
                                                return
                                            } else {
                                                print("フレンド登録成功")
                                                return
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
