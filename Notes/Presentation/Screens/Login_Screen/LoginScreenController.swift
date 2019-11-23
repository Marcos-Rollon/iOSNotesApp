//
//  LoginScreenController.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class LoginScreenController : UIViewController{
    // MARK: - Views
    private let loginTitle = LoginTitleLabel()
    private let subtitleLabel = NotesLabel(type: .subtitle, text: "The app to take pho... no. Wait. Notes, the app to take notes", fontSize: 22, aligment: .justified, maxLineNumber: 0, textColor: .white)
    private let usernameTextField   = NotesSingleLineInput(placeholder: "Username")
    private let passwordTextField   = NotesSingleLineInput(placeholder: "Password")
    private let loginButton         = NotesButton(text: "Login")
    
    // MARK: - Properties
    private let viewModel = LoginScreenViewModel()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    //MARK: - Selectors
    @objc private func handleLoginBtn(){
        viewModel.handleLogin { [weak self] (success) in
            if !success{
                let alert = SimpleAlert.create(title: "Ups!", content: "Error login in, are you sure your credentials are correct?")
                self?.present(alert, animated: true)
                return
            }
            self?.dismissToMainController()
        }
    }
    
    // MARK: - Helpers
    private func dismissToMainController(){
        guard let mainController = UIApplication.shared.keyWindow?.rootViewController as? MainController else {
            return
        }
        mainController.configureViews()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configureViews(){
        // Config
        configureBackground()
        loginButton.addTarget(self, action: #selector(handleLoginBtn), for: .touchUpInside)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.didChooseText = {
            [weak self] text in
            self?.viewModel.password = text
        }
        usernameTextField.keyboardType = .emailAddress
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.didChooseText = {
            [weak self] text in
            self?.viewModel.email = text
        }
        // Layout
        let vstack = VerticalStackView()
        vstack.setSpacing(spacing: 16)
        vstack.addSpacing(ofHeight: 30)
        vstack.add(loginTitle)
        vstack.add(subtitleLabel)
        vstack.addSpacing(ofHeight: 30)
        vstack.add(usernameTextField)
        vstack.add(passwordTextField)
        vstack.addSpacing(ofHeight: 20)
        vstack.add(loginButton)
        vstack.addSpacing(ofHeight: 20)
        
        vstack.fillWithInset(theView: self.view, withSidesInsets: 20, withVerticalInsets: 10)
    }
    
    private func configureBackground(){
        let bgView = UIImageView(image : .chillCampfireWallpaper)
        bgView.contentMode = .scaleAspectFill
        bgView.addColorFilter(color: .mainTurquoise(), opacity: 0.25)
        bgView.fill(theView: self.view)
    }
}
