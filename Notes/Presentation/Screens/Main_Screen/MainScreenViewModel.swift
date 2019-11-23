//
//  MainScreenViewModel.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation

class MainScreenViewModel {
    // MARK: - Properties
    private let notesManager : NotesManager
    private let userManager     : UserManager
    
    private var notes : [Note] = [Note]()
    
    // TODO: For prod, a service locator is a better way to do this
    init( notesManager : NotesManager = NotesManager(), userManager : UserManager = UserManager()){
        self.notesManager = notesManager
        self.userManager = userManager
    }
    
    public func getNotesForCurrenUser(completion : ([Note])->Void){
        userManager.getCurrentUser { (user) in
            guard let user = user else {
                print("Can't get current user")
                completion([])
                return
            }
            self.notesManager.getAllNotes(for: user.id) { (notes) in
                let n = notes.sorted { (prev, next) -> Bool in
                    return prev.date > next.date
                }
                self.notes = n
                completion(n)
            }
        }
    }
    
    public func deleteNote(note : Note, completion : ((Bool)->Void)){
        notesManager.deleteNote(noteID: note.id, completion: completion)
    }
    
    public func getNotes() -> [Note]{
        return self.notes
    }
}
