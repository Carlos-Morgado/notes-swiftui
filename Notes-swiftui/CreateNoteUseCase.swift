//
//  CreateNoteUseCase.swift
//  Notes-swiftui
//
//  Created by Carlos Morgado on 20/3/24.
//

import Foundation


struct CreateNoteUseCase {
    var notesDatabse: NotesDataBaseProtocol
    
    init(notesDatabse: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDatabse = notesDatabse
    }
    
    func createNoteWith(title: String, text: String) throws {
        let note: NoteModel = .init(identifier: .init(), title: title, text: text, createdAt: .now)
        try notesDatabse.insert(note: note )
    }
}
