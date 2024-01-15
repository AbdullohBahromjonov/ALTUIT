//
//  CustomButton.swift
//  TATU litsey
//
//  Created by Abdulloh on 23/09/23.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    let action: () -> Void
    var image: String? = nil
    
    var body: some View {
        Button(
            action: action,
            label: {
                HStack {
                    Text(text)
                        .font(.system(size: 17, weight: .semibold))
                    
                    if let image {
                        Image(systemName: image)
                    }
                }
                
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.assets.blue)
                    )
                    .padding(.horizontal, 20)
            }
        )
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Keyingisi", action: {}, image: "chevron.right")
    }
}
