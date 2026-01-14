//
//  CatalogViewModel.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import SwiftUI
import Foundation
import Observation
import Combine

@MainActor
class CatalogViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var filteredBooks: [Book] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let client = SupabaseService.shared.client
    
    func loadBooks(search: String? = nil) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let loadedBooks = try await client.getAllBooks(search: search ?? searchText)
            books = loadedBooks
            filteredBooks = loadedBooks
        } catch {
            errorMessage = "Gagal load katalog: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func filterBooks() {
        if searchText.isEmpty {
            filteredBooks = books
        } else {
            filteredBooks = books.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
