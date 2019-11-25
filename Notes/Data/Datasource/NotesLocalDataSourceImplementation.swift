//
//  NotesLocalDataSourceImplementation.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 20/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import RealmSwift

class NotesLocalDataSourceImplementation : NotesLocalDataSource{
    // Default realm instance
    private let realm = try! Realm()
    
    func getAllNotesForUser(_ userID: String, completion: ([Note]) -> Void) {
        let notesModels = findNotesByUserID(userID)
        let notes : [Note] = notesModels.map { (model) -> Note in
            return model.toNoteEntitie()
        }
        completion(notes)
    }
    
    func getNote(_ noteID: String, completion: (Note?) -> Void) {
        let predicate = NSPredicate(format: "id = %@", noteID)
        let notesModels = realm.objects(NotesModel.self).filter(predicate)
        completion(notesModels.first?.toNoteEntitie())
    }
    
    func createNote(_ note: Note, for userID: String, completion: (Bool) -> Void) {
        // Generate model
        let noteModel : NotesModel = NotesModel()
        noteModel.fromNoteEntitie(note, for: userID)
        // Write to database
        do{
            try realm.write {
                realm.add(noteModel)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    func editNote(noteID: String, newNote: Note, completion: (Bool) -> Void) {
        let notesModel = findNoteByID(noteID)
        // Check for only 1 note
        if let noteModel = notesModel.first, notesModel.count == 1{
            // Update fields, realm is updated in real time (which is pretty cool tbh)
            do{
                try realm.write {
                    noteModel.content = newNote.content
                    noteModel.title = newNote.title
                    let type : Int
                    switch newNote.type {
                        case .personal:
                            type = 0
                        case .work:
                            type = 1
                        case .other:
                            type = 2
                        case .finance:
                            type = 3
                    }
                    noteModel.type = type
                    // We do not update the date, this is a desing choice
                    completion(true)
                }
            } catch{
                completion(false)
            }
            
        }else {
            print("[NotesLocalDataSourceImpl] None or more than one note to edit")
            completion(false)
        }
    }
    
    func deleteNote(noteID: String, completion: (Bool) -> Void) {
        // Find note
        let notesModels = findNoteByID(noteID)
        
        // Should be just 1, but if there is more just delete all of then
        do{
            try realm.write {
                realm.delete(notesModels)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    // MARK: - Helpers
    private func findNoteByID( _ noteID : String)-> Results<NotesModel>{
        let predicate = NSPredicate(format: "id = %@", noteID)
        let notesModels = realm.objects(NotesModel.self).filter(predicate)
        return notesModels
    }
    
    private func findNotesByUserID( _ userID : String)-> Results<NotesModel>{
        let predicate = NSPredicate(format: "userID = %@", userID)
        let notesModels = realm.objects(NotesModel.self).filter(predicate)
        return notesModels
    }
}
