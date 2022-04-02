//
//  Common.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/04/02.
//

import SwiftUI

class CommonObject: ObservableObject {
    @Published var debugLog:[String] = []
    @Published var myName: String = ""
}
