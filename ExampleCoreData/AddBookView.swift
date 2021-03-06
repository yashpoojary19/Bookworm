//
//  AddBookView.swift
//  ExampleCoreData
//
//  Created by Yash Poojary on 22/10/21.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var dateAdded = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Review", text: $review)
                    
                    
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        
                        newBook.date = dateAdded
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        try? moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                }
                .disabled(genre.isEmpty)
            }
            .navigationBarTitle("Add Book")
            
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
