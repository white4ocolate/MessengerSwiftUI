//
//  User.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 12.08.2024.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(fullname: "Bruce Wayne", email: "batman@mail.com", profileImageUrl: "batman")
}
