//
//  NotesDataBase.swift
//  Notes-swiftui
//
//  Created by Carlos Morgado on 20/3/24.
//

import Foundation
import SwiftData

enum DataBaseError: Error {
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorRemove
}

protocol NotesDataBaseProtocol {
    func insert(note: NoteModel) throws
    func fetchAll() throws -> [NoteModel]
    func update(identifier: UUID, title: String, text: String?) throws
    func remove(identifier: UUID) throws
}

class NotesDataBase: NotesDataBaseProtocol {
    static let shared: NotesDataBase = NotesDataBase()
    
    @MainActor
    
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init() {}
    
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: NoteModel.self,
                                               configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            print("Error \(error.localizedDescription)")
            fatalError() 
        }
    }
    
    @MainActor
    func insert(note: NoteModel) throws {
        container.mainContext.insert(note)
        
        do {
            try container.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw DataBaseError.errorInsert
        }
    }
    
    @MainActor
    func fetchAll() throws -> [NoteModel] {
        let fetchDescriptor = FetchDescriptor<NoteModel>(sortBy: [SortDescriptor<NoteModel>(\.createdAt)])
        
        do {
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Error \(error.localizedDescription)")
            throw DataBaseError.errorFetch
        }
    }
    
    @MainActor
        func update(identifier: UUID, title: String, text: String?) throws {
            let notePredicate = #Predicate<NoteModel> {
                $0.identifier == identifier
            }
            
            var fetchDescriptor = FetchDescriptor<NoteModel>(predicate: notePredicate)
            fetchDescriptor.fetchLimit = 1
            
            do {
                guard let updateNote = try container.mainContext.fetch(fetchDescriptor).first else {
                    throw DataBaseError.errorUpdate
                }
                
                updateNote.title = title
                updateNote.text = text
                
                try container.mainContext.save()
            } catch {
                print("Error actualizando información")
                throw DataBaseError.errorUpdate
            }
        }
    
    @MainActor
        func remove(identifier: UUID) throws {
            let notePredicate = #Predicate<NoteModel> {
                $0.identifier == identifier
            }
            
            var fetchDescriptor = FetchDescriptor<NoteModel>(predicate: notePredicate)
            fetchDescriptor.fetchLimit = 1
            
            do {
                guard let deleteNote = try container.mainContext.fetch(fetchDescriptor).first else {
                    throw DataBaseError.errorRemove
                }
                
                container.mainContext.delete(deleteNote)
                try container.mainContext.save()
            } catch {
                print("Error actualizando información")
                throw DataBaseError.errorRemove
            }
        }
}
