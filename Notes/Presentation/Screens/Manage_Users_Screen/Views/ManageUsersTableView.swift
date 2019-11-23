//
//  ManageUsersTableView.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 22/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

protocol ManageUsersTableViewDelegate : AnyObject{
    func didSwipeToDeleteUser(at indexPath : IndexPath)
    func didSwipeToChangeRole(at indexPath : IndexPath)
    func didTapUser(at indexPath : IndexPath)
}

class ManageUsersTableView : UIViewController{
    
    // MARK: - Views
    private var tableView : UITableView!
    
    // MARK: - Parameters
    private var users : [User] = []
    
    // MARK: - Public API
    public weak var delegate : ManageUsersTableViewDelegate? = nil
    
    public func setUsers(_ users : [User]){
        self.users = users
        tableView.reloadData()
    }
    
    public func changeUserRole(at indexPath : IndexPath){
        let oldUser = self.users[indexPath.row]
        let newRole : UserRole
        switch oldUser.role {
            case .teamMember:
                newRole = .root
            case .root:
                newRole = .teamMember
        }
        let newUser = User(id: oldUser.id, name: oldUser.name, role: newRole)
        self.users.remove(at: indexPath.row)
        self.users.insert(newUser, at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    public func deleteUsers(at indexPath : IndexPath){
        self.users.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Setup
        setupTableView()
        // Layout
        tableView.fill(theView: self.view)
    }
    
    private func setupTableView(){
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.allowsSelection = true
        tableView.backgroundColor   = .clear
        tableView.separatorStyle    = .none
        tableView.register(ManageUsersTableViewCell.self, forCellReuseIdentifier: ManageUsersTableViewCell.reuseIdentifier)
    }
    
    private func deleteAction(at indexPath : IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.delegate?.didSwipeToDeleteUser(at: indexPath)
            completion(true)
        }
        action.image = .trashIcon
        action.backgroundColor = .googleRed()
        return action
    }
    
    private func changeRoleAction(at indexPath : IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Role") { (action, view, completion) in
            self.delegate?.didSwipeToChangeRole(at: indexPath)
            completion(true)
        }
        action.image = (self.users[indexPath.row].role == .root) ? .superuserIcon : .userIcon
        action.backgroundColor = .mainTurquoise()
        return action
    }
}

// MARK: - Table view extension
extension ManageUsersTableView : UITableViewDelegate, UITableViewDataSource{
    // Config
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ManageUsersTableViewCell.reuseIdentifier, for: indexPath) as! ManageUsersTableViewCell
        let user = users[indexPath.row]
        cell.configure(user)
        cell.didTapChangeRoleIcon = {
            [weak self] in
            self?.delegate?.didSwipeToChangeRole(at: indexPath)
        }
        cell.didTapTrashIcon = {
            [weak self] in
            self?.delegate?.didSwipeToDeleteUser(at: indexPath)
        }
        return cell
    }
    
    // Swipe actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction( at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let changeRole = changeRoleAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [changeRole])
    }
    
    // Tap action
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didTapUser(at: indexPath)
    }
}
