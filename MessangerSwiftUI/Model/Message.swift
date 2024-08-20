//
//  Message.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 20.08.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    
    let fromUserId: String
    let toUserId: String
    let messageText: String
    let timestamp: Timestamp
    
    var user: User?
    
    var id : String {
        return messageId ?? UUID().uuidString
    }
    
    var chatPartnerId: String {
        return fromUserId == Auth.auth().currentUser?.uid ? toUserId : fromUserId
    }
    
    var isFromCurrentUser: Bool {
        return fromUserId == Auth.auth().currentUser?.uid
    }
    
}
