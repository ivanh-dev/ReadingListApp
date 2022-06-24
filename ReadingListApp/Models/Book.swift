//
//  Book.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 23.06.2022..
//

import Foundation

struct Book: Hashable, Identifiable {
    
    var id: String
    var title: String
    var author: String
    var genre: String
    var status: String
    var pages: Int
    var rating: Int
}
