//
//  User.swift
//  VlowLibrary
//
//  Created by Nathan Gunawan on 09/01/26.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: UUID?
    let username: String
    let role: UserRole
    let card_number: String
    let name: String
    let phone: String?
    let email: String?
    let address: String?
}

