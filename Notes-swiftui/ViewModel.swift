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
    
    init(notes: [NoteModel] = []) {
        self.notes = notes
    }
    
    func createNoteWith(title: String, text: String) {
        let note: NoteModel = .init(title: title, text: text, createdAt: .now)
        notes.append(note)
    }
    
    func updateNoteWith(id: UUID, newTitle: String, newText: String?) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            let updateNote = NoteModel(id: id, title: newTitle, text: newText, createdAt: notes[index].createdAt)
            notes[index] = updateNote
        }
    }
    
    func removeNoteWith(id: UUID) {
        notes.removeAll(where: { $0.id == id })
    }
}
