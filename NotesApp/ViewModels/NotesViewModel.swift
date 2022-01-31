//
//  NotesViewModel.swift
//  NotesApp
//
//  Created by Somya Doshi on 1/30/22.
//

import Foundation
import Combine

class NotesViewModel: ObservableObject, Identifiable {
    @Published var note: Note
    
    @Published var noteRepo = NoteRepo()
    
    private var cancel = Set<AnyCancellable>()
    
    var id = ""
    
    init(note: Note) {
        self.note = note
        
        $note
            .compactMap { note in
                note.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancel)
        
        $note
            .dropFirst()
            .debounce(for: 1.0, scheduler: RunLoop.main)
            .sink { [weak self] note in
                self?.noteRepo.updateNote(note)
            }
            .store(in: &cancel)
    }
}

