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
}
