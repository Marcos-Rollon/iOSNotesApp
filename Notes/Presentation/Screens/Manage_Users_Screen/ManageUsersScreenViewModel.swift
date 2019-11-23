//
//  ManageUsersScreenViewModel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 22/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class ManageUsersScreenViewModel {
    private let usersManager : UserManager
    
    private var users : [User] = []
    
    init(usersManager : UserManager = UserManager()){
        self.usersManager = usersManager
    }
    
    public func deleteUser(at indexPath : IndexPath, completion : ((Bool)->Void)){
        usersManager.getCurrentUser { (user) in
            guard let user = user else {
                completion(false)
                return
            }
            if user.id == self.users[indexPath.row].id{
                print("You can't eliminate yourself!")
                completion(false)
                return
            }else{
                usersManager.deleteUser(userID: self.users[indexPath.row].id, completion: completion)
            }
        }
    }
    
    public func changeUserRole(forUserAt indexPath : IndexPath, completion : ((Bool)->Void)){
        usersManager.getCurrentUser { (user) in
            guard let user = user else {
                completion(false)
                return
            }
            if user.id == self.users[indexPath.row].id{
                print("You can't change your own role, make another root user and change it from there")
                completion(false)
                return
            } else{
                usersManager.changeUserRole(self.users[indexPath.row], completion: completion)
            }
        }
        
    }
    
    public func getAllUsers(completion : (([User])->Void)){
        usersManager.getAllUsers { (users) in
            self.users = users
            completion(self.users)
        }
    }
}
