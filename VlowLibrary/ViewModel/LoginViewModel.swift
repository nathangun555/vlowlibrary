//
//  LoginViewModel.swift
//  VlowLibrary
//
//  Created by Nathan Gunawan on 09/01/26.
//

import Foundation
import Observation 

@Observable
class LoginViewModel {
    var username = ""
    var isLoading = false
    var errorMessage: String?
    var signedInUser: User?

    private let service = SupabaseService.shared

//    func signIn() async {
//        guard !username.isEmpty else { return }
//
//        isLoading = true
//        errorMessage = nil
//
//        do {
//            signedInUser = try await service.signIn(username: username)
//        } catch {
//            errorMessage = "Username tidak ditemukan"
//        }
//
//        isLoading = false
//    }
    
    func signIn() async {
        if username.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Username tidak boleh kosong"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            signedInUser = try await service.signIn(username: username)
        } catch {
            errorMessage = "Username tidak ditemukan"
        }

        isLoading = false
    }

}
