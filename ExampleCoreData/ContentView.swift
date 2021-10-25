//
//  ContentView.swift
//  ExampleCoreData
//
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books:  FetchedResults<Book>
    
    @State private var showingAddScreen = false

    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
        
                        NavigationLink(destination: DetailView(book: book)) {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                
                            }
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unkown title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.black)
                                Text(book.author ?? "Unkwon Author")
                                    .foregroundColor(Color.secondary)
                                
                            }
                            
                            
                        }
                        
                     
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("BookWorm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAddScreen.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, moc)
                }
                
        }
        
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//struct ContentView: View {
//
//    @Environment(\.horizontalSizeClass) var sizeClass
//
//
//
//    var body: some View {
//        if sizeClass == .compact {
//            return AnyView(VStack {
//                Text("This size class is")
//                Text("Compact")
//                })
//               }   else {
//                return AnyView(HStack {
//                    Text("This size class is")
//                    Text("regular")
//                })
//            }
//        }
//    }




//struct ButtonView: View {
//    var title: String
//    @Binding var isOn: Bool
//
//    var onColors = [Color.red, Color.yellow]
//    var offColors = [Color(white: 0.6), Color(white: 0.3)]
//
//
//    var body: some View {
//        Button(title) {
//            isOn.toggle()
//        }
//        .padding()
//        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .topLeading, endPoint: .bottomTrailing))
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//        .shadow(radius: isOn ? 5 : 0)
//
//    }
//}
//
//
//struct ContentView: View {
//    @State private var rememberMe = false
//
//
//    var body: some View {
//        VStack {
//            ButtonView(title: "Remember Me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
//    }
//}



//struct ContentView: View {
//
//
//    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
//
//
//    var body: some View {
//        VStack {
//            List(students, id: \.id) { student in
//                Text(student.name ?? "Unkown")
//            }
//            Button("Add Name") {
//                let firstName = ["Yash", "Khushmi", "Divya"]
//                let lastName = ["Poojary", "Chheda"]
//
//                let chosenFirstName = firstName.randomElement()!
//                let chosenLastName = lastName.randomElement()!
//
//
//                let student = Student(context: moc)
//
//                student.id = UUID()
//                student.name = "\(chosenFirstName) \(chosenLastName)"
//
//                try? moc.save()
//
//
//            }
//        }
//    }
//
//
//
//}

//@FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>

//VStack {
//            List {
//                ForEach(students, id: \.id) { student in
//                    Text(student.name ?? "Unkown")
//                }
//            }
//            Button("Add") {
//                let firstNames = ["Yash", "Khusmhi", "Divya"]
//                let lastNames = ["Chheda", "Poojary"]
//
//                let chosenFirstName = firstNames.randomElement()!
//                let chosenlastName = lastNames.randomElement()!
//
//                let student = Student(context: moc)
//                student.id = UUID()
//                student.name = "\(chosenFirstName) \(chosenlastName)"
//
//                try? moc.save()
//            }
//        }
