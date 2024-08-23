//
//  UserService.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 15.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserService {
    @Published var currentUser: User?
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        let query = FirestoreConstants.USERS_COLLECTION
        if let limit { query.limit(to: limit) }
        let snapshot = try await query.getDocuments()
        return snapshot.documents.compactMap { try?  $0.data(as: User.self) }
    }
    
    static func fetchUsers(withUid uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.USERS_COLLECTION.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}
