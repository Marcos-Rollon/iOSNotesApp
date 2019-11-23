//
//  CreateUserScreenController.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 23/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class CreateUserScreenController : UIViewController{
    // MARK: - Views
    private let titleLabel = NotesLabel(type: .title, text: "Create a new User", textColor: .mainTurquoise())
    private let backButton : IconButton = {
        let btn = IconButton(icon: .leftArrowIcon, backgroundColor: .mainTurquoise(), diameter: 60)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        return btn
    }()
    private let userNameInput : NotesSingleLineInput = NotesSingleLineInput(placeholder: "Username")
    private let passwordInput : NotesSingleLineInput = NotesSingleLineInput(placeholder: "Password")
    private let confirmPasswordInput : NotesSingleLineInput = NotesSingleLineInput(placeholder: "Confirm password")
    private let roleSelector = NoteUserRoleSelectorView()
    private let createButton = NotesButton(text: "Create")
    
    // MARK: - Properties
    private let viewModel = CreateUserScreenViewModel()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    deinit{
        print("[CreateUsersScreen] Deinit")
    }
    
    // MARK: - Selectors
    @objc private func handleBackButton(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func handleCreateButton(){
        viewModel.createUser { (succ) in
            if !succ {
                UIView.shake(view: self.createButton)
                let alarm = SimpleAlert.create(title: "Ups!", content: "Can't create user, are you sure you filled all the forms? Are your two passwords the same?")
                self.present(alarm, animated: true, completion: nil)
            } else {
                self.handleBackButton()
            }
        }
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Config
        self.view.backgroundColor = .white
        self.backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        self.createButton.addTarget(self, action: #selector(handleCreateButton), for: .touchUpInside)
        userNameInput.autocorrectionType = .no
        userNameInput.autocapitalizationType = .none
        passwordInput.autocorrectionType = .no
        passwordInput.autocapitalizationType = .none
        confirmPasswordInput.autocorrectionType = .no
        confirmPasswordInput.autocapitalizationType = .none
        let header = UIView.createEmptyView(ofHeight: 35)
        roleSelector.height(constant: 90)
        userNameInput.didChooseText = {
            [weak self] text in
            self?.viewModel.username = text
        }
        passwordInput.didChooseText = {
            [weak self] text in
            self?.viewModel.password = text
        }
        confirmPasswordInput.didChooseText = {
            [weak self] text in
            self?.viewModel.confirmedPassword = text
        }
        roleSelector.didChooseRole = {
            [weak self] role in
            self?.viewModel.role = role
        }
        // Layout
        self.backButton.pinToTopLeft(of: header, sidesPadding: 10, verticalPadding: 10, pinToSafeArea: true)
        let vstack = VerticalStackView()
        vstack.setSpacing(spacing: 12)
        vstack.add(titleLabel)
        vstack.add(userNameInput)
        vstack.add(passwordInput)
        vstack.add(confirmPasswordInput)
        vstack.add(roleSelector)
        vstack.add(createButton)
        vstack.addSpacing(ofHeight: 20)
        
        header.pinToTopAndSides(of: self.view)
        self.view.addSubview(vstack)
        vstack.anchor(top: header.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
    }
    
}
