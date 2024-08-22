//
//  InboxService.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 22.08.2024.
//

import Foundation
import FirebaseAuth
import Firebase

class InboxService {
    @Published var documentChanges = [DocumentChange]()
    static let shared = InboxService()
    
    func observeLastMessage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = FirestoreConstants.MESSAGES_COLLECTION
            .document(uid)
            .collection("last-message")
            .order(by: "timestamp", descending: true)
        query.addSnapshotListener { snapshot , _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified }) else { return }
            self.documentChanges = changes
        }
    }
}
