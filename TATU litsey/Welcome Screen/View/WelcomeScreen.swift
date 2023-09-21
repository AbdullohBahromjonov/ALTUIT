//
//  Welcome Screen.swift
//  TATU litsey
//
//  Created by Abdulloh on 13/08/23.
//

import SwiftUI

struct WelcomeScreen: View {
    @Binding var startHomeScreen: Bool
    
    @AppStorage("group") var group = ""
    @AppStorage("subgroup") var subgroup = ""
    @AppStorage("language") var language = "O'zbek"
    
    @State var groupError = false
    @State var subgroupError = false
    
    let subgroups = ["1", "2"]
    let groups = ["101", "102", "103", "104", "105", "106", "107", "108", "109", "201", "202", "203", "204", "205", "206", "207", "208"]
    let languages = ["O'zbek", "Rus"]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Background()
            
            VStack {
                Text("Hush kelibsiz")
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .bold))
                
                VStack(alignment: .leading, spacing: 20) {
                    CustomTextField(
                        text: $group,
                        name: "Guruh",
                        title: "Guruhingizni tanlang",
                        picker: true,
                        array: groups,
                        pickItemPrefix: "chi guruh"
                    )
                    if groupError {
                        Text("Bu yerni toldiring")
                            .foregroundColor(.red)
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.leading, 20)
                            .padding(.top, -10)
                    }
                    
                    CustomTextField(
                        text: $subgroup,
                        name: "Kichik Guruh",
                        title: "Kichik Guruhingizni tanlang",
                        picker: true,
                        array: subgroups,
                        pickItemPrefix: "chi kichik guruh"
                    )
                    if groupError {
                        Text("Bu yerni toldiring")
                            .foregroundColor(.red)
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.leading, 20)
                            .padding(.top, -10)
                    }
                    
                    CustomTextField(
                        text: $language,
                        name: "Til",
                        title: "",
                        picker: true,
                        array: languages,
                        pickItemPrefix: " tili"
                    )
                }
                .padding()
                .padding(.bottom)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.assets.secondary)
                )
                .padding()
                
                NavigationLink(destination: HomeScreen(group: $group, subgroup: $subgroup), isActive: $startHomeScreen) {
                    Button(
                        action: {
                            withAnimation {
                                if group.isEmpty {
                                    groupError = true
                                } else if subgroup.isEmpty {
                                    subgroupError = true
                                } else {
                                    startHomeScreen = true
                                }
                            }
                        },
                        label: {
                            Text("Boshlash")
                                .font(.system(size: 17, weight: .semibold))
                                .padding()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color.assets.blue)
                                )
                                .padding(.horizontal, 20)
                        }
                    )
                }
            }
        }
    }
}

struct Welcome_Screen_Previews: PreviewProvider {
    @State static var startHomeScreen = false
    
    static var previews: some View {
        WelcomeScreen(startHomeScreen: $startHomeScreen)
    }
}
