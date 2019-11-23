//
//  NoteDetailsViewModel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 19/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NoteDetailsViewModel{
    private let notesManager : NotesManager
    
    init(notesManager : NotesManager = NotesManager()){
        self.notesManager = notesManager
    }
    
    public func removeNote(note : Note, completion : (Bool)-> Void){
        notesManager.deleteNote(noteID: note.id, completion: completion)
    }
}
