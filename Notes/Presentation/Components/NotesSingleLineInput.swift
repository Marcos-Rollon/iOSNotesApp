//
//  NotesSingleLineInput.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NotesSingleLineInput : UITextField, UITextFieldDelegate{
    // MARK: - Properties
    
    private let insetX: CGFloat = 16
    private let insetY: CGFloat = 0
    private let maxLenght : Int
    
    // MARK: - Init
    init(placeholder : String, maxLenght : Int = 15, textColor : UIColor = .white , backgroundColor : UIColor = .mainGreen(), borderColor : UIColor = .clear, borderWidth : CGFloat = 2,  height : CGFloat = 60) {
        self.maxLenght = maxLenght
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.textColor = textColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.backgroundColor = backgroundColor
        self.height(constant: height)
        self.layer.cornerRadius = height / 2
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.delegate = self
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {return}
        didChooseText?(text)
    }
    // MARK: - Public api
    public var didChooseText : ((String)->Void)? = nil

    public func setText(_ text : String){
        self.text = text
    }
    // MARK: - Helpers
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // Max lenght
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= maxLenght
    }
    
}
