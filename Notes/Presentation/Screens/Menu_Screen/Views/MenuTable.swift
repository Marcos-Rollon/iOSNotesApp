//
//  MenuTable.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

protocol MenuTableViewDelegate : AnyObject{
    func handleMenuOptionSelected(_ menuOption : MenuOption)
}

class MenuTableView : UIViewController{
    
    // MARK: - Views
    private var tableView : UITableView!
    
    // MARK: - Properties
    public var delegate : MenuTableViewDelegate? = nil
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    // MARK: - Helpers
    private func configureViews(){
        self.view.accessibilityIdentifier = "MenuView"
        self.configureBackground()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: MenuOptionCell.reuseIdentifier)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.rowHeight     = 100
        tableView.fill(theView: self.view)
    }
    
    private func configureBackground(){
        self.view.backgroundColor = .clear
    }
}

// MARK: - Table View extension
extension MenuTableView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuOptionCell.reuseIdentifier, for: indexPath) as! MenuOptionCell
        guard let menuOption = MenuOption(rawValue: indexPath.row) else {return cell}
        cell.configure(text: menuOption.description, image: menuOption.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let option = MenuOption(rawValue: indexPath.row) else {return}
        delegate?.handleMenuOptionSelected(option)
    }
    
}
