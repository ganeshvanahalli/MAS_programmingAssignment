//
//  NotesListViewModel.swift
//  NotesApp
//
//  Created by Somya Doshi on 1/30/22.
//

import Foundation
import Combine

class NotesListViewModel: ObservableObject {
    @Published var notesViewModels = [NotesViewModel]()
    @Published var noteRepo = NoteRepo()
    
    private var cancel = Set<AnyCancellable>()
    
    init() {
        noteRepo.$notes
            .map { notes in
                notes.map { note in
                    NotesViewModel(note: note)
                }
            }
            .assign(to: \.notesViewModels, on: self)
            .store(in: &cancel)
    }
    
    func removeNotes(note: Note) {
        noteRepo.deleteNote(note)
    }
    
    func addNote(note: Note) {
        noteRepo.addNote(note)
    }
}
