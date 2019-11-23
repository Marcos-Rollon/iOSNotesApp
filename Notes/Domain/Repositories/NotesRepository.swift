//
//  NotesRepositoryProtocol.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

protocol NotesRepository {
    func getAllNotesForUser(_ userID: String, completion : (_ notes: [Note])->Void)
    func getNote(_ noteID : String, completion : (_ note : Note?)-> Void)
    func createNote(_ note : Note, for userID : String, completion : (_ success : Bool)-> Void)
    func editNote(noteID : String, newNote : Note, completion: (_ success : Bool) -> Void)
    func deleteNote(noteID: String, completion : (_ success : Bool) -> Void)
}
