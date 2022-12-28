//
//  Navigation.swift
//  NotesTestUnit
//
//  Created by Mac on 28.12.2022.
//

import UIKit

protocol Navigation: AnyObject {
    func openNewNoteController()
    func openEditingViewController(note: Note, storageService: StorageService, onDismiss: ((Note) -> ())?)
    var navigationController: UINavigationController? { get set }
}

final class Navigator: Navigation {

    weak var navigationController: UINavigationController?
    private let factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
    }
    
    func openNewNoteController() {
        let controller = factory.createController(type: .newNote)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func openEditingViewController(note: Note, storageService: StorageService, onDismiss: ((Note) -> ())?) {
        let controller = factory.createController(type: .editting(note: note, storageService: storageService, onDismiss: onDismiss))
        let newNavigationController = UINavigationController(rootViewController: controller)
        navigationController?.present(newNavigationController, animated: true)
                                                  
    }
    
    
}


