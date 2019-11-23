//
//  MenuScreenController.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class MenuScreenController : UIViewController{
    // MARK: - Views
    private let menuTable = MenuTableView()
    private let infoLabel = NotesLabel(type: .subtitle)
    
    // MARK: - Properties
    private let viewModel = MenuScreenViewModel()

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Public api
    public var shouldPresentLoginScreen : (()->Void)? = nil
    
    
    // MARK: - Helpers
    private func configureViews(){
        // Config
        self.view.accessibilityIdentifier = "MenuView"
        self.configureBackground()
        self.menuTable.delegate = self
        viewModel.getCurrentUser { (user) in
            if user != nil{
                self.infoLabel.text = "You are logged in as " + user!.name
            }
        }
        // Layout
        self.add(menuTable)
        self.infoLabel.pinToBottomRight(of: self.view, padding: 10)
    }
    
    private func configureBackground(){
        let bgView = UIImageView(image: .chillOceanWallpaper)
        bgView.addColorFilter(color: .mainGreen(), opacity: 0.35)
        bgView.contentMode = .scaleAspectFill
        bgView.fill(theView: self.view)
    }
    
    private func handleLogOut(){
        let alert = UIAlertController(title: "Notes", message: "Are you sure you want to logout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.viewModel.handleLogout { (success) in
                if !success{
                    let alert = SimpleAlert.create(title: "Ups!", content: "Something went wrong")
                    self.present(alert, animated: true, completion: nil)
                    return
                }else {
                    self.shouldPresentLoginScreen?()
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func handleSettings(){
        viewModel.getCurrentUser { (user) in
            if let u = user {
                if u.role != .root {
                    self.present(SimpleAlert.create(title: "Ups", content: "You don't have authorization to do that!"), animated: true, completion: nil)
                } else {
                    // let controller = UINavigationController(rootViewController: ManageUserScreenController())
                    let controller = ManageUserScreenController()
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }
            }
        }
    }
}

extension MenuScreenController : MenuTableViewDelegate{
    func handleMenuOptionSelected(_ menuOption: MenuOption) {
        switch menuOption {
            case .logOut:
                self.handleLogOut()
            case .settings:
                self.handleSettings()
        }
    }
    
}
