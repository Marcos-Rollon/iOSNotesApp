//
//  NotesService.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class NotesRepositoryImplementation : NotesRepository{
    
    private let dataSource : NotesLocalDataSource
    init (dataSource : NotesLocalDataSource = NotesLocalDataSourceImplementation()){
        self.dataSource = dataSource
    }
    
    func getAllNotesForUser(_ userID: String, completion: ([Note]) -> Void) {
        dataSource.getAllNotesForUser(userID, completion: completion)
    }
    
    func getNote(_ noteID: String, completion: (Note?) -> Void) {
        dataSource.getNote(noteID, completion: completion)
    }
    
    func createNote(_ note: Note, for userID: String, completion: (Bool) -> Void) {
        dataSource.createNote(note, for: userID, completion: completion)
    }
    
    func editNote(noteID: String, newNote: Note, completion: (Bool) -> Void) {
        dataSource.editNote(noteID: noteID, newNote: newNote, completion: completion)
    }
    
    func deleteNote(noteID: String, completion: (Bool) -> Void) {
        dataSource.deleteNote(noteID: noteID, completion: completion)
    }
}
