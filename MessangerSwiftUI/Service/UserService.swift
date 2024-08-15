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
    
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        print(">>>DEBUG: current user in service is \(self.currentUser)")
    }
}
