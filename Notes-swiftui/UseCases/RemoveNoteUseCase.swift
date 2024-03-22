//
//  DeleteNoteUseCase.swift
//  Notes-swiftui
//
//  Created by Carlos Morgado on 22/3/24.
//

import Foundation

protocol RemoveNoteProtocol {
    func removeNoteWith(identifier: UUID) throws
}

struct RemoveNoteUseCase: RemoveNoteProtocol {
    var notesDatabase: NotesDataBaseProtocol
    
    init(notesDatabase: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func removeNoteWith(identifier: UUID) throws {
        try notesDatabase.remove(identifier: identifier)
    }
}
