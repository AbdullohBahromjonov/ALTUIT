//
//  Background.swift
//  TATU litsey
//
//  Created by Abdulloh on 13/08/23.
//

import SwiftUI

struct Background: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color.assets.yellow)
                    .frame(width: 205, height: 205)
                    .padding(.leading, -50)
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color.assets.red)
                    .frame(width: 205, height: 205)
                    .padding(.top, -70)
                    .padding(.leading, -120)
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color.assets.purple)
                    .frame(width: 236, height: 236)
                    .padding(.trailing, -100)
                    .padding(.bottom, -520)
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color.assets.green)
                    .frame(width: 236, height: 236)
                    .padding(.trailing, -20)
                    .padding(.bottom, -20)
            }
        }
        .ignoresSafeArea()
    }
}


struct Background_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            Background()
        }
    }
}
