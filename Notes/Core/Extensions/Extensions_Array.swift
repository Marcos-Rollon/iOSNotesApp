//
//  Extensions_Array.swift
//  BelieveApp
//
//  Created by Marcos Rollón Rivas on 17/07/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
