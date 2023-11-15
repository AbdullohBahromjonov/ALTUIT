//
//  WeekdayScheduleView.swift
//  TATU litsey
//
//  Created by Abdulloh on 17/09/23.
//

import SwiftUI

struct WeekdayScheduleView: View {
    let day: ScheduleModel
    let color: Color
    
    var body: some View {
        VStack {
            Text(day.weekday)
                .font(.system(size: 20, weight: .semibold))
            VStack(spacing: 0) {
                ForEach(day.subjects, id: \.self) { subject in
                    Text(subject)
                        .frame(height: 40)
                        .foregroundColor(.black)
                    Divider()
                        .frame(height: 2)
                        .overlay {
                            color
                        }
                }
            }
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
            )
        }
        .padding()
        .foregroundColor(.white)
        .background(color)
        .cornerRadius(20)
        .padding()
    }
}


struct WeekdayScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayScheduleView(
            day: ScheduleModel(
                weekday: "Dushanba",
                subjects: [
                    "Algebra",
                    "Algebra",
                    "Algebra"
                ]
            ),
            color: Color.assets.red
        )
    }
}

