//
//  Extensions UITextField.swift
//  believeAppv01
//
//  Created by Marcos Rollón Rivas on 1/4/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit



extension UITextField{
    //This creates the textfield
    static func textField(withPlaceholder placeholder : String, isSecureTextEntry : Bool) -> UITextField{
        let tf = UITextField()
        tf.borderStyle = .none
        tf.backgroundColor = UIColor.rgbWithAlpha(red: 30, green: 30, blue: 30, alpha: 0.5)
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.isSecureTextEntry = isSecureTextEntry
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        return tf
    }
}
