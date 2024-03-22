//
//  NotesTests.swift
//  NotesTests
//
//  Created by Carlos Morgado on 19/3/24.
//

import XCTest
@testable import Notes_swiftui

final class NoteTest: XCTestCase {

    func testNoteInitialization() {
        // Given or Arrange. Preparamos los datos
        let title = "Test Title"
        let text = "Test Text"
        let date = Date()
        
        // When or Act. La parte del test donde ocurre la acción
        let note = NoteModel(title: title, text: text, createdAt: date)
        
        // The or Assert. Donde se especifica el resultado o cambio esperado de la acción o evento.
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.text, text)
        XCTAssertEqual(note.createdAt, date)
        
    }
    
    func testNoteEmptyText() {
        let title = "Test Title"
        let date = Date()
        
        let note = NoteModel(title: title, text: nil, createdAt: date)
        
        XCTAssertEqual(note.getText, "")
    }
}
