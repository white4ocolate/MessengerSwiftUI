//
//  ActiveNowViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 23.08.2024.
//

import Foundation
import FirebaseAuth

@MainActor
class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            try await fetchAllUsers()
        }
    }
    
    private func fetchAllUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers(limit: 10)
        self.users = users.filter({ $0.id != currentUid })
    }
}
