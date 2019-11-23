//
//  IconButton.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class IconButton : UIButton {
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(icon : UIImage, backgroundColor : UIColor, diameter : CGFloat = 0){
        self.init()
        self.setImage(icon, for: .normal)
        self.backgroundColor = backgroundColor
//        self.layer.cornerRadius = diameter / 2
//        self.clipsToBounds = true
        if diameter > 0{
            self.height(constant: diameter)
            self.width(constant: diameter)
        }
    }
}
