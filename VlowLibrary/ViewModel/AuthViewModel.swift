//
//  AuthViewModel.swift
//  VlowLibrary
//
//  Created by Nathan Gunawan on 10/01/26.
//

import SwiftUI
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var currentUser: User?

    var isLoggedIn: Bool {
        currentUser != nil
    }

    func login(user: User) {
        currentUser = user
    }

    func logout() async {
        try? await SupabaseService.shared.signOut()
        currentUser = nil
    }
}
