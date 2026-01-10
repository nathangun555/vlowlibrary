//
//  LoansViewModel.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class LoansViewModel: ObservableObject {
    @Published var activeLoans: [LoanWithBook] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    let role: UserRole
    private let client = SupabaseService.shared.client
    private let currentUserId = SupabaseService.shared.currentUser?.id
    
    init(role: UserRole) {
        self.role = role
    }
    
    func loadActiveLoans() async {
        isLoading = true
        errorMessage = nil
        
        do {
            activeLoans = try await client.getActiveLoans(role: role, currentUserId: currentUserId) as! [LoanWithBook]
        } catch {
            errorMessage = "Gagal load pinjaman: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func returnLoan(loanId: UUID) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await client.returnLoan(loanId: loanId)
            successMessage = "Buku berhasil dikembalikan!"
            await loadActiveLoans()  // Refresh list
        } catch {
            errorMessage = "Gagal return: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
