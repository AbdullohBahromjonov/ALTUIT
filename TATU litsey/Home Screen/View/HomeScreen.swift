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
    
    @Binding var group: String
    @Binding var subgroup: String
    
    let now = Date()
    
    func today() -> (weekday: String, month: String, date: String) {
        let weekFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        let dateFormatter = DateFormatter()
        
        weekFormatter.dateFormat = "EEEE"
        monthFormatter.dateFormat = "MMM"
        dateFormatter.dateFormat = "dd.MM"
        
        return (
            weekFormatter.string(from: now),
            monthFormatter.string(from: now),
            dateFormatter.string(from: now)
        )
    }
    
    func define(_ name: String) -> (color: String, emoji: String) {
        switch name {
        case "Algebra":
            return (color: "C24B4B", emoji: "🧮")
        case "Nemis tili":
            return (color: "AD4646", emoji: "🇩🇪")
        case "Biologiya":
            return (color: "46AD82", emoji: "🪴")
        case "Geometriya":
            return (color: "465DAD", emoji: "📐")
        case "Kimyo":
            return (color: "BC5DE9", emoji: "🧪")
        case "Fizika":
            return (color: "FFC700", emoji: "💡")
        case "Ingliz tili":
            return (color: "E95D5D", emoji: "🇬🇧")
        case "Jismoniy tarbiya":
            return (color: "E9A05D", emoji: "🏋️")
        case "Rus tili":
            return (color: "5D8DE9", emoji: "🇷🇺")
        case "O'zbek tili":
            return (color: "46AD82", emoji: "🇺🇿")
        case "Ona tili":
            return (color: "46AD82", emoji: "🇺🇿")
        case "Tarbiya":
            return (color: "56BAD0", emoji: "👩‍🏫")
        case "Informatika":
            return (color: "29278B", emoji: "💾")
        case "Geografiya":
            return (color: "3C72FF", emoji: "🌍")
        case "O'zbekiston tarixi":
            return (color: "E9A05D", emoji: "🕌")
        case "Jaxon tarixi":
            return (color: "5B3D99", emoji: "🏛️")
        default:
            return (color: "5B3D99", emoji: "")
        }
    }
    
    var body: some View {
        let todaySchedule: [Subject]? = Bundle.main.decode("\(group)-\(subgroup)(\(today().weekday)).json")
        
        ZStack(alignment: .top) {
            Color.black
                .ignoresSafeArea()
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
                        
                        NavigationLink(destination: ScheduleView(group: $group, subgroup: $subgroup), isActive: $showSchedule) {
                            MenuButton(
                                action: {
                                    showSchedule = true
                                },
                                image: "square.grid.2x2"
                            )
                        }
                    }
                    .padding(.vertical)
                    
                    Text(today().weekday)
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(.white)
                        
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(today().date)
                                .font(.system(size: 50, weight: .semibold))
                            Text(today().month.uppercased())
                        }
                        .font(.system(size: 60, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(alignment: .top)
                        
                        Spacer(minLength: 10)
                        
                        Divider()
                            .frame(width: 2, height: 130)
                            .overlay(Color(.white))
                        
                        Spacer(minLength: 10)
                        
                        VStack(alignment: .trailing) {
                            Text("Guruh:")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.white)
                            Text(group)
                                .font(.system(size: 40, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Text("Kichik guruh:")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            Text(subgroup)
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 140)
                    .padding(.vertical)
                    
                    
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
                    VStack(spacing: 20) {
                        ForEach(validSchedule , id: \.self) { subject in
                            SubjectCardView(
                                subject: subject,
                                color: define(subject.name).color,
                                emoji: define(subject.name).emoji
                            )
                        }
                    }
                    .padding(.bottom)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(Color.assets.secondary)
                            .padding(.horizontal, -30)
                    )
                    .padding(.horizontal, 30)
                    .padding(.bottom, -30)
                    .onAppear {
                        stopScroll = false
                    }
                } else {
                    ZStack {
                        Color.assets.secondary
                            .frame(height: UIScreen.main.bounds.size.height-size.height)
                            .cornerRadius(40)
                        Text(error)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .offset(y: -20)
                    }
                    .onAppear {
                        stopScroll = true
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(stopScroll ? .bottom : .horizontal)
        .navigationBarBackButtonHidden()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    @State static var group = "101"
    @State static var subgroup = "1"
    
    static var previews: some View {
        NavigationView {
            HomeScreen(group: $group, subgroup: $subgroup)
        }
    }
}


