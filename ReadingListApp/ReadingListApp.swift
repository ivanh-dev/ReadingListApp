//
//  ReadingListApp.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 23.06.2022..
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct ReadingListApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(ReadingListModel())
        }
    }
}
