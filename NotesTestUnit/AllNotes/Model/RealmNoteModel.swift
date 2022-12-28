//
//  RealmNoteModel.swift
//  NotesTestUnit
//
//  Created by Mac on 24.12.2022.
//

import UIKit
import RealmSwift

final class RealmNote: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var noteTitle: String = ""
    @Persisted var noteDesription: String = ""
    
    convenience init(title: String, description: String) {
        self.init()
        self.noteTitle = title
        self.noteDesription = description
    }
}
