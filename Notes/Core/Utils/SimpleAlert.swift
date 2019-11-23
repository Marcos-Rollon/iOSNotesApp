//
//  SimpleAlert.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit
/// Creates a simple alert to display a message, with just one button action that dismisses it
struct SimpleAlert {
    // Dont allow init on this struct
    private init (){}
    
    static func create(title : String, content : String, buttonText : String = "OK") -> UIAlertController{
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
        return alert
    }
}
