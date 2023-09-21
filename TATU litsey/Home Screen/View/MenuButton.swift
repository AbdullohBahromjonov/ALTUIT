//
//  MenuButton.swift
//  TATU litsey
//
//  Created by Abdulloh on 09/09/23.
//

import SwiftUI

struct MenuButton: View {
    let action: () -> Void
    let image: String
    
    var body: some View {
        Button(
            action: action,
            label: {
                Image(systemName: image)
                    .foregroundColor(.white)
                    .font(.system(size: 40))
            }
        )
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(action: {}, image: "square.grid.2x2")
    }
}
