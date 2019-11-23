//
//  LoginTitleLabel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class LoginTitleLabel : UIView{
    //MARK: - Views
    private let bgView = UIImageView()
    private let titleLabel = NotesLabel(type: .title, text: "Notes", fontSize: 55, aligment: .center, maxLineNumber: 1, textColor: .white)
    private let notesIcon = UIImageView(image: .notesIcon)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureViews(){
        bgView.layer.borderWidth = 2
        bgView.layer.borderColor = UIColor.white.cgColor
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 30
        //bgView.contentMode = .scaleAspectFill
        //bgView.image = .chillOceanWallpaper
        bgView.addColorFilter(color: .rgb(red: 30, green: 30, blue: 30), opacity: 0.35)
        notesIcon.contentMode = .scaleAspectFit
        let hstack = HorizontalStackView()
        hstack.setPadding(topPadding: 10, sidesPadding: 12, bottomPadding: 10)
        hstack.setDistribution(.fill)
        hstack.setAlignment(aling: .center)
        hstack.add(views: [
            titleLabel, notesIcon
        ])
        hstack.fill(theView: bgView)
        hstack.height(constant: 120)
        
        bgView.fill(theView: self)
    }
}
