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
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllNotesUseCase: FetchAllNotesProtocol
    var updateNoteUseCase: UpdateNoteProtocol
    var removeNoteUseCase: RemoveNoteProtocol
    
    init(notes: [NoteModel] = [],
             createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
             fetchAllNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
             updateNoteUseCase: UpdateNoteProtocol = UpdateNoteUseCase(),
             removeNoteUseCase: RemoveNoteProtocol = RemoveNoteUseCase()) {
            self.notes = notes
            self.createNoteUseCase = createNoteUseCase
            self.fetchAllNotesUseCase = fetchAllNotesUseCase
            self.updateNoteUseCase = updateNoteUseCase
            self.removeNoteUseCase = removeNoteUseCase
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
        do {
            try updateNoteUseCase.updateNoteWith(identifier: identifier, title: newTitle, text: newText)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
        
    func removeNoteWith(identifier: UUID) {
        do {
            try removeNoteUseCase.removeNoteWith(identifier: identifier)
            fetchAllNotes()
        } catch let error as DataBaseError {
            print("Error \(error.localizedDescription)")
            databaseError = error
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
}
