//
//  NotesTextInput.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NotesTextInput : UITextView{
    
    // MARK: - Views
    private let placeholderLabel = NotesLabel(type: .subtitle, fontSize: 22, maxLineNumber: 1, textColor: .lightGray)
    
    // MARK: - Public API
    public var didChooseText : ((String)->Void)? = nil
    
    public func setText(_ text : String){
        self.text = text
        self.placeholderLabel.isHidden = !self.text.isEmpty
    }
    // MARK: - Init
    init(placeholder : String, fontSize: CGFloat = 22, isUserInteractionEnabled : Bool = true, textColor : UIColor = .white, bgColor : UIColor = .mainGreen(), height : CGFloat? = nil){
        super.init(frame: .zero, textContainer: nil)
        self.delegate = self
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textContainer.lineBreakMode = .byWordWrapping
        self.placeholderLabel.text = placeholder
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.textColor = textColor
        self.backgroundColor = bgColor
        self.clipsToBounds = true
        self.addSubview(placeholderLabel)
        placeholderLabel.isHidden = !self.text.isEmpty
        placeholderLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        if let height = height{
            self.height(constant: height)
            self.layer.cornerRadius = height / 2
        }else {
            self.layer.cornerRadius = 10
            self.clipsToBounds = true
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NotesTextInput : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        didChooseText?(textView.text)
    }
}
