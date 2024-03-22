//
//  ViewModelIntegrationTests.swift
//  NotesTests
//
//  Created by Carlos Morgado on 20/3/24.
//

import XCTest
@testable import Notes_swiftui

@MainActor
final class ViewModelIntegrationTests: XCTestCase {
    var sut: ViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let database = NotesDataBase.shared
        database.container = NotesDataBase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabse: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDataBase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase, fetchAllNotesUseCase: fetchAllNotesUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateNote() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "Text 1")
        
        // When
        let note = sut.notes.first
        
        // Then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "Hello 1")
        XCTAssertEqual(note?.text, "Text 1")
        XCTAssertEqual(sut.notes.count, 1)
         
    }
    
    func testCreateTwoNotes() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "Text 1")
        sut.createNoteWith(title: "Hello 2", text: "Text 2")

        // When
        let firstNote = sut.notes.first
        let lastNote = sut.notes.last
        
        // Then
        XCTAssertNotNil(firstNote)
        XCTAssertEqual(firstNote?.title, "Hello 1")
        XCTAssertEqual(firstNote?.text, "Text 1")
        XCTAssertNotNil(lastNote)
        XCTAssertEqual(lastNote?.title, "Hello 2")
        XCTAssertEqual(lastNote?.text, "Text 2")
        
        XCTAssertEqual(sut.notes.count, 2, "Debería haber 2 notas en la base de datos")
         
    }
    
    func testFetchAllNotes() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "Text 1")
        sut.createNoteWith(title: "Hello 2", text: "Text 2")
        
        // When
        let firstNote = sut.notes[0]
        let secondNote = sut.notes[1]
        
        // Then
        XCTAssertEqual(sut.notes.count, 2, "There should be 2 notes in the database")
        XCTAssertEqual(firstNote.title, "Hello 1")
        XCTAssertEqual(firstNote.text, "Text 1")
        XCTAssertEqual(secondNote.title, "Hello 2")
        XCTAssertEqual(secondNote.text, "Text 2")
    }
    
    func testUpdateNote() {
            sut.createNoteWith(title: "Note 1", text: "text 1")
            
            guard let note = sut.notes.first else {
                XCTFail()
                return
            }
            
            sut.updateNoteWith(identifier: note.identifier, newTitle: "SwiftBeta", newText: "New Text")
            sut.fetchAllNotes()
            
            XCTAssertEqual(sut.notes.count, 1, "Debería haber 1 nota en la base de datos")
            XCTAssertEqual(sut.notes[0].title, "SwiftBeta")
            XCTAssertEqual(sut.notes[0].text, "New Text")
        }

}
