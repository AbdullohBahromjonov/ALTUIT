//
//  UserModel.swift
//  TATU litsey
//
//  Created by Abdulloh on 22/08/23.
//

import Foundation

class User: ObservableObject {
    
    @Published var group: String
    @Published var subgroup: String
    @Published var language: String
    
    init(group: String, subgroup: String, language: String) {
        self.group = group
        self.subgroup = subgroup
        self.language = language
    }
}
