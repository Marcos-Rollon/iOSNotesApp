//
//  VerticalStackView.swift
//
//  Created by Marcos Rollón Rivas on 17/5/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import UIKit

class VerticalStackView : UIView {
    
    private var stackView       : UIStackView!
    
    private var topPadding      : CGFloat = 0
    private var sidesPadding    : CGFloat = 0
    private var bottomPadding   : CGFloat = 0
    private var elementSpacing  : CGFloat = 0
    
    //MARK: - Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    public convenience init (withViews views : [UIView]){
        self.init(frame: .zero)
        configureStackView()
        add(views: views)
    }
    
    public convenience init (withViews views : [UIView], distribution : UIStackView.Distribution){
        self.init(frame: .zero)
        configureStackView()
        add(views: views)
        self.setDistribution(distribution)
    }
    
    public convenience init ( withViews views : [UIView], distribution : UIStackView.Distribution? = nil, aligment : UIStackView.Alignment? = nil, spacing : CGFloat? = nil, padding : CGFloat? = nil){
        self.init(frame: .zero)
        configureStackView()
        add(views: views)
        if let dist = distribution{
            self.setDistribution(dist)
        }
        if let alig = aligment{
            self.setAlignment(aling: alig)
        }
        if let spacing = spacing{
            self.setSpacing(spacing: spacing)
        }
        if let pad = padding{
            self.setPadding(topPadding: pad, sidesPadding: pad, bottomPadding: pad)
        }
    }
    
    //MARK: - public API
    
    public func add(_ view : UIView){
        self.stackView.addArrangedSubview(view)
    }
    
    public func add(views : [UIView]){
        self.stackView.addArrangedSubviews(views)
    }
    
    public func addSpacing(ofHeight height : CGFloat){
        let view = UIView()
        view.backgroundColor = .clear
        view.height(constant: height)
        self.stackView.addArrangedSubview(view)
    }
    
    public func remove(_ view : UIView){
        self.stackView.removeArrangedSubview(view)
    }
    
    public func removeArrangedSubviews (){
        self.stackView.removeArrangedSubviews()
    }
    
    public func setDistribution (_ distribution : UIStackView.Distribution) {
        self.stackView.distribution = distribution
    }
    
    public func setPadding ( topPadding : CGFloat, sidesPadding : CGFloat, bottomPadding : CGFloat){
        self.topPadding         = topPadding
        self.sidesPadding       = sidesPadding
        self.bottomPadding      = bottomPadding
        stackView.layoutMargins = UIEdgeInsets(top: topPadding, left: sidesPadding, bottom: bottomPadding , right: sidesPadding)
        
    }
    
    public func setSpacing ( spacing : CGFloat){
        self.stackView.spacing = spacing
    }
    
    public func setAlignment( aling : UIStackView.Alignment){
        stackView.alignment = aling
    }
    public func addCustomSpacing(of spacing : CGFloat, after view : UIView){
        stackView.setCustomSpacing(spacing, after: view)
    }
    
    private func configureStackView(){
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = elementSpacing
        stackView.distribution = .fill
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.layoutMargins = UIEdgeInsets(top: topPadding, left: sidesPadding, bottom: bottomPadding , right: sidesPadding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Satisfying size constraints
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
            ])
        
    }
}
