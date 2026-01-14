////
////  Loan.swift
////  VlowLibrary
////
////  Created by Nathan Gunawan on 09/01/26.
////



import Foundation

struct Loan: Codable, Identifiable {
    let id: UUID?
    let user_id: UUID
    let staff_id: UUID?
    let book_id: UUID
    let loan_date: String  
    let due_date: String
    let returned: Bool
    let return_date: String?
    let notes: String?
    let book_title: String?
    
    var loanDate: Date { loan_date.toDate() ?? Date() }
    var dueDate: Date { due_date.toDate() ?? Date() }
    var isOverdue: Bool { dueDate < Date() && !returned }
    var bookTitle: String { book_title ?? "Unknown Book" }
}

struct CreateLoanPayload: Encodable {
    let user_id: String
    let staff_id: String
    let book_id: String
    let loan_date: Date
    let due_date: Date
    let notes: String?
    
}

struct LoanWithBook: Codable, Identifiable {
    let id: UUID?
    let user_id: UUID
    let staff_id: UUID?
    let book_id: UUID
    let loan_date: String
    let due_date: String
    let returned: Bool
    let return_date: String?
    let notes: String?
    
    let borrower: User?
    let staff: User?
    
    let books: Book?
    
    
    var borrowerName: String {
            borrower?.name ?? "Unknown Member"
        }
    
    var bookTitle: String { books?.title ?? "Unknown" }
    var loanDate: Date { loan_date.toDate() ?? Date() }
    var dueDate: Date { due_date.toDate() ?? Date() }
    var isOverdue: Bool { dueDate < Date() && !returned }
    
}


extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}



