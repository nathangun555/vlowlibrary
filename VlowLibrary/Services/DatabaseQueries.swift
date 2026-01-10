////
////  DatabaseQueries.swift
////  VlowLibraryApp
////
////  Created by Nathan Gunawan on 09/01/26.
////


import SwiftUI
import Supabase

extension SupabaseClient {
    
    func getAvailableBooks(search: String? = nil) async throws -> [Book] {
        try await self
            .from("books")
            .select("id, title, author, isbn, category, available_copies")
            .order("title")
            .execute()
            .value
    }


    func getUsers(search: String? = nil) async throws -> [User] {
        if let search = search?.trimmingCharacters(in: .whitespacesAndNewlines), !search.isEmpty {
            return try await self.from("users")
                .select("id, username, role, card_number, name, phone, email, address")
                .or("name.ilike.%\(search)%,card_number.ilike.%\(search)%")
                .order("name")
                .execute()
                .value
        }
        
        return try await self.from("users")
            .select("id, username, role, card_number, name, phone, email, address")
            .order("name")
            .execute()
            .value
    }
    
    func getActiveLoans(role: UserRole, currentUserId: UUID? = nil) async throws -> [LoanWithBook] {
        var query = self.from("loans")
            .select("""
                *,
                books(*),
                borrower:users!loans_user_id_fkey(*),
                staff:users!loans_staff_id_fkey(*)
            """)
            .eq("returned", value: false)
        
        if role == .member, let userId = currentUserId {
            query = query.eq("user_id", value: userId.uuidString)
        }
        
        return try await query
            .order("loan_date", ascending: false)
            .execute()
            .value
    }




    func createLoan(
        userId: UUID,
        staffId: UUID,
        bookId: UUID,
        loanDate: Date,
        notes: String? = nil
    ) async throws -> Loan {

        let loanDate = Date()
        let dueDate = Calendar.current.date(byAdding: .day, value: 7, to: loanDate)!

        let payload = CreateLoanPayload(
            user_id: userId.uuidString,
            staff_id: staffId.uuidString,
            book_id: bookId.uuidString,
            loan_date: loanDate,
            due_date: dueDate,
            notes: notes
        )

        let loan: Loan = try await self
            .from("loans")
            .insert(payload)
            .select()
            .single()
            .execute()
            .value

        return loan
    }


    func returnLoan(loanId: UUID) async throws {
        try await self.from("loans")
            .update(["returned": true])
            .eq("id", value: loanId.uuidString)
            .execute()

        try await self.from("loans")
            .update(["return_date": Date()])
            .eq("id", value: loanId.uuidString)
            .execute()
    }
}
