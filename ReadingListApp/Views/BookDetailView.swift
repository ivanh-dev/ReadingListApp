//
//  BookDetailView.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 23.06.2022..
//

import SwiftUI

struct BookDetailView: View {
    
    @EnvironmentObject var readingListModel: ReadingListModel
    @State var selectedGenre: Int = 0
    @State var seletedStatus: Int = 0
    @State var selectedRating: Int = 0
    var book: Book
    
    var body: some View {
        
        VStack {
            ScrollView {
                Text(book.title)
                    .font(.headline)
                    .onAppear() {
                        selectedGenre = readingListModel.genres.firstIndex(of: book.genre) ?? 0
                        seletedStatus = readingListModel.statuses.firstIndex(of: book.status) ?? 0
                        selectedRating = book.rating
                    }
                
                Text(book.author)
                
                if book.pages != 0 {
                    Text("Pages: \(book.pages)")
                }
                
                Divider()
                
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
                    
                    Text("Status")
                    Picker(selection: $seletedStatus) {
                        ForEach(0..<readingListModel.statuses.count, id: \.self) {
                            Text(readingListModel.statuses[$0])
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Text("Genre")
                    Picker(selection: $selectedGenre) {
                        ForEach(0..<readingListModel.genres.count, id: \.self) {
                            Text(readingListModel.genres[$0])
                        }
                    } label: {
                        Text("")
                    }
                    .pickerStyle(WheelPickerStyle())

                    
                    Button {
                        let updateBook = Book(id: book.id, title: book.title, author: book.title, genre: readingListModel.genres[selectedGenre], status: readingListModel.statuses[seletedStatus], pages: book.pages, rating: selectedRating)
                        
                        readingListModel.updateBookData(book: updateBook)
                    } label: {
                        Text("Save Changes")
                    }
                    
                    Spacer()
                    
                    Button {
                        readingListModel.deleteBook(book: book)
                    } label: {
                        Text("Delete Book")
                            .padding()
                    }


                    
                }
            }
            
        }
        
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView( book: Book(id: "", title: "Test", author: "test", genre: "test", status: "test", pages: 10, rating: 1))
            .environmentObject(ReadingListModel())
    }
}
