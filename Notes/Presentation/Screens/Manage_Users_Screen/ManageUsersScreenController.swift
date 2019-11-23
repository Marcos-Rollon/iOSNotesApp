//
//  ManageUsersScreenController.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 21/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class ManageUserScreenController : UIViewController{
    // MARK: - Views
    private let backButton : IconButton = {
        let btn = IconButton(icon: .leftArrowIcon, backgroundColor: .mainTurquoise(), diameter: 60)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        return btn
    }()
    private let createUserButtn : IconButton = {
        let btn = IconButton(icon: .addButtonIcon, backgroundColor: .mainTurquoise(), diameter: 60)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        return btn
    }()
    private let titleLabel = NotesLabel(type: .title, text: "Users", textColor: .mainTurquoise())
    private let tableView = ManageUsersTableView()
    
    // MARK: - Properties
    private let viewModel = ManageUsersScreenViewModel()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    deinit {
        print("[ManageUsersScreen] Deinit")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAllUsers { (users) in
            self.tableView.setUsers(users)
        }
    }
    
    //MARK: - Selectors
    @objc private func handleBackButton(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func handleCreateUsersButton(){
        let controller = CreateUserScreenController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Config
        configureBackground()
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        createUserButtn.addTarget(self, action: #selector(handleCreateUsersButton), for: .touchUpInside)
        self.tableView.delegate = self
        self.add(tableView)
        let header = UIView()
        header.height(constant: 80)
        
        // Layout
        backButton.pinToTopLeft(of: header, sidesPadding: 10, verticalPadding: 10, pinToSafeArea: true)
        createUserButtn.pinToTopRight(of: header, sidesPadding: 10, verticalPadding: 10, pinToSafeArea: true)
        header.addSubview(titleLabel)
        titleLabel.center(inView: header)
        header.pinToTopAndSides(of: self.view, pinToSafeArea: true)
        self.view.addSubview(tableView.view)
        tableView.view.anchor(top: header.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    private func configureBackground(){
        self.view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension ManageUserScreenController : ManageUsersTableViewDelegate{
    func didSwipeToDeleteUser(at indexPath: IndexPath) {
        viewModel.deleteUser(at: indexPath) { (success) in
            if success {
                self.tableView.deleteUsers(at: indexPath)
            }else{
                print("[ManageUsersScreen] Can't delete user")
            }
        }
    }
    
    func didSwipeToChangeRole(at indexPath: IndexPath) {
        viewModel.changeUserRole(forUserAt: indexPath) { (success) in
            if success {
                tableView.changeUserRole(at: indexPath)
            } else{
                print("[ManageUsersScreen] Can't change user role")
            }
        }
    }
    
    func didTapUser(at indexPath : IndexPath) {
         
    }
}
