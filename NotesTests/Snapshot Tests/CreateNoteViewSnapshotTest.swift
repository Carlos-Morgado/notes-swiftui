//
//  CreateNoteViewSnapshotTest.swift
//  NotesTests
//
//  Created by Carlos Morgado on 22/3/24.
//

import XCTest
import SnapshotTesting
@testable import Notes_swiftui

final class CreateNoteViewSnapshotTest: XCTestCase {
    
    func testCreateNoteView() throws {
        let createNoteView = CreateNoteView(viewModel: .init())
        assertSnapshot(of: createNoteView, as: .image)
    }
    
    func testCreateNoteViewWithData() {
        let createNoteView = CreateNoteView(viewModel: .init(),
                                            title: "Suscríbete a SwiftBeta!",
                                            text: "Apoya al canal 🎉")
        assertSnapshot(of: createNoteView, as: .image)
    }
}
