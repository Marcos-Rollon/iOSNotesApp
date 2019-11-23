//
//  NoteUserRoleSelectorView.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 23/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NoteUserRoleSelectorView : UIView{
    // MARK: - Views
    private let horizontalSelector = HorizontalPaginatedView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public API
    public var didChooseRole : ((UserRole)->Void)? = nil
    
    public func setSelectedType(_ type : UserRole){
        var indexOfType : Int = 0
        for (index, t) in UserRole.allCases.enumerated(){
            if t == type{
                indexOfType = index
            }
        }
        horizontalSelector.setCurrentPage(indexOfType)
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Config
        self.backgroundColor = .mainGreenWithAlpha(alpha: 0.3)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        populateImagesViews()
        horizontalSelector.currentPage = {
            [weak self] currentPage in
            self?.didChooseRole?(UserRole.allCases[currentPage])
        }
        // Layout
        horizontalSelector.fill(theView: self)
        
    }
    
    private func populateImagesViews(){
        for type in UserRole.allCases{
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = UIImage(named: type.assetName)
            iv.tintColor = .mainTurquoise()
            let topLabel = NotesLabel(type: .title, text: type.description, fontSize: 18, textColor: .mainTurquoise())
            let vstack = VerticalStackView()
            vstack.add(topLabel)
            vstack.add(iv)
            vstack.addCustomSpacing(of: 10, after: topLabel)
            horizontalSelector.addView(view: vstack)
        }
    }
}
