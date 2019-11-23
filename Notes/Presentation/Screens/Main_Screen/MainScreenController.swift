//
//  MainScreenController.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class MainScreenController : UIViewController{
    // MARK: - Views
    lazy var mainTableView = NotesTableView(headerTitle: "Home", backgroundImage: UIImage(), maxHeaderHeight: 140, minHeaderHeight: 70)
    
    // MARK: - Properties
    private let viewModel = MainScreenViewModel()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.getNotesForCurrenUser { [weak self] (notes) in
            self?.mainTableView.setNotes(notes)
        }
    }
    deinit {
        print("[MainScreenController] Deinit")
    }
    
    // MARK: - Helpers
    
    private func configureViews(){
        configureBackground()
        configureNavBar()
        
        self.add(mainTableView)
        mainTableView.delegate = self
        viewModel.getNotesForCurrenUser { [weak self] (notes) in
            self?.mainTableView.setNotes(notes)
        }
    }
    
    private func configureBackground(){
        self.view.backgroundColor = .white
    }
    
    private func configureNavBar(){
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.title = "Notes"
    }
    
    private func presentNoteDetailScreen(_ note : Note){
        let controller = NoteDetailScreen(note: note)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func presentCreateNoteScreen(){
        let controller = CreateNoteScreenController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Notes table view delegate
extension MainScreenController : NotesTableViewDelegate{
    func didSelectNote(note: Note) {
        self.presentNoteDetailScreen(note)
    }
    
    func didTapCreateNote() {
        self.presentCreateNoteScreen()
    }
    
    func didSwipeNote(at indexPath : IndexPath) {
        viewModel.deleteNote(note: viewModel.getNotes()[indexPath.row]) { (success) in
            if success{
                mainTableView.deleteNotes(at: indexPath)
            }
        }
    }
}
