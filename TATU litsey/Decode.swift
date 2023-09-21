//
//  Decode.swift
//  TATU litsey
//
//  Created by Abdulloh on 09/09/23.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T? {
        let emptyData: T? = nil
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            error = "Bugungi darslikingiz topilmadi 😔"
            return emptyData
        }
        
        guard let data = try? Data(contentsOf: url) else {
            error = "Xatolik yuz berdi 🤕"
            return emptyData
        }
        
        let jsonDecoder = JSONDecoder()
        
        guard let loadedData = try? jsonDecoder.decode(T.self, from: data) else {
            error = "Xatolik yuz berdi 🤕"
            return emptyData
        }
        
        return loadedData
    }
}
