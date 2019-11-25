//
//  UsersLocalDataSourceImplementation.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import RealmSwift

class UsersLocalDataSourceImplementation : UsersLocalDataSource{
    
    // Default realm instance
    private let realm = try! Realm()
    // Primary key for the current user
    private let currentUserID = "Current_User"
    
    func getCurrentUser(completion: ((User?) -> Void)) {
        let currentUser = realm.object(ofType: UserModel.self, forPrimaryKey: currentUserID)
        if let currentUser = currentUser{
            let user = self.findUserByName(currentUser.name).first
            
            completion(user?.toUserEntitie())
        }else {
            completion(nil)
        }
    }
    
    func logUserWithEmailAndPassword(email: String, password: String, completion: ((Bool) -> Void)) {
        let predicate = NSPredicate(format: "name = %@ AND password = %@", email, password)
        let users = realm.objects(UserModel.self).filter(predicate)
        if users.count != 1{
            completion(false)
        }else {
            // User succesfully logged in
            completion(true)
            // Save current user for next sessions
            self.writeCurrentUser(users.first!) { (succs) in
                if !succs{
                    print("[UserLocalDatasource] Error setting Current user")
                }
            }
        }
    }
    
    func logoutUser(completion: ((Bool) -> Void)) {
        // Find if there is a current user
        if let currentUser = realm.object(ofType: UserModel.self, forPrimaryKey: currentUserID){
            self.deleteUser(currentUser) { (succ) in
                completion(succ)
            }
        } else {
            completion(false)
        }
    }
    
    func createNewUser(email: String, password: String, role : Int, completion: ((Bool) -> Void)) {
        // Check if there is a user with this name
        if findUserByName(email).count > 0{
            completion(false)
            return
        }
        // Create it
        do{
            try realm.write {
                let user = UserModel.newUserFromEmailAndPassword(email: email, password: password, role: role)
                realm.add(user)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    func updateUser(userID: String, newUser: User,  completion: ((Bool) -> Void)) {
        // Implement this
        let userModels = self.findUserByID(userID)
        // Check for only 1 note
        if let userModel = userModels.first, userModels.count == 1{
            do{
                try realm.write {
                    userModel.name = newUser.name
                    let role : Int
                    switch newUser.role {
                    case .teamMember:
                        role = 1
                    case .root:
                        role = 0
                    }
                    userModel.role = role
                    completion(true)
                }
            } catch{
                completion(false)
            }
            
        }else {
            print("[NotesLocalDataSourceImpl] None or more than one note to edit")
            completion(false)
        }
        completion(true)
    }
    
    func deleteUser(userID: String, completion: ((Bool) -> Void)) {
        // Find the user to delete
        guard let user = self.findUserByID(userID).first else {
            completion(false)
            return
        }
        // Delete it
        self.deleteUser(user, completion: completion)
    }
    
    func getAllUsers(completion: ([User]) -> Void) {
        
        let predicate = NSPredicate(format: "id != %@", currentUserID)
        let usersModels = realm.objects(UserModel.self).filter(predicate)
        let users : [User] = usersModels.map { (model) -> User in
            return model.toUserEntitie()
        }
        completion(users)
    }
    
    // MARK: - Helpers
    private func findUserByName(_ name : String) -> Results<UserModel>{
        let predicate = NSPredicate(format: "name = %@", name)
        let users = realm.objects(UserModel.self).filter(predicate)
        return users
    }
    
    private func findUserByID(_ id : String)-> Results<UserModel>{
        let predicate = NSPredicate(format: "id = %@", id)
        let users = realm.objects(UserModel.self).filter(predicate)
        return users
    }
    
    private func deleteUser ( _ u : UserModel, completion : ((Bool)-> Void)){
        do{
            try realm.write {
                realm.delete(u)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    private func writeCurrentUser(_ u : UserModel, completion : ((Bool)-> Void)){
        // Create the new current user
        let user = UserModel()
        user.id = currentUserID
        user.name = u.name
        user.password = u.password
        user.role = u.role
        do{
            try realm.write {
                // Delete the old current user
                if let currentUser = realm.object(ofType: UserModel.self, forPrimaryKey: currentUserID){
                    realm.delete(currentUser)
                }
                // Add the new one
                realm.add(user)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
}
