//
//  noteModel.swift
//  Notes-swiftui
//
//  Created by Carlos Morgado on 19/3/24.
//

import Foundation
import SwiftData

@Model
class NoteModel: Identifiable, Hashable {
    @Attribute(.unique) var identifier: UUID
    var title: String
    var text: String?
    var createdAt: Date
    
    var getText: String {
        text ?? ""
    }
    
    init(identifier: UUID = UUID(), title: String, text: String?, createdAt: Date) {
        self.identifier = identifier
        self.title = title
        self.text = text
        self.createdAt = createdAt
    }
}
