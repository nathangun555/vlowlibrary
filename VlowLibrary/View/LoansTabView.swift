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
    let onReturn: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // 📘 Judul Buku
            Text(loan.books?.title ?? "Unknown Book")
                .font(.headline)
                .foregroundStyle(.primary)
            
            // 👤 Peminjam (khusus staff)
            if role == .staff {
                Text("Peminjam: \(loan.borrowerName)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Divider()
            
            // 📅 Info Tanggal
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pinjam")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(loan.loan_date)
                        .font(.caption)
                }
                
                Spacer()
                
                
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Tempo")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(loan.due_date)
                        .font(.caption)
                        .foregroundStyle(isOverdue ? .red : .orange)
                    
                }
                
                
            }

            if role == .staff {
                Button(action: onReturn) {
                    Text("Kembalikan")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .padding(.top, 4)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isOverdue ? Color.red.opacity(0.08) : Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

#Preview("Staff Loans") {
    LoansTabView(role: .staff)
        .environmentObject(LoansViewModel(role: .staff))
}
