//
//  NoteDetailsHeaderView.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NoteDetailsHeaderView : UIView{
    // MARK: - Views
    private let titleLabel = NotesLabel(type: .title, textColor: .black)
    private let dateLabel = NotesLabel(type: .subtitle, textColor: UIColor.secondaryLabel)
    private let typeImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - Properties
    private let title   : String
    private let date    : String
    private let typeImage : UIImage
    
    // MARK: - Init
    init(title : String, date : String, typeImage : UIImage){
        self.title = title
        self.date = date
        self.typeImage = typeImage
        super.init(frame: .zero)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureViews(){
        // Config
        titleLabel.text = title
        dateLabel.text = date
        typeImageView.image = typeImage
        
        // Layout
        let hstack = HorizontalStackView()
        hstack.setDistribution(.equalCentering)
        hstack.setPadding(topPadding: 8, sidesPadding: 8, bottomPadding: 8)
        hstack.add(
            VerticalStackView(withViews: [
                titleLabel, dateLabel
            ], distribution: .fill, aligment: .fill, spacing: 8, padding: 0)
        )
        hstack.add(typeImageView)
        hstack.fill(theView: self)
    }
}
