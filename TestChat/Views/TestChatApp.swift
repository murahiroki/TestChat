//
//  TestChatApp.swift
//  TestChat
//
//  Created by HIROKI MURAYAMA on 2022/03/19.
//

import SwiftUI
import Firebase

// Firebaseを使うための記述
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct TestChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate        // Firebaseを使うための記述
    
    var body: some Scene {
        WindowGroup {
            // アプリ起動するとログイン画面からスタート
            LogInView()
                .environmentObject(CommonObject())     // アプリ全体で共通のインスタンスにアクセスするために必要
        }
    }
}
