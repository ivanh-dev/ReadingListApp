//
//  ContentView.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 23.06.2022..
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var readingListModel: ReadingListModel
    
    var body: some View {
        
        TabView {
            FullView()
                .tabItem {
                    Image(systemName: "book")
                    Text("All Books")
                }
            
            GenreView()
                .tabItem {
                    Image(systemName: "folder")
                    Text("Genres")
                }
        }
    }
}
