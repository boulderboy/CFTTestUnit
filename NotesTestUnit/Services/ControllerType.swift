//
//  ControllerType.swift
//  NotesTestUnit
//
//  Created by Mac on 28.12.2022.
//

import Foundation

enum ControllerType {
    case note
    case newNote
    case editting(note: Note, storageService: StorageService, onDismiss: ((Note) -> ())?)

}
