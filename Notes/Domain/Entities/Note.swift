//
//  Note.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

// Core dependency
import Foundation

struct Note : Equatable{
    let id : String
    let title : String
    let content : String
    let type : NoteType
    let date : Date
}

enum NoteType{
    case personal
    case work
    case other
    case finance
    
    // This needs to be mantained if added new cases
    static var allCases : [NoteType] = [
        .personal, .work, .other, .finance
    ]
    
    var name : String {
        switch self {
            case .personal:
                return "Personal"
            case .work:
                return "Work"
            case .other:
                return "Other"
            case .finance:
                return "Finances"
        }
    }
    
    var assetName : String {
        switch self {
            case .personal:
                return "personal_type_image"
            case .work:
                return "work_type_image"
            case .other:
                return "other_type_image"
            case .finance:
                return "finance_type_image"
        }
    }
}
