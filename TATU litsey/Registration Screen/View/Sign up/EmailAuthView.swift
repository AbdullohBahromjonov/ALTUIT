//
//  EmailAuthView.swift
//  TATU litsey
//
//  Created by Abdulloh on 23/09/23.
//

import SwiftUI

struct EmailAuthView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var next = false
    @State var goSignIn = false
    
    var body: some View {
        Background(
            view: VStack {
                Text("Akkaunt yaratish")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 0)
                
                VStack(spacing: 15) {
                    CustomTextField(
                        text: $name,
                        title: "Toliq ismingiz",
                        placeholder: "Ismingizni kiriting"
                    )
                    
                    CustomTextField(
                        text: $email,
                        title: "Elektron pochta",
                        placeholder: "Elektron pochtangizni kiriting"
                    )
                        .keyboardType(.emailAddress)
                    
                    CustomSecureField(
                        text: $password,
                        title: "Parol",
                        placeholder: "Parol kiriting"
                    )
                    
                    NavigationLink(
                        destination: SignInScreen(),
                        isActive: $goSignIn
                    ) {
                        Button (
                            action: {
                                goSignIn = true
                            },
                            label: {
                                Text("Akauntingiz bormi? Akauntga kirish")
                                    .font(.system(size: 14))
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
                
                NavigationLink(destination: SelectGroupScreen(email: $email, password: $password, name: $name), isActive: $next) {
                    CustomButton(
                        text: "Keyingisi",
                        action: {
                            next = true
                        },
                        image: "chevron.right"
                    )
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.6)
            }
        )
        .navigationBarBackButtonHidden(true)
    }
}

extension EmailAuthView: AuthenticationFromProtocol {
    var formIsValid: Bool {
        return !name.isEmpty
        && !email.isEmpty
        && email.contains("@")
        && password.count > 5
    }
}

struct EmailAuthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmailAuthView()
        }
    }
        
}
