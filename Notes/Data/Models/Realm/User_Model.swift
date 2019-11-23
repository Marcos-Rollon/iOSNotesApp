//
//  User_Model.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel : Object{
    override class func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id : String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var password : String = ""
    @objc dynamic var role = 0
    
    static func newUserFromEmailAndPassword(email : String, password : String, role : Int) -> UserModel{
        let user = UserModel()
        user.id = IDGenerator.generateFromParams([email, password])
        user.name = email
        user.password = password
        user.role = role
        return user
    }
    
    func fromUserEntitie(_ u : User){
        self.id = u.id
        self.name = u.name
        let role : Int
        switch u.role {
        case .teamMember:
            role = 1
        case .root:
            role = 0
        }
        self.role = role
    }
    
    func toUserEntitie() -> User{
        let role : UserRole
        switch self.role {
        case 0:
            role = .root
        case 1:
            role = .teamMember
        default:
            role = .teamMember
        }
        let user = User(id: self.id, name: self.name, role: role)
        return user
    }
}
