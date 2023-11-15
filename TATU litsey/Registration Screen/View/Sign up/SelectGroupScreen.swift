//
//  GroupSelectView.swift
//  TATU litsey
//
//  Created by Abdulloh on 23/09/23.
//

import SwiftUI

struct SelectGroupScreen: View {
    @Environment(\.dismiss) var dismiss
    
    @State var group = ""
    @State var subgroup = ""
    @State var showError = false
    @State var errorTitle: String? = nil
    @State var errorMessage: String? = nil
    
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Background(
            view: VStack {
                Text("Guruh")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    CustomTextField(
                        text: $group,
                        title: "Guruh",
                        placeholder: "Guruhungiz",
                        picker: true,
                        array: groups
                    )
                    CustomTextField(
                        text: $subgroup,
                        title: "Kichik guruh",
                        placeholder: "Kichik guruhingiz",
                        picker: true,
                        array: subgroups
                    )
                }
                .padding()
                .padding(.vertical)
                .background(
                    Color.assets.secondary
                        .cornerRadius(30)
                )
                .padding(20)
                .padding(.top, 0)
                
                CustomButton(
                    text: "Boshlash",
                    action: {
                        Task {
                            try await viewModel.createUser(withEmail: email, password: password, fullName: name, group: group, subgroup: subgroup)
                            
                            if let title = viewModel.errorTitle, let message = viewModel.errorMessage {
                                self.errorTitle = title
                                self.errorMessage = message
                                showError = true
                            }
                        }
                    }
                )
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.6)
                .alert(errorTitle ?? "", isPresented: $showError) {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                } message: {
                    Text(errorMessage ?? "")
                }
            }
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 15, weight: .semibold))
                        Text("ortga")
                            .font(.custom("Arvo-Bold", size: 15))
                            .offset(y: -1)
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

extension SelectGroupScreen: AuthenticationFromProtocol {
    var formIsValid: Bool {
        return !group.isEmpty
        && !subgroup.isEmpty
    }
}

struct SelectGroupScreen_Previews: PreviewProvider {
    @State static var email = ""
    @State static var password = ""
    @State static var name = ""
    
    static var previews: some View {
        NavigationView {
            SelectGroupScreen(email: $email, password: $password, name: $name)
        }
    }
}
