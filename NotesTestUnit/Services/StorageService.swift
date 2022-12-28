//
//  RealmService.swift
//  NotesTestUnit
//
//  Created by Mac on 24.12.2022.
//

import UIKit
import RealmSwift

protocol StorageServiceProtocol {
    func save(note: Note)
    func getAllNotes() -> [Note]
    func delete(object: Note) -> Void
    func update(object: Note, title: String, description: String) -> Void
}

final class StorageService: StorageServiceProtocol {
    let realm = try! Realm()
    
    func save(note: Note) {
        let realmNote = RealmNote(title: note.noteTitle, description: note.noteDesription)
        try! realm.write {
            realm.add(realmNote)
        }
    }
   
    func delete(object: Note) {
        let realmNote = realm.objects(RealmNote.self).where {
            var objId = try! ObjectId(string: object._id!)
            return $0._id == objId
        }
        try! realm.write {
            realm.delete(realmNote)
        }
    }
    
    func getAllNotes() -> [Note] {
        Array(realm.objects(RealmNote.self).map {
            Note(id: $0._id.stringValue, title: $0.noteTitle, description: $0.noteDesription)
        })
    }

    
    func update(object: Note, title: String, description: String) {
        let realmNote = realm.objects(RealmNote.self).where {
            let objId = try! ObjectId(string: object._id!)
            return $0._id == objId
        }
        try! realm.write {
            realmNote.first?.noteTitle = title
            realmNote.first?.noteDesription = description
        }
    }
    
    private func getNoteById(id: String) -> Note {
        guard let realmNote = realm.objects(RealmNote.self).where({
            let objId = try! ObjectId(string: id)
            return $0._id == objId
        }).first else { return Note(id: "", title: "", description: "")}
        return Note(id: realmNote._id.stringValue, title: realmNote.noteTitle, description: realmNote.noteDesription)
    }
    
}




