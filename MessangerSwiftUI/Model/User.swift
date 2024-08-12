//
//  User.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 12.08.2024.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    let fullname: String
    let email: String
    var profileImageUrl: String?
}

extension User {
    static let MOCK_USER = User(fullname: "Bruce Wayne", email: "batman@mail.com", profileImageUrl: "batman")
}
