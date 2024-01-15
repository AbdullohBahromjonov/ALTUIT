//
//  ScheduleDetailView.swift
//  TATU litsey
//
//  Created by Abdulloh on 17/10/23.
//

import SwiftUI

struct ScheduleDetailView: View {
    let day: String
    let group: String
    let subgroup: String
    
    var body: some View {
        let todaySchedule: [Subject]? = Bundle.main.decode("\(group)-\(subgroup)-\(day.lowercased().day()).json")
        
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        SubjectsView(schedule: todaySchedule ?? [])
                        .padding(30)
                    }
                }
            }
            .navigationTitle(day)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ScheduleDetailView(day: "Dushanba", group: "105", subgroup: "1")
}
