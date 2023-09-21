//
//  TATU_litseyApp.swift
//  TATU litsey
//
//  Created by Abdulloh on 13/08/23.
//

import SwiftUI

@main
struct TATU_litseyApp: App {
    @AppStorage("startHomeScreen") var startHomeScreen = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor : UIColor(Color(.white))
        ]
        UINavigationBar.appearance().barTintColor = UIColor(Color.black)
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor : UIColor(Color.white)
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WelcomeScreen(startHomeScreen: $startHomeScreen)
                    .preferredColorScheme(.light)
                    //.environment(\.locale, Locale(identifier: "UZ"))
            }
        }
    }
}
