//
//  Books.swift
//  VlowLibrary
//
//  Created by Nathan Gunawan on 09/01/26.
//
import Foundation

struct Book: Codable, Identifiable {
    let id: UUID?
    let title: String
    let author: String
    let isbn: String?
    let category: String?
    let available_copies: Bool
}
