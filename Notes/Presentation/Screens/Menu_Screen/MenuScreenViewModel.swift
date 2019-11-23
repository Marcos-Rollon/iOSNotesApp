//
//  MenuScreenViewModel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class MenuScreenViewModel {
    
    private let usersManager : UserManager
    
    init(usersManager : UserManager = UserManager()) {
        self.usersManager = usersManager
    }
    
    public func getCurrentUser( completion : ((User?)->Void)){
        usersManager.getCurrentUser(completion: completion)
    }
    
    public func handleLogout(completion : ((Bool)->Void)){
        usersManager.logoutCurrentUser(completion: completion)
    }
}
