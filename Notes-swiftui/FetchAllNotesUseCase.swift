//
//  FetchAllNotesUseCase.swift
//  Notes-swiftui
//
//  Created by Carlos Morgado on 20/3/24.
//

import Foundation


struct FetchAllNotesUseCase {
    var notesDataBase: NotesDataBaseProtocol
    
    init(notesDataBase: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDataBase = notesDataBase
    }
    
    func fetchAll() throws -> [NoteModel] {
        try notesDataBase.fetchAll()
    }
}
