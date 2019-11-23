//
//  LoginScreenViewModel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class LoginScreenViewModel{
    
    // MARK: - Properties
    private var userManager : UserManager
    
    public var email : String?
    public var password : String?
    
    // MARK: - Init
    
    init(userManager : UserManager = UserManager()) {
        self.userManager = userManager
    }
    
    // MARK: - Public API
    public func handleLogin(completion : ((_ success : Bool)-> Void)){
        // Check for correct fields
        guard
            let selectedEmail = self.email,
            let selectedPassword = self.password,
            !selectedEmail.isEmpty,
            !selectedPassword.isEmpty
        else {
            completion(false)
            return
        }
        
        logUserWithEmailAndPassword(email: selectedEmail, password: selectedPassword, completion: completion)
        
    }
    
    private func logUserWithEmailAndPassword(email : String, password : String, completion : ((_ success : Bool)-> Void)){
        userManager.loginWithEmailAndPassword(email: email, password: password, completion: completion)
    }
    
}
