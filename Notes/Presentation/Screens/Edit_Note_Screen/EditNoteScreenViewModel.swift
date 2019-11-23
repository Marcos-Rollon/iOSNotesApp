//
//  EditNoteViewModel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class EditNotesScreenViewModel{
    // MARK: - Properties
    private let notesManager    : NotesManager
    private let userManager     : UserManager
    
    private var selectedNoteType : NoteType
    private var selectedTitle : String?
    private var selectedContent : String?
    private let initialNote : Note
    private var somethingHasChanged : Bool = false
    
    // MARK: - Init
    init(note : Note, notesManager : NotesManager = NotesManager(), userManager : UserManager = UserManager()){
        self.initialNote = note
        self.notesManager = notesManager
        self.userManager = userManager
        selectedTitle = note.title
        selectedContent = note.content
        selectedNoteType = note.type
    }

    // MARK: - Public API
    public func didSelectNoteType(_ noteType : NoteType){
        somethingHasChanged = true
        self.selectedNoteType = noteType
    }
    public func didSelectTitle (_ title : String){
        somethingHasChanged = true
        self.selectedTitle = title
    }
    public func didSelectContent ( _ content : String){
        somethingHasChanged = true
        self.selectedContent = content
    }
    
    public func handleSaveButton(completion : ((_ success : Bool)-> Void)){
        // If nothing has changed, just save some resources and return a success
        if !somethingHasChanged{
            completion(true)
        }
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
        let newNote = Note(id: IDGenerator.generate(), title: title, content: content, type: self.selectedNoteType, date: Date())
        self.notesManager.editNote(noteID: initialNote.id, newNote: newNote, completion: completion)
    }
    
    
}
