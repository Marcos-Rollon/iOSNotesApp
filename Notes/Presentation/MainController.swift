//
//  MainController.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class MainController : UITabBarController{
    // MARK: - Properties
    private let userManager = UserManager()
    
    // MARK: - Init
    override func viewDidLoad(){
        super.viewDidLoad()
        checkIfUserIsSignedIn()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: - Helpers
    
    private func checkIfUserIsSignedIn(){
        userManager.getCurrentUser { (user) in
            // Present login screen or configure views
            DispatchQueue.main.async {
                if user == nil{
                    self.presentLoginScreen()
                }else {
                    self.configureViews()
                }
            }
        }
    }
    
    private func presentLoginScreen(){
        let controller = LoginScreenController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false, completion: nil)
    }
    
    public func configureViews(){
        // Config
        self.tabBar.barTintColor = .mainTurquoise()
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = false
        // Screens
        let mainScreen = UINavigationController( rootViewController: MainScreenController())
        let mainScreenItem = UITabBarItem(title: "Home", image: .homeIcon, tag: 0)
        mainScreen.tabBarItem = mainScreenItem
        
        let menuScreen = MenuScreenController()
        let menuScreenItem = UITabBarItem(title: "Menu", image: .menuIcon, tag: 1)
        menuScreen.tabBarItem = menuScreenItem
        menuScreen.shouldPresentLoginScreen = {
            [weak self] in
            self?.presentLoginScreen()
        }
        
        self.viewControllers = [
            mainScreen,
            menuScreen
        ]
    }
}
