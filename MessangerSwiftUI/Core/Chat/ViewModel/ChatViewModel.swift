//
//  ChatViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 20.08.2024.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    let user: User
    
    init(user: User) {
        self.user = user
        observeMessages()
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
    
    func observeMessages() {
        MessageService.observeMessages(chatPartner: user) { messages in
            self.messages.append(contentsOf: messages)
        }
    }
}
