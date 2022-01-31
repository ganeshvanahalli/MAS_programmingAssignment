//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by Somya Doshi on 1/29/22.
//

import SwiftUI
import Firebase

@main
struct NotesAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
      Auth.auth().signInAnonymously()
    return true
  }
}
