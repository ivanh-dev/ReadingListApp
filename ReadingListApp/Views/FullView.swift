//
//  FullView.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 24.06.2022..
//

import SwiftUI

struct FullView: View {
    
    @EnvironmentObject var readingListModel: ReadingListModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                NavigationLink(destination: AddBookView()) {
                    Text("Add Book")
                }
                
                if readingListModel.genres.count == 0 {
                    Text("No genres/books found.")
                } else {
                    List {
                        ForEach(readingListModel.genres, id: \.self) { genre in
                            GenreSectionView(genre: genre)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
