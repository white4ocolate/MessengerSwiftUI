//
//  MessageService.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 20.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct MessageService {
    static let messagesCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = user.uid
        
        let currentUserRef = messagesCollection.document(currentUid).collection(chatPartnerId!).document()
        let chatPartnerRef = messagesCollection.document(chatPartnerId!).collection(currentUid)
        let messageId = currentUserRef.documentID
        
        let message = Message(messageId: messageId,
                              fromUserId: currentUid,
                              toUserId: chatPartnerId!,
                              messageText: messageText,
                              timestamp: Timestamp())
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
    }
    
    static func observeMessages(chatPartner: User, completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        let query = messagesCollection
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
