//
//  Note.swift
//  NotesApp
//
//  Created by Somya Doshi on 1/29/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// Creating the viewwmodel for the data
struct Note: Identifiable, Hashable, Codable {
    var currentUser: String?
    @DocumentID var id: String?
    @ServerTimestamp var serverTime: Timestamp?
    var title: String
    var content: String
    var date: String
    var color: String
}
