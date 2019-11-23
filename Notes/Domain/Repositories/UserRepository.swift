//
//  UserRepository.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

protocol UserRepository {
    func getCurrentUser(completion : ((User?)->Void))
    func logUserWithEmailAndPassword(email : String, password : String, completion : ((_ success : Bool)-> Void))
    func logoutCurrentUser(completion : ((_ success : Bool)-> Void))
    func createUser(email : String, password : String, role : Int, completion : ((_ success : Bool)-> Void))
    func deleteUser(userID : String, completion : ((_ success : Bool)-> Void))
    func updateUser(userID : String, newUser : User, completion : ((_ success : Bool)-> Void))
    func getUserByID(userID : String, completion : ((_ success : Bool)-> Void))
    func getAllUsers(completion : ([User])->Void)
}
