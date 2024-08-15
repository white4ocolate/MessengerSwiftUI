//
//  NewMessageViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 15.08.2024.
//

import Foundation
import Combine
import FirebaseAuth

class NewMessageViewModel: ObservableObject {
    @Published var users: [User]?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            try await fetchAllUsers()
        }
        
    }
    
    @MainActor
    private func fetchAllUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.uid != currentUid })
    }
}
