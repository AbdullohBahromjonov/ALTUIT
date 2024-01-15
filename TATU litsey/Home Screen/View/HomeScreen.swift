//
//  HomeScreen.swift
//  TATU litsey
//
//  Created by Abdulloh on 14/08/23.
//

import SwiftUI

struct HomeScreen: View {
    @State var showSchedule = false
    @State var showSettings = false
    
    @State var size: CGSize = .zero
    @State var stopScroll = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    let now = Date()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if let user = viewModel.currentUser {
                let todaySchedule: [Subject]? = Bundle.main.decode("\(user.group)-\(user.subgroup)-\(today(now).weekday.day()).json")
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack {
                            NavigationLink(destination: SettingsView(), isActive: $showSettings) {
                                MenuButton(
                                    action: {
                                        showSettings = true
                                    },
                                    image: "gear"
                                )
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: ScheduleView(group: user.group, subgroup: user.subgroup), isActive: $showSchedule) {
                                MenuButton(
                                    action: {
                                        showSchedule = true
                                    },
                                    image: "square.grid.2x2"
                                )
                            }
                        }
                        .padding(.vertical)
                        
                        Text(today(now).weekday.capitalized(with: .autoupdatingCurrent))
                            .font(.system(size: 40, weight: .semibold))
                            .foregroundColor(.white)
                        
                        InfoView(date: today(now).date, month: today(now).month, group: user.group, subgroup: user.subgroup)
                        
                        Text("Bugungi Darsliklar")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                    .padding(30)
                    .padding(.bottom, -30)
                    .overlay {
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    size = geo.size
                                }
                        }
                    }
                    
                    if let validSchedule = todaySchedule {
                        SubjectsView(schedule: validSchedule)
                        .padding(.bottom)
                        .padding(.vertical, 20)
                        .background(
                            Rectangle()
                                .cornerRadius(40, corners: [.topLeft, .topRight])
                                .foregroundColor(Color.assets.secondary)
                                .padding(.horizontal, -30)
                        )
                        .padding(.horizontal, 30)
                        .onAppear {
                            stopScroll = false
                        }
                    } else {
                        ZStack {
                            Color.assets.secondary
                                .frame(height: UIScreen.main.bounds.size.height-size.height-30)
                                .cornerRadius(40, corners: [.topLeft, .topRight])
                            Text(error)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .onAppear {
                            stopScroll = true
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden()
            } else {
                ProgressView()
                    .foregroundColor(.white)
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    init() {
        AuthViewModel().currentUser = User(id: "1", fullName: "Abdulloh", email: "swiftpro2.0@gmail.com", group: "105", subgroup: "1")
    }
    
    static var previews: some View {
        NavigationView {
            HomeScreen()
        }
        .environmentObject(AuthViewModel())
    }
}
