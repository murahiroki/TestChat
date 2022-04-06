//
//  RoomModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/04/05.
//

import Firebase

struct roomsDataType: Identifiable {
    var id: String
    var hostName: String
    var roomName: String
}

class RoomsModel: ObservableObject {
    @Published var rooms = [roomsDataType]()
    
    init() {
        let db = Firestore.firestore()
        
        // roomsコレクションの変化をリッスンする
        db.collection("rooms").addSnapshotListener { (snap, error) in
            if let error = error {
                // 検索した結果がなくてもここに入ってくるわけではない(例外的なエラーになった時?)
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                // データの追加(.added)を検知
                for i in snap.documentChanges {
                    if i.type == .added {
                        let hostName = i.document.get("hostName") as! String
                        let roomName = i.document.get("roomName") as! String
                        let id = i.document.documentID

                        self.rooms.append(roomsDataType(id: id, hostName: hostName, roomName: roomName))
                    }
                }
            }
        }
    }
    // ユーザー追加関数
    func addRoom(hostName: String, roomName: String) {
        let data = [
            "hostName": hostName,
            "roomName": roomName
        ]

        let db = Firestore.firestore()

        // "rooms"コレクションには同じルームを重複して登録しないようにロジックを作る
        db.collection("rooms").whereField("hostName", isEqualTo: hostName).getDocuments { (snap, error) in
            if let error = error {
                // 例外的なエラーになった時?
                print(error.localizedDescription)   // ワーニング回避処理
            } else {
                if snap!.documents == [] {
                    // 追加しようとしたルームがデータベースに未登録の場合
                    db.collection("rooms").addDocument(data: data) { error in   // addDocumentはドキュメントIDを自動で生成する
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        print("ルーム作成成功")
                        return
                    }
                } else {
                    // ルームが一つ以上データベースに登録されている場合
                    for document in snap!.documents {
                        let roomList = document.data()["roomName"] as? String
                        if roomName == roomList {
                            // 自分のルームリストに追加しようとしたルームがある場合何もしない
                            print("既にあるルームを追加しようとした")
                        } else {
                            // 自分のルームリストに追加しようとしているルームがない場合
                            db.collection("rooms").addDocument(data: data) { error in   // addDocumentはドキュメントIDを自動で生成する
                                if let error = error {
                                    print(error.localizedDescription)
                                    return
                                }
                                print("ルーム作成成功")
                                return
                            }
                        }
                    }
                }
            }
        }
    }
}
