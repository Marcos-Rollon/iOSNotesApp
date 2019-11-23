//
//  NotesTableHeader.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 17/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NotesTableHeader: UIView {

    // MARK: - Views
    private var addButton : IconButton = IconButton(icon: .addButtonIcon, backgroundColor: .clear, diameter: 60)
    private var colorView : UIView = UIView()
    private var bgColor : UIColor = .mainTurquoise()
    private var titleLabel = NotesLabel(type: .title, fontSize: 28, aligment: .left, maxLineNumber: 1)
    private var bgImage : UIImageView = UIImageView()
    
    // MARK: - init
    init(title: String, backgroundImage : UIImage) {
        self.titleLabel.text = title
        bgImage.image = backgroundImage
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public api
    public var addButtonAction : (()->Void)? = nil
    
    // MARK: - Selectors
    @objc private func handleAddButton(){
        addButtonAction?()
    }
    
    // MARK: - helpers
    func setupViews() {
        // Config
        self.backgroundColor = UIColor.white
        colorView.backgroundColor = bgColor
        colorView.alpha = 0.6
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        // Layout
        bgImage.fill(theView: self)
        colorView.fill(theView: self)
        self.addSubview(titleLabel)
        titleLabel.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        self.addSubview(addButton)
        addButton.anchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 2, paddingRight: 10, width: 0, height: 0)

    }
    
    func decrementColorAlpha(_ offset: CGFloat) {
        if self.colorView.alpha <= 1 {
            let alphaOffset = (offset/500)/85
            self.colorView.alpha += alphaOffset
        }
    }
    func incrementColorAlpha(_ offset: CGFloat) {
        if self.colorView.alpha >= 0.6 {
            let alphaOffset = (offset/200)/85
            self.colorView.alpha -= alphaOffset
        }
    }

}
