//
//  ViewModelTests.swift
//  NotesTests
//
//  Created by Carlos Morgado on 19/3/24.
//

import XCTest
@testable import Notes_swiftui

final class ViewModelTests: XCTestCase {
    var viewModel: ViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModel(createNoteUseCase: CreateNoteUseCaseMock(),
                              fetchAllNotesUseCase: FetchAllNotesUseCaseMock(),
                              updateNoteUseCase: UpdateNoteUseCaseMock(),
                              removeNoteUseCase: RemoveNoteUseCaseMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockDatabase = []
    }
    
    func testCreateNote() {
        let title = "Test Title"
        let text = "Test Text"
        
        viewModel.createNoteWith(title: title, text: text)
        
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
    }
    
    func testCreateThreeNotes() {
        let title1 = "Test Title 1"
        let text1 = "Test Text 1"
        
        let title2 = "Test Title 2"
        let text2 = "Test Text 2"
        
        let title3 = "Test Title 3"
        let text3 = "Test Text 3"
        
        viewModel.createNoteWith(title: title1, text: text1)
        viewModel.createNoteWith(title: title2, text: text2)
        viewModel.createNoteWith(title: title3, text: text3)
        
        XCTAssertEqual(viewModel.notes.count, 3)
        XCTAssertEqual(viewModel.notes.first?.title, title1)
        XCTAssertEqual(viewModel.notes.first?.text, text1)
        
        XCTAssertEqual(viewModel.notes[1].title, title2)
        XCTAssertEqual(viewModel.notes[1].text, text2)
        
        XCTAssertEqual(viewModel.notes[2].title, title3)
        XCTAssertEqual(viewModel.notes[2].text, text3)
    }
    
    func testUpdateNote() {
        //Given
        let title = "Test Title"
        let text = "Test Text"
        
        viewModel.createNoteWith(title: title, text: text)
        
        let newTitle = "New Title"
        let newText = "New Text"
        
        // When
        if let identifier = viewModel.notes.first?.identifier {
            viewModel.updateNoteWith(identifier: identifier, newTitle: newTitle, newText: newText)
            // Then
            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
            XCTAssertEqual(viewModel.notes.first?.text, newText)

        } else {
            XCTFail("No note was created.")
        }
    }
 
    func testRemoveNote() {
        //Given
        let title = "Test Title"
        let text = "Test Text"
        
        viewModel.createNoteWith(title: title, text: text)
        
        if let identifier = viewModel.notes.first?.identifier {
            // when
            viewModel.removeNoteWith(identifier: identifier)
            // Then
            XCTAssertTrue(viewModel.notes.isEmpty)
        } else {
            XCTFail()
        }
    }

}
