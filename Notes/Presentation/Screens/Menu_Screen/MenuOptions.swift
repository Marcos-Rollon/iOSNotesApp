//
//  MenuOptions.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import UIKit

enum MenuOption : Int, CaseIterable, CustomStringConvertible{
    
    case settings
    case logOut
    
    var description: String {
        switch self {
        case .logOut:
            return "Logout"
        case .settings:
            return "Settings"
        }
    }
    
    var image : UIImage {
        switch self {
        case .logOut:
            return .logoutIcon
        case .settings:
            return .settingsIcon
        }
    }
}
