//
//  SubjectModel.swift
//  TATU litsey
//
//  Created by Abdulloh on 05/09/23.
//

import Foundation

struct Subject: Decodable, Hashable {
    let name: String
    let startTime: String
    let endTime: String
    let room: String
    let teacher: String
}
