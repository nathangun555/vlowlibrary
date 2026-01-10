//
//  UserRole.swift
//  VlowLibrary
//
//  Created by Nathan Gunawan on 09/01/26.
//

import Foundation

enum UserRole: String, Codable {
    case member = "member"
    case staff = "staff"
    
    var tabCount: Int { self == .staff ? 3 : 2 }
    var hasBorrowTab: Bool { self == .staff }
}
