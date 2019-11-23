//
//  NoteCell.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit


class NoteCell : UITableViewCell{
    
    // Reuse identifier
    static let reuseIdentifier = "NoteCell"
    
    // MARK: - Views
    private lazy var content        = UIView()
    private lazy var titleLabel     = NotesLabel(type: .title, aligment: .left, maxLineNumber: 1)
    private lazy var subtitleLabel  = NotesLabel(type: .subtitle, aligment: .left, maxLineNumber: 1, textColor:  UIColor.secondaryLabel)
    private lazy var noteTypeImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.width(constant: 60)
        return iv
    }()
    
    // MARK: - Properties
    private var type        : NoteType = .finance
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("Ups, not implemented")
    }
    
    // MARK: - Public API
    public func configure(_ note : Note){
        titleLabel.text = note.title
        subtitleLabel.text = FormatDisplay.dateNoHours(note.date)
        noteTypeImage.image = UIImage.init(named: note.type.assetName)
        self.type   = note.type
        
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Config
        configureBackground()
        
        
        // Layout
        let hstack = HorizontalStackView()
        hstack.setSpacing(spacing: 12)
        hstack.add(noteTypeImage)
        hstack.add(
            VerticalStackView(withViews: [
                titleLabel, subtitleLabel
            ], distribution: .fillEqually, aligment: .fill, spacing: 8, padding: 0)
        )
        hstack.height(constant: 90)
        hstack.fillWithSidesInsets(theView: content, withInsets: 12)
    }
    
    private func configureBackground(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
        content.clipsToBounds = true
        content.layer.cornerRadius = 10
        content.backgroundColor = .mainGreen()
        content.fillWithInset(theView: self, withSidesInsets: 12, withVerticalInsets: 8)
    }
    
}
