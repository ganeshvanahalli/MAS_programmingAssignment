//
//  NoteRepo.swift
//  NotesApp
//
//  Created by Somya Doshi on 1/30/22.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase


class NoteRepo: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var notes = [Note]()
    
    init() {
        loadData()
    }
    
    func addNote(_ note: Note) {
        do {
            var newNote = note
            newNote.currentUser = Auth.auth().currentUser?.uid
            let _ = try db.collection("notes").addDocument(from: newNote)
        }
        catch {
            fatalError("Not able to add note")
        }
        
    }
    
    func updateNote(_ note: Note) {
        if let noteID = note.id {
            do {
                let _ = try db.collection("notes").document(noteID).setData(from: note)
            }
            catch {
                fatalError("Not able to update note")
            }
        }
    }
    
    func deleteNote(_ note: Note) {
        if let noteID = note.id {
            db.collection("notes").document(noteID).delete { (error) in
                if error != nil {
                    print("Not able to delete note")
                }
            }
        }
    }
    
    func loadData() {
        let currentUserTemp = Auth.auth().currentUser?.uid
        
        db.collection("notes")
            .whereField("currentUser", isEqualTo: currentUserTemp)
            .order(by: "serverTime", descending: false)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.notes = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Note.self)
                }
            }
        }
    }
}
