//
//  UpdateNoteView.swift
//  Notes-swiftui
//
//  Created by Carlos Morgado on 19/3/24.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: ViewModel
    var id: UUID
    @State var title: String = ""
    @State var text: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Texto"), axis: .vertical)
                }
            }
            Button(action: {
                viewModel.removeNoteWith(id: id)
                dismiss()
            }, label: {
                Text("Eliminar nota")
                    .foregroundStyle(.gray)
                    .underline()
            })
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.updateNoteWith(id: id, newTitle: title, newText: text)
                    dismiss()
                } label: {
                    Text("Guardar Nota")
                        .bold()
                }
            }
        }
        .navigationTitle("Modificar nota")
    }
}

#Preview {
    NavigationStack {
        UpdateNoteView(viewModel: .init(), id: .init(), title: "Suscríbete", text: "Aprende Swift, SwiftUI, Arquitecturas, Combine, Testing...")
    }
}
