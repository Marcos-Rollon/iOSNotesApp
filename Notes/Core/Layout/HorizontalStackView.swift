//
//  HorizontalStackView.swift
//
//  Created by Marcos Rollón Rivas on 15/5/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import UIKit

class HorizontalStackView : UIView {
    
    private var stackView       : UIStackView!
    
    private let topPadding      : CGFloat = 0
    private let sidesPadding    : CGFloat = 0
    private let bottomPadding   : CGFloat = 0
    private let elementSpacing  : CGFloat = 0
    
    //MARK: - Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    public convenience init (withViews views : [UIView], distribution : UIStackView.Distribution? = nil, spacing : CGFloat? = nil, padding : CGFloat? = nil){
        self.init(frame: .zero)
        configureStackView()
        add(views: views)
        if let dist = distribution{
            stackView.distribution = dist
        }
        if let spa = spacing {
            stackView.spacing = spa
        }
        if let pad = padding{
            setPadding(topPadding: pad, sidesPadding: pad, bottomPadding: pad)
        }

    }
    
    //MARK: - Public API
    
    public func add(_ view : UIView){
        self.stackView.addArrangedSubview(view)
    }
    public func add(views : [UIView]){
        self.stackView.addArrangedSubviews(views)
    }
    public func addSpacing(ofWidth width : CGFloat){
        let view = UIView()
        view.backgroundColor = .clear
        view.width(constant: width)
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
    
    public func setSpacing ( spacing : CGFloat){
        self.stackView.spacing = spacing
    }
    
    public func setPadding (topPadding : CGFloat, sidesPadding : CGFloat, bottomPadding : CGFloat){
        stackView.layoutMargins = UIEdgeInsets(top: topPadding, left: sidesPadding, bottom: bottomPadding, right: sidesPadding)
    }
    
    public func setAlignment( aling : UIStackView.Alignment){
        stackView.alignment = aling
    }
    
    public func addCustomSpacing(of spacing : CGFloat, after view : UIView){
        stackView.setCustomSpacing(spacing, after: view)
    }
    
    private func configureStackView(){
        
        stackView = UIStackView()
        stackView.axis = .horizontal
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
