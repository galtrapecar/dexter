//
//  dexterApp.swift
//  dexter
//
//  Created by Dev on 31/12/2022.
//

import SwiftUI
import Firebase

let util: Util = Util()

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct dexterApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(util)
        }
    }
}
