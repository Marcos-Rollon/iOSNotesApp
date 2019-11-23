//
//  Extensions UIButton.swift
//  GpsModulev2
//
//  Created by Marcos Rollón Rivas on 26/2/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    static func roundCornersButton ( withTitle title : String ) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize : 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.believeLightBlue()
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button.layer.masksToBounds = false
        button.layer.shadowOpacity = 0.5
        
        
        return button
    }
    
    static func whiteBackgroundButtonRoundedCorners(withTitle title : String, withFontSize size : CGFloat) -> UIButton{
        let button = UIButton()
        
        button.setTitle(title.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize : size)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor  = UIColor.lightTransparentBlue()
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = false
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        button.frame.size.height = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
