//
//  MenuCell.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class MenuOptionCell : UITableViewCell {
    
    static let reuseIdentifier = "MenuOptionCell"
    
    //MARK: - Views
    
    private let iconImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let descriptionLabel : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = " - "
        return label
    }()
    
    // MARK: - Public API
    public func configure(text : String, image : UIImage){
        self.descriptionLabel.text = text
        self.iconImage.image = image
    }

    //MARK: - Init
    
    override init ( style : UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        addSubview(iconImage)
        iconImage.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        iconImage.centerY(inView: self)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nil, left: iconImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        descriptionLabel.centerY(inView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
