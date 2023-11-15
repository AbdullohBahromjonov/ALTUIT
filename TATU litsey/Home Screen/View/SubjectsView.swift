//
//  SubjectsView.swift
//  TATU litsey
//
//  Created by Abdulloh on 06/10/23.
//

import SwiftUI

struct SubjectsView: View {
    let schedule: [Subject]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(schedule , id: \.self) { subject in
                SubjectCardView(
                    subject: subject,
                    color: subject.name.define().color,
                    emoji: subject.name.define().emoji
                )
            }
        }
    }
}

#Preview {
    SubjectsView(schedule: [Subject(name: "Algebra", startTime: "8:30", endTime: "9:50", room: "sport zal", teacher: "Massimova")])
}
