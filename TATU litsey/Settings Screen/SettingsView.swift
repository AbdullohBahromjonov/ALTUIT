//
//  SettingsView.swift
//  TATU litsey
//
//  Created by Abdulloh on 05/09/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                List {
                    Section(header: Text("Guruh").foregroundColor(.gray)) {
                        Text("Guruh: 103")
                        Text("Kichik guruh: 2")
                    }
                    .preferredColorScheme(.dark)
                    
                    Section(header: Text("Til").foregroundColor(.gray)) {
                        Text("O'zbek")
                    }
                    .preferredColorScheme(.dark)
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                Button(
                    action: {},
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
    }
}
