//
//  ViewModel.swift
//  Notes-swiftui
//
//  Created by Carlos Morgado on 19/3/24.
//

import Foundation
import Observation

@Observable
class ViewModel {
    var notes: [NoteModel]
    
    var createNoteUseCase: CreateNoteUseCase
    var fetchAllNotesUseCase: FetchAllNotesUseCase
    
    init(notes: [NoteModel] = [], 
         createNoteUseCase: CreateNoteUseCase = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesUseCase = FetchAllNotesUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        fetchAllNotes()
    }
    
    func createNoteWith(title: String, text: String) {
        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes()
        } catch {
            print("Error \(error.localizedDescription)")
            
        }
    }
    
    func fetchAllNotes() {
        do {
            notes = try fetchAllNotesUseCase.fetchAll()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func updateNoteWith(identifier: UUID, newTitle: String, newText: String?) {
        if let index = notes.firstIndex(where: { $0.identifier == identifier }) {
            let updateNote = NoteModel(identifier: identifier, title: newTitle, text: newText, createdAt: notes[index].createdAt)
            notes[index] = updateNote
        }
    }

    func removeNoteWith(identifier: UUID) {
        notes.removeAll(where: { $0.identifier == identifier })
    }
}
