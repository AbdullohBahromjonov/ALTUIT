//
//  ScheduleModel.swift
//  TATU litsey
//
//  Created by Abdulloh on 20/09/23.
//

import Foundation

struct ScheduleModel: Decodable {
    let weekday: String
    let subjects: [String]
}
