//
//  GenreSectionView.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 23.06.2022..
//

import SwiftUI

struct GenreSectionView: View {
    
    @EnvironmentObject var readingListModel: ReadingListModel
    var genre: String
    
    var body: some View {
        
        Text(genre).font(.title2)
            .onAppear() {
                readingListModel.getBooksByGenre(genre: genre)
            }
        
        if readingListModel.books[genre] != nil {
            let books = readingListModel.books[genre]
            
            ForEach(books!, id: \.self) { book in
                NavigationLink {
                    BookDetailView(book: book)
                } label: {
                    VStack (alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                            .padding(5)
                            .padding(.leading, 10)
                        Text(book.author)
                            .padding(.leading, 20)
                    }
                }

            }
        }
        
    }
}

struct GenreSectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSectionView(genre: "new")
            .environmentObject(ReadingListModel())
    }
}
