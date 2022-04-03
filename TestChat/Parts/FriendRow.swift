//
//  FriendRow.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/20.
//

import SwiftUI

struct FriendRow: View {
    var friendName: String
    
    var body: some View {
        HStack {
            TalkRoomIcon().frame(width: 50, height: 50)
            Text(friendName)
        }
    }
}
