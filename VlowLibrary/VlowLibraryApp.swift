//
//  VlowLibraryApp.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import SwiftUI

@main
struct VlowLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            RootContentView()
        }
    }
}

struct RootContentView: View {
    @StateObject private var auth = AuthViewModel()

    var body: some View {
        NavigationStack {
            if let user = auth.currentUser {
                ContentView(userRole: user.role)
                    .navigationTitle("Vlow Library")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Logout") {
                                Task {
                                    await auth.logout()
                                }
                            }
                        }
                    }
            } else {
                LoginView()
            }
        }
        .environmentObject(auth)
    }
}
