//
//  CardView.swift
//  NotesApp
//
//  Created by Somya Doshi on 1/30/22.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var data: NotesViewModel
    @ObservedObject var noteRepo = NoteRepo()
    
    var onCommit: (Note) -> (Void) = { _ in }
        
    var body: some View {
        
        VStack(alignment: .leading) {
            Group {
                TextField("Title", text: $data.note.title, onCommit: {
                    self.onCommit(self.data.note)
                })
            }
            .font(Font.system(size: 20, weight: .bold, design: .default))
            
            TextEditor(text: $data.note.content)
                .multilineTextAlignment(.leading)
                .frame(alignment: .leading)
                .colorMultiply(Color(data.note.color))
                .onChange(of: data.note.content, perform: { value in
                    self.data.note.content = value
                })
            
            
            HStack {
                Text(data.note.date)
                    .font(.footnote)
                
                Spacer()
                
                Button(action: {
                    noteRepo.deleteNote(data.note)
                }) {
                    Image(systemName: "minus.circle")
                    .padding(6)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(Circle())
                }
            }
            .padding(.top, 15)
        }
        .padding()
        .background(Color(data.note.color))
        .cornerRadius(18)
        .padding([.top, .leading, .trailing], 15.0)
        
    }
}
