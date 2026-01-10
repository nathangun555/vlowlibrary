//
//  BorrowTabView.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import SwiftUI

struct BorrowTabView: View {
    @EnvironmentObject var viewModel: BorrowViewModel
    
    private var selectedUser: User? {
        viewModel.users.first { $0.id == viewModel.selectedUserId }
    }
    
    private var selectedBook: Book? {
        viewModel.availableBooks.first { $0.id == viewModel.selectedBookId }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Pilih Member") {
                    Picker("User", selection: $viewModel.selectedUserId) {
                        Text("Pilih member").tag(UUID?.none)
                        ForEach(viewModel.users) { user in
                            Text("\(user.name) (\(user.card_number))")
                                .tag(user.id as UUID?)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Pilih Buku") {
                    Picker("Buku Tersedia", selection: $viewModel.selectedBookId) {
                        Text("Pilih buku").tag(UUID?.none)
                        ForEach(viewModel.availableBooks) { book in
                            Text("\(book.title) - \(book.author)")
                                .tag(book.id as UUID?)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Tanggal Pinjam") {
                    DatePicker(
                        "Loan Date",
                        selection: $viewModel.selectedLoanDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)  // atau .graphical untuk wheel
                }
                Section {
                    Button("Buat Pinjaman") {
                        Task { await viewModel.createLoan() }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.selectedUserId == nil ||
                            viewModel.selectedBookId == nil ||
                            viewModel.isLoading)
                }
            }
            .navigationTitle("Pinjam Buku")
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .alert("Sukses", isPresented: .constant(viewModel.successMessage != nil)) {
                Button("OK") { viewModel.successMessage = nil }
            } message: {
                Text(viewModel.successMessage ?? "")
            }
            .onAppear {
                Task { await viewModel.loadData() }
            }
        }
    }
}

#Preview {
    BorrowTabView()
        .environmentObject(BorrowViewModel())
}
