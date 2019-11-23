//
//  EditNoteScreenController.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class EditNoteScreenController : UIViewController{
    
    // MARK: - Views
    
    private let contentInput = NotesTextInput(placeholder: "Content")
    private let titleInput : NotesSingleLineInput = NotesSingleLineInput(placeholder: "Title", maxLenght: 35)
    private let noteTypeSelector : NoteTypeSelectorView = NoteTypeSelectorView()
    private let saveButton : NotesButton = NotesButton(text: "Save")
    
    // MARK: - Properties
    private let viewModel : EditNotesScreenViewModel
    private let note    : Note
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    init( note : Note){
        self.note = note
        self.viewModel = EditNotesScreenViewModel(note: note)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("[EditNoteScreen] Deinit")
    }
    // MARK: - Selectors
    @objc private func handleSaveButton(){
        viewModel.handleSaveButton { (success) in
            if !success{
                UIView.shake(view: self.saveButton)
                let alert = SimpleAlert.create(title: "Ups", content: "Something went wrong. Did you fill all the fields?")
                self.present(alert, animated: true)
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Config
        configureNavBar()
        self.view.backgroundColor = .white
        self.saveButton.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        noteTypeSelector.setSelectedType(note.type)
        noteTypeSelector.didChooseNoteType = {
            [weak self] type in
            self?.viewModel.didSelectNoteType(type)
        }
        titleInput.setText(note.title)
        titleInput.didChooseText = {
            [weak self] title in
            self?.viewModel.didSelectTitle(title)
        }
        contentInput.setText(note.content)
        contentInput.didChooseText = {
            [weak self] content in
            self?.viewModel.didSelectContent(content)
        }
        // Layout
        let vstack = VerticalStackView()
        vstack.setSpacing(spacing: 12)
        vstack.addSpacing(ofHeight: 10)
        vstack.add(titleInput)
        vstack.add(noteTypeSelector)
        vstack.add(contentInput)
        vstack.add(saveButton)
        vstack.addCustomSpacing(of: 20, after: saveButton)
        
        vstack.fillWithInset(theView: self.view, withSidesInsets: 12, withVerticalInsets: 8)
    }
    
    private func configureNavBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Edit Note"
    }
}
