//
//  GenreView.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 24.06.2022..
//

import SwiftUI

struct GenreView: View {
    
    @EnvironmentObject var readingListModel: ReadingListModel
    
    @State var newGenre = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                TextField("New Genre", text: $newGenre)
                    .multilineTextAlignment(.center)
                
                Button  {
                    if newGenre != "" {
                        readingListModel.addGenre(genre: newGenre)
                        readingListModel.getGenres()
                        newGenre = ""
                    }
                } label: {
                    Text("Add Genre")
                        .padding(.bottom, 50)
                }
                
                if readingListModel.genres.count == 0 {
                    Text("No genres found. Add a genre to get started.")
                } else {
                    ScrollView {
                        ForEach(readingListModel.genres, id: \.self) { genre in
                            NavigationLink(destination:
                                            List { GenreSectionView(genre: genre)}) {
                                Text(genre)
                            }
                        }
                    }
                }

            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
