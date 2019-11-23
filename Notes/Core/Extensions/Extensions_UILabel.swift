//
//  Extensions UILabel.swift
//  GpsModulev2
//
//  Created by Marcos Rollón Rivas on 5/3/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}

extension UILabel {
    static func normalLabel ( withTitle title : String, withFontSize fontSize : CGFloat, withTextColor textColor : UIColor)-> UILabel{
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = title
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }
    static func titleLabel ( withTitle title : String, withFontSize fontSize : CGFloat, withTextColor textColor : UIColor)-> UILabel{
        let label = UILabel()
        
        label.textColor = textColor
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.text = title
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }
    
    func makeOutline(strokeColor : UIColor){
        let strokeAttributes = [NSAttributedString.Key.strokeColor : strokeColor,
        NSAttributedString.Key.strokeWidth : -4.0] as [NSAttributedString.Key : Any]
        
        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeAttributes)
    }
}
