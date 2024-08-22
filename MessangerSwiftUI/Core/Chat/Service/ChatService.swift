//
//  ChatService.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 21.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct ChatService {
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MESSAGES_COLLECTION.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = FirestoreConstants.MESSAGES_COLLECTION.document(chatPartnerId).collection(currentUid)
        let lastCurrentUserRef = FirestoreConstants.MESSAGES_COLLECTION.document(currentUid).collection("last-message").document(chatPartnerId)
        let lastPartnerRef = FirestoreConstants.MESSAGES_COLLECTION.document(chatPartnerId).collection("last-message").document(currentUid)
        
        let messageId = currentUserRef.documentID
        let message = Message(messageId: messageId,
                              fromUserId: currentUid,
                              toUserId: chatPartnerId,
                              messageText: messageText,
                              timestamp: Timestamp())
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
        
        lastCurrentUserRef.setData(messageData)
        lastPartnerRef.setData(messageData)
    }
    
    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        let query = FirestoreConstants.MESSAGES_COLLECTION
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            //decode incoming data
            var messages = changes.compactMap ({ try? $0.document.data(as: Message.self) })
            
            for(index, message) in messages.enumerated() where message.fromUserId != currentUid {
                messages[index].user = chatPartner
            }
            completion(messages)
        }
    }
}
