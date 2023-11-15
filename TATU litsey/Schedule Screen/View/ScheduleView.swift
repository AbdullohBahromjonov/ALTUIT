//
//  ScheduleView.swift
//  TATU litsey
//
//  Created by Abdulloh on 16/08/23.
//

import SwiftUI

struct ScheduleView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var showDetails = false
    @State var detailDay = ""
    
    let group: String
    let subgroup: String
    
    var body: some View {
        let weekSchedule: [ScheduleModel]? = Bundle.main.decode("\(group)-\(subgroup).json")
        
        ScrollView(showsIndicators: false) {
            VStack {
                if let validSchedule = weekSchedule {
                    ForEach(validSchedule, id: \.weekday) { day in
                        WeekdayScheduleView(day: day, color: color(day.weekday))
                            .onTapGesture {
                                detailDay = day.weekday
                                showDetails.toggle()
                            }
                            .sheet(
                                isPresented: $showDetails,
                                content: {
                                    ScheduleDetailView(day: detailDay, group: group, subgroup: subgroup)
                                }
                            )
                    }
                } else {
                    Text("Sizning darsligingiz topilmadi 😔")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
                
            }
            .padding(.top)
        }
        .padding(.horizontal)
        .navigationTitle("Dars Jadvali")
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

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleView(group: "101", subgroup: "1")
        }
    }
}
