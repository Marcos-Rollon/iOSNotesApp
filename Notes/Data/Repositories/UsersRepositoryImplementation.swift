//
//  UsersRepository.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class UsersRepositoryImplementation : UserRepository{

    
    private let localDataSource : UsersLocalDataSource
    
    init(localDataSource : UsersLocalDataSource = UsersLocalDataSourceImplementation()){
        self.localDataSource = localDataSource
    }
    
    func createUser(email: String, password: String, role : Int, completion: ((Bool) -> Void)) {
        localDataSource.createNewUser(email: email, password: password, role: role, completion: completion)
    }
    
    func getCurrentUser(completion: ((User?) -> Void)) {
        localDataSource.getCurrentUser(completion: completion)
    }
    
    func logUserWithEmailAndPassword(email: String, password: String, completion: ((Bool) -> Void)) {
        localDataSource.logUserWithEmailAndPassword(email: email, password: password, completion: completion)
    }
    
    func logoutCurrentUser(completion: ((Bool) -> Void)) {
        localDataSource.logoutUser(completion: completion)
    }
    
    func deleteUser(userID: String, completion: ((Bool) -> Void)) {
        localDataSource.deleteUser(userID: userID, completion: completion)
    }
    
    func updateUser(userID: String, newUser: User,  completion: ((Bool) -> Void)) {
        localDataSource.updateUser(userID: userID, newUser: newUser, completion: completion)
    }
    
    func getUserByID(userID: String, completion: ((Bool) -> Void)) {
        localDataSource.getUserByID(userID: userID, completion: completion)
    }
    
    func getAllUsers(completion: ([User]) -> Void) {
        localDataSource.getAllUsers(completion : completion)
    }
}
