//
//  ChatViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 20.08.2024.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
}
