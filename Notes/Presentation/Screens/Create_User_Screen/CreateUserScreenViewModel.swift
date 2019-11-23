//
//  CreateUserScreenViewModel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 23/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class CreateUserScreenViewModel {
    
    // MARK: - Properties
    private let userManager : UserManager
    public var username : String?
    public var password : String?
    public var confirmedPassword : String?
    public var role : UserRole = .teamMember
    
    // MARK: - Init
    init( userManager : UserManager = UserManager()){
        self.userManager = userManager
    }
    
    // MARK: - Create User
    
    public func createUser(completion :((Bool)-> Void)){
        guard let username = username,
            let password = password,
            let confirmedPassword = confirmedPassword,
            password == confirmedPassword else{
                completion(false)
                return
        }
        let user = User(id: IDGenerator.generateFromParams([username]), name: username, role: self.role)
        userManager.createNewUser(user: user, password: password, completion: completion)
    }
}
