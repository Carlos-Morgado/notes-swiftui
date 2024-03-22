//
//  FetchAllNotesUseCase.swift
//  Notes-swiftui
//
//  Created by Carlos Morgado on 20/3/24.
//

import Foundation

protocol FetchAllNotesProtocol {
    func fetchAll() throws -> [NoteModel]
}

struct FetchAllNotesUseCase: FetchAllNotesProtocol {
    var notesDatabase: NotesDataBaseProtocol
    
    init(notesDatabase: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func fetchAll() throws -> [NoteModel] {
        try notesDatabase.fetchAll()
    }
}
