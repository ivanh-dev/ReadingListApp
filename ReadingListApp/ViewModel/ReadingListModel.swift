//
//  ReadingListModel.swift
//  ReadingListApp
//
//  Created by Ivan Hirsinger on 23.06.2022..
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class ReadingListModel: ObservableObject {
    
    @Published var genres: [String] = []
    
    @Published var books: [String: [Book]] = [:]
    
    @Published var statuses: [String] = ["Plan to read", "Reading", "On hold", "Completed"]
    
    init() {
        getGenres()
    }
    
    func addBook(book: Book) {
        
        let db = Firestore.firestore()
        
        let books = db.collection("books")
        
        books.document().setData(["title": book.title, "author": book.author, "genre": book.genre, "status": book.status, "pages": book.pages, "rating": book.rating])
        
    }
    
    func deleteBook(book: Book) {
        
        let db = Firestore.firestore()
        
        let books = db.collection("books")
        
        let bookDoc = books.document(book.id)
        
        bookDoc.delete()
        
    }
    
    func updateBookData(book: Book) {
        
        let db = Firestore.firestore()
        
        let books = db.collection("books")
        
        let bookDoc = books.document(book.id)
        
        bookDoc.updateData(["genre": book.genre, "status": book.status, "rating": book.rating])
        
    }
    
    func getBooksByGenre(genre: String) {
        
        let db = Firestore.firestore()
        
        let books = db.collection("books")
        
        let query = books.whereField("genre", in: [genre])
        
        query.getDocuments { querySnapshot, error in
            
            if let error = error {
                print(error.localizedDescription)
                
            } else if let querySnapshot = querySnapshot {
                var allBooks: [Book] = []
                for doc in querySnapshot.documents {
                    let data = doc.data()
                    
                    let id = doc.documentID
                    let title = data["title"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let genre = data["genre"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let pages = data["pages"] as? Int ?? 0
                    let rating = data["rating"] as? Int ?? 1
                    
                    allBooks.append(Book(id: id, title: title, author: author, genre: genre, status: status, pages: pages, rating: rating))
                }
                self.books[genre] = allBooks
            } else {
                print("No data returned")
            }
        }
    }
    
    func addGenre(genre: String) {
        
        let db = Firestore.firestore()
        
        let genres = db.collection("genres")
        
        genres.document(genre).setData([:])
    }
    
    func getGenres() {
        
        let db = Firestore.firestore()
        
        let genres = db.collection("genres")
        
        genres.getDocuments { querySnapshot, error in
            
            if let error = error {
                print(error.localizedDescription)
                
            } else if let querySnapshot = querySnapshot {
                var allGenres: [String] = []
                for doc in querySnapshot.documents {
                    allGenres.append(doc.documentID)
                }
                self.genres = allGenres
            } else {
                print("No data was returned")
            }
        }
        
    }
    
}
