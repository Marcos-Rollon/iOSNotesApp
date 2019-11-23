//
//  UserManager.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

struct UserManager {
    private let repository : UserRepository
    
    init(repository : UserRepository = UsersRepositoryImplementation()){
        self.repository = repository
    }
    public func getCurrentUser(completion : ((User?)->Void)){
        repository.getCurrentUser(completion: completion)
    }
    public func logoutCurrentUser(completion : ((_ success : Bool)-> Void)){
        repository.logoutCurrentUser(completion: completion)
    }
    public func loginWithEmailAndPassword(email : String, password: String,  completion : ((_ success : Bool)-> Void)){
        repository.logUserWithEmailAndPassword(email: email, password: password, completion: completion)
    }
    public func updateUser(userID : String, newUser: User , completion: ((_ success : Bool)-> Void)){
        repository.updateUser(userID: userID, newUser: newUser, completion: completion)
    }
    public func deleteUser(userID : String, completion : ((_ success : Bool)-> Void)){
        repository.deleteUser(userID: userID, completion: completion)
    }
    public func getUserByID(userID: String, completion : ((_ success : Bool)-> Void)){
        repository.getUserByID(userID: userID, completion: completion)
    }
    public func getAllUsers(completion: (([User])->Void)){
        repository.getAllUsers(completion: completion)
    }
    public func createNewUser(user : User, password: String , completion : ((_ success : Bool)-> Void)){
        repository.createUser(email: user.name, password: password, role: (user.role == .root) ? 0 : 1, completion: completion)
    }
    public func changeUserRole(_ user: User, completion : ((_ success : Bool)-> Void)){
        let newRole : UserRole = (user.role == .root) ? .teamMember : .root
        let newUser = User(id: user.id, name: user.name, role: newRole)
        repository.updateUser(userID: user.id, newUser: newUser, completion: completion)
    }
}
