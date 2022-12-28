//
//  Note.swift
//  NotesTestUnit
//
//  Created by Mac on 24.12.2022.
//

import Foundation

final class Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs._id == rhs._id
    }
    
    var _id: String?
    var noteTitle: String = ""
    var noteDesription: String = ""
    
    init(id: String?, title: String, description: String) {
        self._id = id
        self.noteTitle = title
        self.noteDesription = description
    }
}

extension Note {
    static let greetingsNote = Note(id: "", title: "Hello new customer", description: "This is test note app")
}
