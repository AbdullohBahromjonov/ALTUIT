//
//  CustomTextField.swift
//  TATU litsey
//
//  Created by Abdulloh on 13/08/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    
    let title: String
    let placeholder: String
    var picker = false
    var array = ["0"]
    var pickItemPrefix = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 17, weight: .semibold))
                .offset(x: 10)
                .padding(.bottom, 3)
            
            TextField(placeholder, text: $text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.black)
                )
                .disabled(picker)
                .overlay {
                    if picker {
                        ZStack {
                            HStack {
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .foregroundColor(.black)
                                    .padding(.trailing)
                            }
                            
                            Menu(
                                content: {
                                    ForEach(array, id: \.self) { item in
                                        Button(
                                            action: {
                                                text = String(item)
                                            },
                                            label: {
                                                Text("\(item)\(pickItemPrefix)")
                                            }
                                        )
                                    }
                                },
                                label: {
                                    Color.clear
                                }
                            )
                        }
                    }
                }
        }
        .padding(.horizontal)
    }
}


struct CustomTextField_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        CustomTextField(text: $text, title: "Email", placeholder: "Email")
            .padding()
            .background(Color.assets.secondary)
            .preferredColorScheme(.light)
    }
}
