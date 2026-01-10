import SwiftUI
import Supabase

struct CatalogTabView: View {
    @EnvironmentObject var viewModel: CatalogViewModel

    var body: some View {
        VStack(spacing: 0) {

            if viewModel.isLoading {
                ProgressView("Loading katalog...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            } else if viewModel.books.isEmpty && viewModel.searchText.isEmpty {
                ContentUnavailableView(
                    "Belum ada buku tersedia",
                    systemImage: "book.closed",
                    description: Text("Tambahkan buku baru")
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            } else {
                List(viewModel.filteredBooks) { book in
                    BookRowView(book: book)
                }
                .listStyle(.plain)
                .refreshable {
                    await viewModel.loadBooks()
                }
            }
        }
        // 🔍 SEARCH BAR → HARUS DI SINI
        .searchable(
            text: $viewModel.searchText,
            prompt: "Cari judul, author, kategori"
        )
        .onChange(of: viewModel.searchText) { _, newValue in
            Task { await viewModel.loadBooks(search: newValue) }
        }
        .onAppear {
            Task { await viewModel.loadBooks() }
        }
        // 🚪 LOGOUT BUTTON → HARUS DI SINI
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        try? await SupabaseService.shared.client.auth.signOut()
                    }
                } label: {
                    Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                }
                .tint(.red)
            }
        }
    }
}
