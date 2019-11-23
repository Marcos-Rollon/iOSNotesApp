//
//  CreateNotesModelView.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class CreateNotesScreenViewModel{
    // MARK: - Properties
    private let notesManager : NotesManager
    private let userManager : UserManager
    
    private var selectedNoteType : NoteType = .personal // Default type
    private var selectedTitle : String?
    private var selectedContent : String?
    
    // MARK: - Init
    init(notesManager : NotesManager = NotesManager(), userManager : UserManager = UserManager()){
        self.userManager = userManager
        self.notesManager = notesManager
    }

    // MARK: - Public API
    public func didSelectNoteType(_ noteType : NoteType){
        self.selectedNoteType = noteType
    }
    public func didSelectTitle (_ title : String){
        self.selectedTitle = title
    }
    public func didSelectContent ( _ content : String){
        self.selectedContent = content
    }
    
    public func handleSaveButton(completion : ((_ success : Bool)-> Void)){
        // Check for correct note
        guard let title = self.selectedTitle, let content = self.selectedContent else{
            completion(false)
            return
        }
        if title.isEmpty || content.isEmpty{
            completion(false)
            return
        }
        // Create the new note and execute
        let note = Note(id: IDGenerator.generate(), title: title, content: content, type: self.selectedNoteType, date: Date())
        self.createNote(note: note, completion: completion)
    }
    
    // MARK: - Helpers
    
    private func createNote(note : Note, completion: (Bool)->Void){
        userManager.getCurrentUser { (user) in
            guard let user = user else {
                completion(false)
                return
            }
            notesManager.createNote(note: note, for: user.id, completion: completion)
        }
    }
}
