//
//  NotesButton.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NotesButton : UIButton{
        //MARK: - Init
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
    convenience init(text : String, textFont : UIFont = UIFont.systemFont(ofSize: 24), textColor : UIColor = .white, bgColor : UIColor = .lightBlue(), height : CGFloat = 55, borderColor : UIColor = .clear, borderWidth : CGFloat = 2){
            self.init()
            self.height(constant : height)
            self.setTitle(text, for: .normal)
            self.titleLabel?.font = textFont
            self.setTitleColor(textColor, for: .normal)
            self.backgroundColor = bgColor
            self.layer.cornerRadius = height / 2
            self.clipsToBounds = true
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
            self.titleEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        }
}
