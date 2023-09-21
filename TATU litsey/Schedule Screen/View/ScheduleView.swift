//
//  ScheduleView.swift
//  TATU litsey
//
//  Created by Abdulloh on 16/08/23.
//

import SwiftUI

struct ScheduleView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var group: String
    @Binding var subgroup: String
    
    var color: (String) -> Color = {(day: String) -> Color in
        switch day {
        case "Dushanba":
            return Color.assets.yellow
        case "Seshanba":
            return Color.assets.red
        case "Chorshanba":
            return Color.assets.purple
        case "Payshanba":
            return Color.assets.blue
        case "Juma":
            return Color.assets.green
        case "Shanba":
            return Color.assets.orange
        default:
            return Color.assets.scarlet
        }
    }
    
    var body: some View {
        let weekSchedule: [ScheduleModel]? = Bundle.main.decode("\(group)-\(subgroup).json")
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    if let validSchedule = weekSchedule {
                        ForEach(validSchedule, id: \.weekday) { day in
                            WeekdayScheduleView(day: day, color: color(day.weekday))
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
        }
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
    @State static var group = "101"
    @State static var subgroup = "1"
    
    static var previews: some View {
        NavigationView {
            ScheduleView(group: $group, subgroup: $subgroup)
        }
    }
}
