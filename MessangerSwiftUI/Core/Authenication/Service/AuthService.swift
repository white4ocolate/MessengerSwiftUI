//
//  AuthService.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 13.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        loadCurrentUserData()
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            loadCurrentUserData()
        } catch {
            print(">>>Error: Cant login user beacuse \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, fullname: fullname, id: result.user.uid)
            loadCurrentUserData()
        } catch {
            print(">>>DEBUG: Cant create user beacuse \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
        } catch {
            print(">>>Error: Cant logout user beacuse \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(email: String, fullname: String, id: String) async throws {
        let user = User(fullname: fullname, email: email, profileImageUrl: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
    
    private func loadCurrentUserData() {
        Task {
            try await UserService.shared.fetchCurrentUser()
        }
    }
    
    func deleteUserData() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "User ID not found", code: 0, userInfo: nil)
        }
        let db = Firestore.firestore()
        try await db.collection("users").document(uid).delete()
    }
    
    func deleteUserAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "No current user", code: 0, userInfo: nil)
        }
        try await user.delete()
    }
    
    func deleteAccount() {
        Task {
            try await deleteUserData()
            try await deleteUserAccount()
        }
        signOut()
    }
}
