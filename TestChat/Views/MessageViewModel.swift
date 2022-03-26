//
//  MessageViewModel.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import Foundation
//import Firebase

struct messageDataType: Identifiable {
    var id: String
    var name: String
    var message: String
}

class MessageViewModel: ObservableObject {
    //@Published var messages = [messageDataType]()
    @Published var messages: [String] = []
    
    func addMessage(message: String, user: String){
        self.messages.append(message)
    }
    
}
