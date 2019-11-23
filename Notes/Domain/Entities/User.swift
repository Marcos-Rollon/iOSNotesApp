//
//  User.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

struct User : Equatable {
    // Equatable conformation
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id : String
    let name : String
    let role : UserRole
}

enum UserRole : CaseIterable, CustomStringConvertible{
    case teamMember
    case root
    
    var description: String {
        switch self {
        case .teamMember:
            return "Team Member"
        case .root:
            return "Super user"
        }
    }
    
    var assetName : String {
        switch self {
        case .teamMember:
            return "user_icon"
        case .root:
            return "superuser_icon"
        }
    }
}
