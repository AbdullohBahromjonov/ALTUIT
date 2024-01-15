//
//  InfoView.swift
//  TATU litsey
//
//  Created by Abdulloh on 06/10/23.
//

import SwiftUI

struct InfoView: View {
    let date: String
    let month: String
    let group: String
    let subgroup: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(date)
                    .font(.system(size: 50, weight: .semibold))
                Text(month.uppercased())
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
    }
}

#Preview {
    InfoView(date: "12.12.22", month: "OCT", group: "101", subgroup: "1")
}
