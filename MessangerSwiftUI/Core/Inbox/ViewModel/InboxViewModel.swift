//
//  InboxViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 15.08.2024.
//

import Foundation
import Combine
import Firebase

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var lastmessages = [Message]()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
        InboxService.shared.observeLastMessage()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        
        InboxService.shared.$documentChanges.sink { [weak self] changes in
            self?.loadInitialMessage(fromChages: changes)
        }.store(in: &cancellables)
    }
    
    private func loadInitialMessage(fromChages changes: [DocumentChange]) {
        var messages = changes.compactMap { try? $0.document.data(as: Message.self)}
        for index in 0..<messages.count {
            let message = messages[index]
            UserService.fetchUsers(withUid: message.chatPartnerId) { user in
                messages[index].user = user
                let documentId = messages[index].messageId
                
                if let existId = self.lastmessages.firstIndex(where: { lm in
                    return lm.messageId == documentId
                }) {
                    self.lastmessages.remove(at: existId)
                }
                
                self.lastmessages.insert(messages[index], at: 0)
            }
        }
    }
}




