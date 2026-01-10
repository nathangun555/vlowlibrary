//
//  BorrowViewModel.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class BorrowViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var availableBooks: [Book] = []
    @Published var selectedUserId: UUID?
    @Published var selectedBookId: UUID?
    @Published var notes = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var selectedLoanDate = Date()
    
    private let client = SupabaseService.shared.client
    private let currentStaffId = SupabaseService.shared.currentUser?.id
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let usersTask = client.getUsers()
            async let booksTask = client.getAvailableBooks()
            
            self.users = try await usersTask
            self.availableBooks = try await booksTask
        } catch {
            errorMessage = "Gagal load data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func createLoan() async {
        guard let userId = selectedUserId,
              let bookId = selectedBookId,
              let staffId = currentStaffId else {
            errorMessage = "Pilih user & buku dulu"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await client.createLoan(
                userId: userId,
                staffId: staffId,
                bookId: bookId,
                loanDate: selectedLoanDate,
                notes: notes.isEmpty ? nil : notes
            )
            
            successMessage = "Pinjaman berhasil dibuat!"
            notes = ""
            selectedUserId = nil
            selectedBookId = nil
            
            // Reload data
            await loadData()
        } catch {
            errorMessage = "Gagal buat pinjaman: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
