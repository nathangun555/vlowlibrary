//
//  LoansTabView.swift (ActiveLoansTabView + MyLoansTabView merged)
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import SwiftUI

struct LoansTabView: View {
    let role: UserRole
    @EnvironmentObject var viewModel: LoansViewModel
    
    private var title: String {
        role == .staff ? "Pinjaman" : "Pinjaman Saya"
    }
    
    private func isOverdue(_ loan: Loan) -> Bool {
        loan.isOverdue
    }

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading pinjaman...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.activeLoans.isEmpty {
                    ContentUnavailableView(
                        title,
                        systemImage: "checkmark.circle",
                        description: Text(role == .staff ? "Tidak ada pinjaman aktif" : "Semua buku sudah dikembalikan")
                    )
                } else {
                    List {
                        ForEach(viewModel.activeLoans) { loan in
                            LoanRowView(
                                loan: loan,
                                isOverdue: loan.isOverdue,
                                role: role,
                                onReturn: { Task { await viewModel.returnLoan(loanId: loan.id!) } }
                            )
                        }
                    }
                    .refreshable {
                        await viewModel.loadActiveLoans()
                    }
                }
            }
            .navigationTitle(title)
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
                Task { await viewModel.loadActiveLoans() }
            }
        }
    }
}

struct LoanRowView: View {
    let loan: LoanWithBook
    let isOverdue: Bool
    let role: UserRole
    let onReturn: () -> Void  // Callback to VM
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(loan.books?.title ?? "Unknown Book")
                    .font(.headline)

                // 🔽 TAMBAHAN BARU (peminjam)
                if role == .staff {
                    Text("Peminjam: \(loan.borrowerName)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                HStack {
                    Text("Pinjam: \(loan.loan_date)")
                    Spacer()
                    Text("Tempo: \(loan.due_date)")
                        .foregroundStyle(isOverdue ? .red : .orange)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            
            Spacer()
            
            if role == .staff {
                Button("Kembalikan") {
                    onReturn()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .background(isOverdue ? Color.red.opacity(0.1) : Color.clear)
    }
}

#Preview("Staff Loans") {
    LoansTabView(role: .staff)
        .environmentObject(LoansViewModel(role: .staff))
}
