//
//  NoteDetailsScreen.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NoteDetailScreen : UIViewController{
    // MARK: - Views
    private var header : NoteDetailsHeaderView!
    private let deleteButton = NotesButton(text: "Remove", textColor: .googleRed(), bgColor: .clear, borderColor: .googleRed())
    private let editButton = NotesButton(text: "Edit")
    private let contentView : UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = false
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }()
    
    // MARK: - Properties
    private let note : Note
    private let viewModel : NoteDetailsViewModel = NoteDetailsViewModel()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    init (note : Note){
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("[NoteDetailsScreen] Deinit")
    }
    
    // MARK: - Selectors
    @objc private func handleEditButton(){
        let controller = EditNoteScreenController(note: self.note)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc private func handleDeleteButton(){
        let alert = UIAlertController(title: "Notes", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.viewModel.removeNote(note: self.note) { (succ) in
                if !succ {
                    self.present(SimpleAlert.create(title: "Notes", content: "Something went wrong!"), animated: true) {
                    }
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Config
        self.configureNavBar()
        self.view.backgroundColor = .white
        self.header = NoteDetailsHeaderView(title: note.title, date: FormatDisplay.dateNoHours(note.date), typeImage: UIImage(named: note.type.assetName)!)
        self.contentView.text = note.content
        self.editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(handleDeleteButton), for: .touchUpInside)
        
        // Layout
        let vstack = VerticalStackView()
        vstack.setSpacing(spacing: 12)
        vstack.add(header)
        header.height(constant: 120)
        vstack.add(contentView)
        vstack.add(editButton)
        vstack.add(deleteButton)
        vstack.fillWithInset(theView: self.view, withSidesInsets: 4, withVerticalInsets: 8)
    }
    
    private func configureNavBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Notes"
    }
}
