//
//  IdGenerator.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

struct IDGenerator {
    ///Generates a random string
    static func generate() -> String{
        return UUID.init().uuidString
    }
    /// Generates a random string with some extra  parameters mixed in
    static func generateFromParams<T : LosslessStringConvertible>(_ params : Array<T>) -> String{
        var randomString : String = self.randomString(length: 6)
        for param in params{
            let randomPart : String = String(param).trimmingCharacters(in: .whitespaces) + self.randomString(length: Int.random(in: 1..<7))
            randomString += "_" + randomPart
        }
        return randomString
    }
    
    private static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
