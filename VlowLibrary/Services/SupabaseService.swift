//
//  SupabaseService.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
//

import Supabase
import Foundation

@Observable
final class SupabaseService {
    static let shared = SupabaseService()
    
    let client: SupabaseClient
    
    var currentUser: User?
    var loginError: String?
    
    private init() {
        let url = URL(string: "https://srqispetlswskhtrkfdf.supabase.co")!
        let anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNycWlzcGV0bHN3c2todHJrZmRmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc5NjI4ODcsImV4cCI6MjA4MzUzODg4N30.1fHQoiSgzb_KaOVcPfDDPgcpVm1IHhW5TYWa6rB9q90"
        client = SupabaseClient(supabaseURL: url, supabaseKey: anonKey)
    }
    
    func signIn(username: String) async throws -> User {
        let user: User = try await client
            .from("users")
            .select("id, username, role, card_number, name, phone, email, address")
            .eq("username", value: username)
            .single()
            .execute()
            .value

        currentUser = user
        loginError = nil
        return user
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
        currentUser = nil
    }
}

