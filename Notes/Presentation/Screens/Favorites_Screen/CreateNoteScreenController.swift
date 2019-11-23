//
//  CreateNoteScreenController.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class CreateNoteScreenController : UIViewController{
    
    // MARK: - Views
    
    private let contentInput = NotesTextInput(placeholder: "Content")
    private let titleInput : NotesSingleLineInput = NotesSingleLineInput(placeholder: "Title", maxLenght: 35)
    private let noteTypeInfoLabel = NotesLabel(type: .subtitle, text: "Pick some icon that will help you have things organized (or the coolest one)", fontSize: 16, aligment: .justified, maxLineNumber: 0, textColor: .lightGray)
    private let noteTypeSelector : NoteTypeSelectorView = NoteTypeSelectorView()
    private let saveButton : NotesButton = NotesButton(text: "Save")
    
    // MARK: - Properties
    private let viewModel = CreateNotesScreenViewModel()
    //private let note    : Note?
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    deinit {
        print("[CreateNoteScreen] Deinit")
    }
    // MARK: - Selectors
    @objc private func handleSaveButton(){
        viewModel.handleSaveButton { (success) in
            if !success{
                UIView.shake(view: self.saveButton)
                let alert = SimpleAlert.create(title: "Ups", content: "Something went wrong. Did you fill all the fields?")
                self.present(alert, animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Config
        configureNavBar()
        self.view.backgroundColor = .white
        self.saveButton.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        noteTypeSelector.didChooseNoteType = {
            [weak self] type in
            self?.viewModel.didSelectNoteType(type)
        }
        titleInput.didChooseText = {
            [weak self] title in
            self?.viewModel.didSelectTitle(title)
        }
        contentInput.didChooseText = {
            [weak self] content in
            self?.viewModel.didSelectContent(content)
        }
        // Layout
        let vstack = VerticalStackView()
        vstack.setSpacing(spacing: 12)
        vstack.addSpacing(ofHeight: 10)
        vstack.add(titleInput)
        vstack.add(
            HorizontalStackView(withViews: [
                noteTypeInfoLabel, noteTypeSelector
            ], distribution: .fill, spacing: 8, padding: 0)
        )
        vstack.add(contentInput)
        vstack.add(saveButton)
        vstack.addCustomSpacing(of: 20, after: saveButton)
        
        
        vstack.fillWithInset(theView: self.view, withSidesInsets: 12, withVerticalInsets: 8)
    }
    
    private func configureNavBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Create Note"
    }
}
