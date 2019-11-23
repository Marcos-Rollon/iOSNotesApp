//
//  Extensions UIView.swift
//  GpsModulev2
//
//  Created by Marcos Rollón Rivas on 26/2/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? , left: NSLayoutXAxisAnchor?, bottom : NSLayoutYAxisAnchor? , right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft : CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func pinToBottomRight(of view : UIView, padding : CGFloat){
        view.addSubview(self)
        self.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: padding, paddingRight: padding, width: 0, height: 0)
    }
    
    func pinToTopAndSides(of view: UIView, sidesPadding : CGFloat = 0, verticalPadding : CGFloat = 0, pinToSafeArea : Bool = false){
        view.addSubview(self)
        if pinToSafeArea{
            self.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: verticalPadding, paddingLeft: sidesPadding, paddingBottom: verticalPadding, paddingRight: sidesPadding, width: 0, height: 0)
        } else {
            self.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: verticalPadding, paddingLeft: sidesPadding, paddingBottom: verticalPadding, paddingRight: sidesPadding, width: 0, height: 0)
        }
        
    }
    
    func pinToTopLeft(of view : UIView, sidesPadding : CGFloat = 0, verticalPadding : CGFloat = 0, pinToSafeArea : Bool = false){
        view.addSubview(self)
        if pinToSafeArea{
            self.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: verticalPadding, paddingLeft: sidesPadding, paddingBottom: verticalPadding, paddingRight: sidesPadding, width: 0, height: 0)
        }else {
            self.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: verticalPadding, paddingLeft: sidesPadding, paddingBottom: verticalPadding, paddingRight: sidesPadding, width: 0, height: 0)
        }
    }
    
    func pinToTopRight(of view : UIView, sidesPadding : CGFloat = 0, verticalPadding : CGFloat = 0, pinToSafeArea : Bool = false){
        view.addSubview(self)
        if pinToSafeArea{
            self.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: verticalPadding, paddingLeft: sidesPadding, paddingBottom: verticalPadding, paddingRight: sidesPadding, width: 0, height: 0)
        }else {
            self.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: verticalPadding, paddingLeft: sidesPadding, paddingBottom: verticalPadding, paddingRight: sidesPadding, width: 0, height: 0)
        }
    }
    
    func appendAtEnd(of view : UIView, padding : CGFloat){
        if let lastSub = view.subviews.last{
            view.addSubview(self)
            self.anchor(top: lastSub.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, width: 0, height: 0)
        } else{
            self.pinToTopAndSides(of: view, sidesPadding : padding, verticalPadding : padding)
        }
    }
    
    func fill ( theView view : UIView){
        view.addSubview(self)
        self.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func fillWithInset ( theView view : UIView, withInsets insets : CGFloat){
        view.addSubview(self)
        self.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: insets, paddingLeft: insets, paddingBottom: insets, paddingRight: insets, width: 0, height: 0)
    }
    
    func fillWithInset ( theView view : UIView, withSidesInsets sides : CGFloat, withVerticalInsets vertical : CGFloat){
        view.addSubview(self)
        self.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: vertical, paddingLeft: sides, paddingBottom: vertical, paddingRight: sides, width: 0, height: 0)
    }
    
    func fillWithSidesInsets ( theView view : UIView, withInsets insets : CGFloat){
        view.addSubview(self)
        self.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: insets, paddingBottom: 0, paddingRight: insets, width: 0, height: 0)
    }
    
    func center ( inView view : UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func centerX ( inView view : UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerX ( inView view : UIView, constant : CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    
    func centerY ( inView view : UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func centerY ( inView view : UIView, constant : CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    
    func height(constant : CGFloat, priority : UILayoutPriority? = nil){
        self.translatesAutoresizingMaskIntoConstraints = false
        let const = self.heightAnchor.constraint(equalToConstant: constant)
        if let priority = priority{
            const.priority = priority
        }
        const.isActive = true
    }
    
    func height(equalTo dimension: NSLayoutDimension, multiplier : CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
    }
    
    func height (equalTo dimension : NSLayoutDimension, constant : CGFloat ){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: dimension, multiplier: 1.0, constant: constant).isActive = true
    }
    
    func height (equalTo dimension : NSLayoutDimension, multiplier: CGFloat, constant : CGFloat ){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: constant).isActive = true
    }
    
    func width(constant : CGFloat, priority : UILayoutPriority? = nil){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func width(equalTo dimension: NSLayoutDimension, multiplier : CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
    }
    
    func width (equalTo dimension : NSLayoutDimension, constant : CGFloat ){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: dimension, multiplier: 1.0, constant: constant).isActive = true
    }
    
    func width (equalTo dimension : NSLayoutDimension, multiplier: CGFloat, constant : CGFloat ){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: constant).isActive = true
    }
    
    ///Animate the view with a cool shake effect and adds a border color
    static func shake(view: UIView, for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            view.layer.borderColor = UIColor.googleRed().cgColor
            view.layer.borderWidth = 1
            view.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        propertyAnimator.addAnimations({
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            view.layer.borderWidth = 0
        }
        
        propertyAnimator.startAnimation()
    }
    
    func isHiddenAnimated(value: Bool, duration: Double = 0.2) {
        UIView.animate(withDuration: duration) { [weak self] in self?.isHidden = value }
    }
    
    static func insertOnView(view : UIView, withSidesPadding sidesPadding : CGFloat, withTopPadding topPadding : CGFloat) -> UIView{
        let superview = UIView()
        superview.addSubview(view)
        view.anchor(top: superview.topAnchor, left: superview.leftAnchor, bottom: superview.bottomAnchor, right: superview.rightAnchor, paddingTop: topPadding, paddingLeft: sidesPadding, paddingBottom: topPadding, paddingRight: sidesPadding, width: 0, height: 0)
        return superview
    }
    static func centerOnDummyView(_ view : UIView, width : CGFloat? = nil, height : CGFloat? = nil)-> UIView{
        let dummy = UIView()
        dummy.addSubview(view)
        view.centerXAnchor.constraint(equalTo: dummy.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: dummy.centerYAnchor).isActive = true
        if let width = width{
            dummy.width(constant: width)
        }
        if let height = height{
            dummy.height(constant: height)
        }
        return dummy
    }
    
    static func createSeparator () -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.88)
        return view
    }
    
    static func createEmptyView(ofHeight height : CGFloat) -> UIView{
        let view = UIView()
        view.backgroundColor = .clear
        view.height(constant: height)
        return view
    }
}
