//
//  UsersLocalDataSource.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

protocol UsersLocalDataSource {
    func getCurrentUser(completion : ((User?)->Void))
    func logUserWithEmailAndPassword(email: String, password : String, completion: ((Bool)-> Void))
    func logoutUser(completion : ((Bool)->Void))
    func createNewUser(email : String, password : String, role : Int,  completion : ((Bool)->Void))
    func updateUser(userID : String, newUser : User, completion : ((Bool)->Void))
    func deleteUser(userID : String, completion : ((Bool)->Void))
    func getAllUsers(completion : ([User])->Void)
}


