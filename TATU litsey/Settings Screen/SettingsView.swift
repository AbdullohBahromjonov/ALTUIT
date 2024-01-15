//
//  SettingsView.swift
//  TATU litsey
//
//  Created by Abdulloh on 05/09/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var goWelcomeScreen = false
    @State var showSignOutAlert = false
    @State var showDeleteAlert = false
    @State var groupSelected = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if let user = viewModel.currentUser {
                VStack {
                    List {
                        Section(header: Text("Shaxsiy ma'lumot").foregroundColor(.gray)) {
                            HStack {
                                Text(user.initials)
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                    .offset(x: -9)
                                    .background {
                                        Circle()
                                            .foregroundColor(.gray)
                                            .padding(.trailing)
                                    }
                                
                                VStack(alignment: .leading) {
                                    Text(user.fullName)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Text(user.email)
                                        .font(.system(size: 14))
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .listRowBackground(Color.assets.darkGray)
                        
                        Section(header: Text("Guruh").foregroundColor(.gray)) {
                            HStack {
                                Text("Guruh: \(user.group)")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .foregroundColor(.black)
                            }
                            .overlay {
                                Menu(
                                    content: {
                                        ForEach(groups, id: \.self) { item in
                                            Button(
                                                action: {
                                                    Task {
                                                        try await viewModel.changeUserGroupTo(String(item))
                                                    }
                                                },
                                                label: {
                                                    Text("\(item)")
                                                }
                                            )
                                        }
                                    },
                                    label: {
                                        Color.clear
                                    }
                                )
                            }
                                
                            HStack {
                                Text("Kichik guruh: \(user.subgroup)")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .foregroundColor(.black)
                            }
                            .overlay {
                                Menu(
                                    content: {
                                        ForEach(subgroups, id: \.self) { item in
                                            Button(
                                                action: {
                                                    Task {
                                                        try await viewModel.changeUserSubgroupTo(String(item))
                                                    }
                                                },
                                                label: {
                                                    Text("\(item)")
                                                }
                                            )
                                        }
                                    },
                                    label: {
                                        Color.clear
                                    }
                                )
                            }
                        }
                        .foregroundColor(.white)
                        .listRowBackground(Color.assets.darkGray)
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    
                    Button(
                        action: {
                            showSignOutAlert = true
                        },
                        label: {
                            Text("Tizimdan chiqish")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.assets.red)
                                )
                                .padding()
                        }
                    )
                    .padding()
                    .alert("Accountdan chiqish", isPresented: $showSignOutAlert) {
                        Button("Yo'q", role: .cancel) {}
                        Button("Ha", role: .destructive) {
                            viewModel.signOut()
                        }
                    } message: {
                        Text("Haqiqatan ham tizimdan chiqishni xohlaysizmi?")
                    }
                    
                    Button(
                        action: {
                            showDeleteAlert = true
                        },
                        label: {
                            Text("Accountni ochirish")
                                .font(.system(size: 15))
                                .foregroundStyle(Color.assets.red)
                        }
                    )
                    .padding(.bottom)
                    .padding(.top, -15)
                    .alert("Account ochirish", isPresented: $showDeleteAlert) {
                        Button("Yo'q", role: .cancel) {}
                        Button("Ha", role: .destructive) {
                            Task {
                                await viewModel.deleteAccount()
                            }
                        }
                    } message: {
                        Text("Siz haqiqatan ham accountingizni o'chirib tashlamoqchimisiz?")
                    }
                }
            } else {
                Text("Foydalanovchi topilmadi 👻")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
            }
            
            if groupSelected == true {
                ProgressView()
                    .foregroundColor(.white)
            }
        }
        .navigationTitle("Sozlamalar")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
        .environmentObject(AuthViewModel())
    }
}

struct GroupSection: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    let type: String
    let displayItem: String
    
    func nameFrom(_ type: String) -> String {
        switch type {
        case "group":
            return "Guruh"
        case "subgroup":
            return "Kickik guruh"
        default:
            return ""
        }
    }
    
    func arrayOf(_ type: String) -> [String] {
        switch type {
        case "group":
            return groups
        case "subgroup":
            return subgroups
        default:
            return []
        }
    }
    
    var body: some View {
        Text("Hi")
    }
}
