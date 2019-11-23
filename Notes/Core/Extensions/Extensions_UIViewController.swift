//
//  Extensions UIViewController.swift
//  believeAppv01
//
//  Created by Marcos Rollón Rivas on 26/3/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

extension UIViewController{
    func hideKeyboardWhenTappedAround(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func addUnderConstructionLabel(text : String? = nil){
        let label = UILabel()
        if let text = text {
            label.text = text
        }
        else {
            label.text = "UNDER CONSTRUCTION"
        }
        label.font = UIFont.systemFont(ofSize: 30)
        label.alpha = 0.4
        
        self.view.addSubview(label)
        label.center(inView: self.view)
        self.view.bringSubviewToFront(label)
    }
}
