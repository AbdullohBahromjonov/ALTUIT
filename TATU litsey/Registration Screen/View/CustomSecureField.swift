//
//  CustomSecureField.swift
//  TATU litsey
//
//  Created by Abdulloh on 01/10/23.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    
    let title: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 17, weight: .semibold))
                .offset(x: 10)
                .padding(.bottom, 3)
            
            SecureField(placeholder, text: $text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.black)
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomSecureField(text: .constant(""), title: "Password", placeholder: "Password")
        .padding()
        .background(Color.gray)
}
