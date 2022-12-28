//
//  NotesServices.swift
//  NotesTestUnit
//
//  Created by Mac on 24.12.2022.
//

import Foundation
import RealmSwift

protocol NotesServices {
    func getAllNotes() -> [Note]
}

final class NotesServicesImpl: NotesServices {
    
    private let realmServices: StorageServiceProtocol
    
    init(realmServices: StorageServiceProtocol) {
        self.realmServices = realmServices
    }
    
    func getAllNotes() -> [Note] {
        realmServices.getAllNotes()
    }
    
}
