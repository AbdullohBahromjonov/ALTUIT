//
//  CustomTextField.swift
//  TATU litsey
//
//  Created by Abdulloh on 13/08/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    
    @State var pickerPressed = false
    @State var a = "uzs"
    
    let name: String
    let title: String
    var picker = false
    var array = ["0"]
    var pickItemPrefix = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .semibold))
                .offset(x: 10)
            
            TextField(title, text: $text)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                )
                .disabled(picker)
        }
        .padding(.horizontal)
        .overlay(
            HStack {
                if picker {
                    Spacer()
                    
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
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                .rotationEffect(pickerPressed ? Angle(degrees: 180): .zero)
                                .frame(width: 10, height: 7)
                        }
                    )
                    .offset(x: -2, y: 3)
                    .onTapGesture {
                        pickerPressed.toggle()
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 30)
        )
    }
}


struct CustomTextField_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        CustomTextField(text: $text, name: "Email", title: "Email")
        CustomTextField(text: $text, name: "Email", title: "Email", picker: true, array: ["1", "2", "3"])
    }
}
