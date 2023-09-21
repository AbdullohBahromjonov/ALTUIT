//
//  SubjectCardView.swift
//  TATU litsey
//
//  Created by Abdulloh on 14/09/23.
//

import SwiftUI

struct SubjectCardView: View {
    let subject: Subject
    let color: String
    let emoji: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color(hex: color))
                .padding(.horizontal, -10)

            VStack(alignment: .leading) {
                Text(subject.name + " " + emoji)
                    .font(.system(size: 32, weight: .semibold))
                Text("Dars vaqti: \(subject.startTime) - \(subject.endTime)")
                Text("Ustoz: \(subject.teacher)")
                Text("Xona: \(subject.room)")
            }
            .font(.system(size: 20, weight: .semibold))
            .frame(height: 120)
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct SubjectCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SubjectCardView(
                subject:
                    Subject(
                        name: "Algebra",
                        startTime: "8:30",
                        endTime: "9:50",
                        room: "311",
                        teacher: "Masimova G."
                    ),
                color: "C24B4B",
                emoji: "🧮"
            )
            .padding()
            .frame(height: 130)
        }
    }
}
