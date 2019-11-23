//
//  NotesManager.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

struct NotesManager {
    private let repository : NotesRepository
    
    init(repository : NotesRepository = NotesRepositoryImplementation()){
        self.repository = repository
    }
    
    public func createNote(note : Note, for userID : String, completion : (Bool)->Void ){
        repository.createNote(note, for: userID, completion: completion)
    }
    public func editNote(noteID: String, newNote : Note, completion : (Bool)-> Void){
        repository.editNote(noteID: noteID, newNote: newNote, completion: completion)
    }
    public func deleteNote(noteID : String, completion : (Bool)-> Void){
        repository.deleteNote(noteID: noteID, completion: completion)
    }
    public func getAllNotes(for userID : String, completion : ([Note])-> Void){
        repository.getAllNotesForUser(userID, completion: completion)
    }
    public func getNote(noteID : String, completion : (Note?) -> Void){
        repository.getNote(noteID, completion: completion)
    }
}

