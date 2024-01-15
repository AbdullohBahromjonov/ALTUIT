//
//  TATU_litseyApp.swift
//  TATU litsey
//
//  Created by Abdulloh on 13/08/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TATU_litseyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor : UIColor(Color(.white))
        ]
        UINavigationBar.appearance().barTintColor = UIColor(Color.black)
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor : UIColor(Color.white)
        ]
        UIAlertView().backgroundColor = UIColor(Color.black)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
