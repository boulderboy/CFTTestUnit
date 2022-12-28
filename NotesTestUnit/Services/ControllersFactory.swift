//
//  Collector.swift
//  NotesTestUnit
//
//  Created by Mac on 28.12.2022.
//

import UIKit

protocol Factory {
    func createController(type: ControllerType) -> UIViewController
}

final class ControllersFactory: Factory {
    
    private let storageService: StorageService
    
    init(storageService: StorageService) {
        self.storageService = storageService
    }
    
    func createController(type: ControllerType) -> UIViewController {
        switch type {
        case .editting(let note, let storageService, let onDismiss):
            return EditingViewController(note: note, storageService: storageService, onDismiss: onDismiss)
        case .newNote:
            return NewNoteViewController()
        case .note:
            let navigartor = Navigator(factory: self)
            return NoteViewController(storageService: storageService, navigator: navigartor)
        }
    }
}
