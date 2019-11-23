//
//  NotesLabel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NotesLabel : UILabel{
    //MARK: - Properties
       
   private var _text           : String            = ""
   private var _fontSize       : CGFloat           = 16
   private var _textAligment   : NSTextAlignment   = .center
   private var _maxLineNumber  : Int               = 2
    private var _textColor      : UIColor           = .white
   //MARK: - Init
   required init(coder aDecoder: NSCoder) {
       fatalError("Not implemented")
   }
   override init(frame: CGRect) {
       super.init(frame: frame)
   }
    
    init(type : NotesLabel.LabelType, text : String? = nil, fontSize : CGFloat? = nil, aligment : NSTextAlignment? = nil, maxLineNumber : Int? = nil, textColor : UIColor = .white) {
        
        self.init()
        self._textColor = textColor
        if let text = text{
            self._text = text
        }
        if let fontSize = fontSize {
            self._fontSize = fontSize
        } else {
            if type == .title{
                self._fontSize = 28
            }
        }
        if let aligment = aligment{
            self._textAligment = aligment
        }
        if let maxLineNumber = maxLineNumber{
            self._maxLineNumber = maxLineNumber
        }
        
        switch type {
            case .subtitle:
                configureSubtitleLabel()
            case .title:
                configureTitleLabel()
        }
        
    }
    
    private func configureSubtitleLabel(){
        self.textColor = _textColor
        self.font = UIFont.systemFont(ofSize: _fontSize)
        self.text = _text
        self.textAlignment = _textAligment
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.3
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = _maxLineNumber
    }
    
    private func configureTitleLabel(){
        self.textColor = _textColor
        self.font = UIFont.boldSystemFont(ofSize: _fontSize)
        self.text = _text
        self.textAlignment = _textAligment
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.2
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = _maxLineNumber
    }
    
    enum LabelType{
        case title
        case subtitle
    }

}

