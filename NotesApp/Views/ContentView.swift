//
//  ContentView.swift
//  NotesApp
//
//  Created by Somya Doshi on 1/29/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var notesListVM = NotesListViewModel()
    
    @State var addNewNote = false
    
    @State var loggedIn = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(notesListVM.notesViewModels) { noteViewModel in
                        CardView(data:noteViewModel)
                    }
                    if addNewNote {
                        CardView(data: NotesViewModel(note: Note(title: "Add Title", content: "Add Content", date: convertDate(date: Date.now), color: getRandomColor()))) { note in
                            self.notesListVM.addNote(note: note)
                            self.addNewNote.toggle()
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing:
                                    HStack {
                Button(action: {self.addNewNote.toggle()}) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.horizontal, 15)
                    
                    Button(action: {self.loggedIn.toggle()}) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            )
            .sheet(isPresented: $loggedIn) {
                SignIn()
            }
        }
        
    }
}

func getRandomColor() -> String {
    let colors = ["pastelBlue", "pastelOrange", "pastelPurple", "pastelYellow", "pastelDarkOrange"]
    return colors.randomElement()!
}

func convertDate(date: Date) -> String {
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date / server String
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    //let myString = formatter.string(from: Date()) // string purpose I add here
    let myString = formatter.string(from: date) // string purpose I add here
    // convert your string to date
    let yourDate = formatter.date(from: myString)
    //then again set the date format which type of output you need
    formatter.dateFormat = "EEEE, MMM d, yyyy, hh:mm:ss"
    // again convert your date to string
    let myStringafd = formatter.string(from: yourDate!)
    return myStringafd
}

extension Date {
    func toSeconds() -> Int64! {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    
    init(seconds:Int64!) {
        self = Date(timeIntervalSince1970: TimeInterval(Double.init(seconds)))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
