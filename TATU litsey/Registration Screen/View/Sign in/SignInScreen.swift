//
//  Welcome Screen.swift
//  TATU litsey
//
//  Created by Abdulloh on 13/08/23.
//

import SwiftUI

struct SignInScreen: View {
    @State var email = ""
    @State var password = ""
    @State var goSignUp = false
    @State var showError = false
    @State var errorTitle: String? = nil
    @State var errorMessage: String? = nil
    @State var buttonPressed = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Background(
            view: ZStack {
                VStack {
                    Text("Akkauntga kirish")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .bold))
                    
                    VStack(spacing: 15) {
                        CustomTextField(
                            text: $email,
                            title: "Elektron pochta",
                            placeholder: "Elektron pochtangizni kiriting"
                        )
                        .keyboardType(.emailAddress)
                        
                        CustomSecureField(
                            text: $password,
                            title: "Parol",
                            placeholder: "Parolingizni kiriting"
                        )
                        
                        NavigationLink(
                            destination: EmailAuthView(),
                            isActive: $goSignUp
                        ) {
                            Button (
                                action: {
                                    goSignUp = true
                                },
                                label: {
                                    Text("Akkauntingiz yoqmi? Akkauntga yaratish")
                                        .font(.system(size: 14))
                                        .foregroundColor(.blue)
                                }
                            )
                            .padding(.top)
                            .padding(.bottom, -10)
                        }
                    }
                    .padding()
                    .padding(.vertical)
                    .background(
                        Color.assets.secondary
                            .cornerRadius(30)
                    )
                    .padding(20)
                    
                    CustomButton(
                        text: "Kirish",
                        action: {
                            Task {
                                buttonPressed = true
                                
                                try await viewModel.signIn(withEmail: email, password: password)
                                
                                if let title = viewModel.errorTitle, let message = viewModel.errorMessage {
                                    self.errorTitle = title
                                    self.errorMessage = message
                                    showError = true
                                    buttonPressed = false
                                }
                            }
                            
                        }
                    )
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1 : 0.6)
                    .alert(errorTitle ?? "", isPresented: $showError) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text(errorMessage ?? "")
                    }
                }
                
                if buttonPressed {
                    ProgressView()
                        .foregroundColor(.white)
                }
            }
        )
        .navigationBarBackButtonHidden(true)
    }
}

extension SignInScreen: AuthenticationFromProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
