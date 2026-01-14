//
//  VlowLibraryTests.swift
//  VlowLibraryTests
//
//  Created by Nathan Gunawan on 11/01/26.
//
import Testing
import Foundation

@testable import VlowLibrary

@MainActor
struct VlowLibraryTests {
    
    // ===== TAMBAHKAN 5 TEST CASES BARU DI BAWAH INI =====
    
    // TC-01: testToDate_ValidFormat_ReturnsDate
    @Test("Valid date string converts to Date object")
    func toDate_validFormat_returnsDate() {
        let dateString = "2026-01-14"
        
        let result = dateString.toDate()
        
        #expect(result != nil)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: result!)
        
        #expect(components.year == 2026)
        #expect(components.month == 1)
        #expect(components.day == 14)
    }
//    
//    // TC-02: testSignIn_EmptyUsername_SetsError
    @Test("Empty username shows error message")
    func signIn_emptyUsername_setsError() async {
        let vm = LoginViewModel()
        vm.username = ""
        
        await vm.signIn()
        
        #expect(vm.errorMessage == "Username tidak boleh kosong")
        #expect(vm.signedInUser == nil)
    }
//    
//    // TC-03: testSignIn_ValidUsername_ClearsError
    @Test("Valid username clears previous error")
    func signIn_validUsername_clearsError() async {
        let vm = LoginViewModel()
        vm.username = "nathan"
        vm.errorMessage = "Previous error"
        
        await vm.signIn()
        
        // Error akan di-clear dulu, lalu di-set lagi oleh API response
        #expect(vm.errorMessage != "Previous error")
    }
//    
//    // TC-04: testCreateLoan_NoUserSelected_ShowsError
    @Test("Creating loan without user shows error")
    func createLoan_noUserSelected_showsError() async {
        let vm = BorrowViewModel()
        vm.selectedUserId = nil
        vm.selectedBookId = UUID()
        
        await vm.createLoan()
        
        #expect(vm.errorMessage == "Pilih user & buku dulu")
    }
//    
//    // TC-05: testBookTitle_WithValidTitle_ReturnsTitle
    @Test("Book title returns actual value when available")
    func bookTitle_withValidTitle_returnsTitle() {
        let loan = Loan(
            id: UUID(),
            user_id: UUID(),
            staff_id: UUID(),
            book_id: UUID(),
            loan_date: "2026-01-14",
            due_date: "2026-01-21",
            returned: false,
            return_date: nil,
            notes: nil,
            book_title: "Swift Programming Guide"
        )
        
        #expect(loan.bookTitle == "Swift Programming Guide")
    }
}
