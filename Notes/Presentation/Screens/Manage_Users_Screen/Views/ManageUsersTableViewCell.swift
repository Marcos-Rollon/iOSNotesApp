//
//  ManageUsersTableViewCell.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 22/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class ManageUsersTableViewCell : UITableViewCell{
    static let reuseIdentifier = "ManageUsersTableViewCell"
    
    // MARK: - Views
    private lazy var content        = UIView()
    private lazy var deleteButton   = IconButton(icon: .trashIcon, backgroundColor: .clear)
    private lazy var changeRoleButton = IconButton(icon: .changeIcon, backgroundColor: .clear)
    private lazy var nameLabel      = NotesLabel(type: .title, aligment: .left, maxLineNumber: 1)
    private lazy var userRoleImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        //iv.width(constant: 60)
        return iv
    }()
    
    // MARK: - Properties
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("Ups, not implemented")
    }
    
    // MARK: - Public API
    public func configure(_ user : User){
        nameLabel.text = user.name
        switch user.role {
        case .teamMember:
            userRoleImage.image = .userIcon
        case .root:
            userRoleImage.image = .superuserIcon
        }
    }
    
    public var didTapTrashIcon : (()->Void)? = nil
    public var didTapChangeRoleIcon : (()->Void)? = nil
    
    // MARK: - Selectors
    @objc private func handleTrashIcon(){
        didTapTrashIcon?()
    }
    @objc private func handleRoleIcon(){
        didTapChangeRoleIcon?()
    }
    // MARK: - Helpers
    private func configureViews(){
        // Config
        configureBackground()
        deleteButton.addTarget(self, action: #selector(handleTrashIcon), for: .touchUpInside)
        changeRoleButton.addTarget(self, action: #selector(handleRoleIcon), for: .touchUpInside)
        
        // Layout
        let hstack = HorizontalStackView()
        hstack.setDistribution(.fillEqually)
        hstack.setSpacing(spacing: 8)
        hstack.add(userRoleImage)
        hstack.add(nameLabel)
        hstack.add(changeRoleButton)
        hstack.add(deleteButton)
        hstack.fillWithSidesInsets(theView: content, withInsets: 12)
        content.height(constant: 100)
    }
    
    private func configureBackground(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
        content.clipsToBounds = true
        content.layer.cornerRadius = 10
        content.backgroundColor = .mainGreen()
        content.fillWithInset(theView: self, withSidesInsets: 12, withVerticalInsets: 8)
    }
}
