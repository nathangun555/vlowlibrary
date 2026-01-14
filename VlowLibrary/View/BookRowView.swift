//
//  BookRowView.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import SwiftUI

struct BookRowView: View {
    let book: Book
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .lineLimit(2)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if ((book.category?.isEmpty) == nil) {
                    Text(book.category!)
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(.indigo.opacity(0.1))
                        .foregroundStyle(.indigo)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            
            Spacer()
            
            // Status kanan: Text + Icon
            HStack(spacing: 4) {
                Image(systemName: book.available_copies ? "checkmark.circle.fill" : "xmark.circle")
                    .font(.title3)
                    .foregroundStyle(book.available_copies ? .green : .orange)
                
                Text(book.available_copies ? "Available" : "Unavailable")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(book.available_copies ? .green : .orange)
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 12) {
        BookRowView(book: Book(id: UUID(), title: "SwiftUI Design Patterns", author: "Nathan Gunawan", isbn: "123", category: "Design", available_copies: true))
        BookRowView(book: Book(id: UUID(), title: "iOS MVVM Guide", author: "Apple Team", isbn: "456", category: "Development", available_copies: false))
    }
    .padding()
}
