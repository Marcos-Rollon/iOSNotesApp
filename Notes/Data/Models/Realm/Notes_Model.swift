//
//  Notes_Model.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 21/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import RealmSwift

class NotesModel : Object{
    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var type = 0
    @objc dynamic var date = Date()
    @objc dynamic var userID : String = ""
    
    // MARK: - Decoding/Encoding
    func fromNoteEntitie(_ n : Note, for userID : String){
        let type : Int
        switch n.type {
            case .personal:
                type = 0
            case .work:
                type = 1
            case .other:
                type = 2
            case .finance:
                type = 3
        }
        self.id = IDGenerator.generateFromParams([n.title])
        self.title = n.title
        self.content = n.content
        self.type = type
        self.date = n.date
        self.userID = userID
    }
    
    func toNoteEntitie() -> Note{
        let type : NoteType
        switch self.type {
            case 0:
                type = .personal
            case 1:
                type = .work
            case 2:
                type = .other
            case 3:
                type = .finance
            default:
                type = .other
        }
        
        let note = Note(id: self.id, title: self.title, content: self.content, type: type, date: self.date)
        return note
    }
}

