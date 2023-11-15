//
//  ContentView.swift
//  TATU litsey
//
//  Created by Abdulloh on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.userSession != nil {
                    HomeScreen()
                } else {
                    SignInScreen()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
