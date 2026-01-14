//
//  ContentView.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import SwiftUI

struct ContentView: View {
    let userRole: UserRole
    @State private var selectedTab = 0

    @StateObject private var catalogVM = CatalogViewModel()
    @StateObject private var borrowVM = BorrowViewModel()
    @StateObject private var loansVM: LoansViewModel

    init(userRole: UserRole) {
        self.userRole = userRole
        _loansVM = StateObject(wrappedValue: LoansViewModel(role: userRole))
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            CatalogTabView()
                .environmentObject(catalogVM)
                .tabItem {
                    Label("Katalog", systemImage: "book")
                }
                .tag(0)

            if userRole.hasBorrowTab {
                BorrowTabView()
                    .environmentObject(borrowVM)
                    .tabItem {
                        Label("Pinjam", systemImage: "plus.circle")
                    }
                    .tag(1)
            }

            LoansTabView(role: userRole)
                .environmentObject(loansVM)
                .tabItem {
                    Label("Pinjaman", systemImage: "list.bullet")
                }
                .tag(userRole.hasBorrowTab ? 2 : 1)
        }
        .navigationTitle(selectedTabTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var selectedTabTitle: String {
        switch selectedTab {
        case 0:
            return "📚 Katalog"
        case 1 where userRole.hasBorrowTab:
            return "➕ Pinjam Buku"
        default:
            return "📄 Pinjaman"
        }
    }
}

