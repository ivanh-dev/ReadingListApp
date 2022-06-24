//
//  AddBookView.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 23.06.2022..
//

import SwiftUI

struct AddBookView: View {
    
    @EnvironmentObject var readingListModel: ReadingListModel
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    @State var bookPages: String = ""
    @State var selectedGenre: Int = 0
    @State var selectedStatus: Int = 0
    @State var selectedRating: Int = 0
    
    
    var body: some View {
        
        VStack {
            ScrollView {
                
                TextField("Book Title", text: $bookTitle)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                TextField("Book Author(s)", text: $bookAuthor)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                TextField("Book Pages", text: $bookPages)
                    .keyboardType(.numberPad)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                VStack {
                    
                    Text("Rating:")
                    
                    Picker(selection: $selectedRating) {
                        ForEach(0..<6) { rating in
                            if rating == 0 {
                                Text("N/A")
                            } else {
                                Text("\(rating)")
                            }
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Text("Status:")
                    
                    Picker(selection: $selectedStatus) {
                        ForEach(0..<readingListModel.statuses.count, id: \.self) {
                            Text(readingListModel.statuses[$0])
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    
                    Text("Genre:")
                    
                    Picker(selection: $selectedGenre) {
                        ForEach(0..<readingListModel.genres.count, id: \.self) {
                            Text(readingListModel.genres[$0])
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Button("Submit Book") {
                        if bookTitle != "" && bookAuthor != "" {
                            let newBook = Book(id: "", title: bookTitle, author: bookAuthor, genre: readingListModel.genres[selectedGenre], status: readingListModel.statuses[selectedStatus], pages: Int(bookPages) ?? 0, rating: selectedRating)
                            
                            readingListModel.addBook(book: newBook)
                            
                        }
                    }
                }
            }
        }
        
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
            .environmentObject(ReadingListModel())
    }
}
